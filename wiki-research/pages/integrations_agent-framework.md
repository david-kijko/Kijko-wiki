---
url: https://supermemory.ai/docs/integrations/agent-framework
title: Microsoft Agent Framework - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/integrations/agent-framework#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Microsoft Agent Framework

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [What you can do](https://supermemory.ai/docs/integrations/agent-framework#what-you-can-do)
- [Setup](https://supermemory.ai/docs/integrations/agent-framework#setup)
- [Connection](https://supermemory.ai/docs/integrations/agent-framework#connection)
- [Connection options](https://supermemory.ai/docs/integrations/agent-framework#connection-options)
- [Context provider (recommended)](https://supermemory.ai/docs/integrations/agent-framework#context-provider-recommended)
- [How it works](https://supermemory.ai/docs/integrations/agent-framework#how-it-works)
- [Configuration options](https://supermemory.ai/docs/integrations/agent-framework#configuration-options)
- [Memory tools](https://supermemory.ai/docs/integrations/agent-framework#memory-tools)
- [Available tools](https://supermemory.ai/docs/integrations/agent-framework#available-tools)
- [Chat middleware](https://supermemory.ai/docs/integrations/agent-framework#chat-middleware)
- [Memory modes](https://supermemory.ai/docs/integrations/agent-framework#memory-modes)
- [Example: support agent with memory](https://supermemory.ai/docs/integrations/agent-framework#example-support-agent-with-memory)
- [Error handling](https://supermemory.ai/docs/integrations/agent-framework#error-handling)
- [Related docs](https://supermemory.ai/docs/integrations/agent-framework#related-docs)

Microsoft’s [Agent Framework](https://github.com/microsoft/agent-framework) is a Python framework for building AI agents with tools, handoffs, and context providers. Supermemory integrates natively as a context provider, tool set, or middleware — so your agents remember users across sessions.

## [​](https://supermemory.ai/docs/integrations/agent-framework\#what-you-can-do)  What you can do

- Automatically inject user memories before every agent run (context provider)
- Give agents tools to search and store memories on their own
- Intercept chat requests to add memory context via middleware
- Combine all three for maximum flexibility

## [​](https://supermemory.ai/docs/integrations/agent-framework\#setup)  Setup

Install the package:

```
pip install --pre supermemory-agent-framework
```

Or with uv:

```
uv add --prerelease=allow supermemory-agent-framework
```

The `--pre` / `--prerelease=allow` flag is required because `agent-framework-core` depends on pre-release versions of Azure packages.

Set up your environment:

```
# .env
SUPERMEMORY_API_KEY=your-supermemory-api-key
OPENAI_API_KEY=your-openai-api-key
```

Get your Supermemory API key from [console.supermemory.ai](https://console.supermemory.ai/).

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#connection)  Connection

All integration points share a single `AgentSupermemory` connection. This ensures the same API client, container tag, and conversation ID are used across middleware, tools, and context providers.

```
from supermemory_agent_framework import AgentSupermemory

conn = AgentSupermemory(
    api_key="your-supermemory-api-key",  # or set SUPERMEMORY_API_KEY env var
    container_tag="user-123",            # memory scope (e.g., user ID)
    conversation_id="session-abc",       # optional, auto-generated if omitted
    entity_context="The user is a Python developer.",  # optional
)
```

### [​](https://supermemory.ai/docs/integrations/agent-framework\#connection-options)  Connection options

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `api_key` | `str` | env var | Supermemory API key. Falls back to `SUPERMEMORY_API_KEY` |
| `container_tag` | `str` | `"msft_agent_chat"` | Memory scope (e.g., user ID) |
| `conversation_id` | `str` | auto-generated | Groups messages into a conversation |
| `entity_context` | `str` | `None` | Custom context about the user, prepended to memories |

Pass this connection to any integration:

```
middleware = SupermemoryChatMiddleware(conn, options=...)
tools = SupermemoryTools(conn)
provider = SupermemoryContextProvider(conn, mode="full")
```

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#context-provider-recommended)  Context provider (recommended)

The most idiomatic integration. Follows the same pattern as Agent Framework’s built-in Mem0 provider — memories are automatically fetched before the LLM runs and conversations can be stored afterward.

```
import asyncio
from agent_framework import AgentSession
from agent_framework.openai import OpenAIResponsesClient
from supermemory_agent_framework import AgentSupermemory, SupermemoryContextProvider

async def main():
    conn = AgentSupermemory(container_tag="user-123")

    provider = SupermemoryContextProvider(conn, mode="full")

    agent = OpenAIResponsesClient().as_agent(
        name="MemoryAgent",
        instructions="You are a helpful assistant with memory.",
        context_providers=[provider],
    )

    session = AgentSession()
    response = await agent.run(
        "What's my favorite programming language?",
        session=session,
    )
    print(response.text)

asyncio.run(main())
```

### [​](https://supermemory.ai/docs/integrations/agent-framework\#how-it-works)  How it works

1. **`before_run()`** — Searches Supermemory for the user’s profile and relevant memories, then injects them into the session context as additional instructions
2. **`after_run()`** — If `store_conversations=True`, saves the conversation to Supermemory so future sessions have more context

### [​](https://supermemory.ai/docs/integrations/agent-framework\#configuration-options)  Configuration options

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `connection` | `AgentSupermemory` | required | Shared connection |
| `mode` | `str` | `"full"` | `"profile"`, `"query"`, or `"full"` |
| `store_conversations` | `bool` | `False` | Save conversations after each run |
| `context_prompt` | `str` | built-in | Custom prompt describing the memories |
| `verbose` | `bool` | `False` | Enable detailed logging |

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#memory-tools)  Memory tools

Give agents explicit control over memory operations. The agent decides when to search or store information.

```
import asyncio
from agent_framework.openai import OpenAIResponsesClient
from supermemory_agent_framework import AgentSupermemory, SupermemoryTools

async def main():
    conn = AgentSupermemory(container_tag="user-123")
    tools = SupermemoryTools(conn)

    agent = OpenAIResponsesClient().as_agent(
        name="MemoryAgent",
        instructions="""You are a helpful assistant with memory.
When users share preferences, save them. When they ask questions, search memories first.""",
    )

    response = await agent.run(
        "Remember that I prefer Python over JavaScript",
        tools=tools.get_tools(),
    )
    print(response.text)

asyncio.run(main())
```

### [​](https://supermemory.ai/docs/integrations/agent-framework\#available-tools)  Available tools

The agent gets three tools:

- **`search_memories`** — Search for relevant memories by query
- **`add_memory`** — Store new information for later recall
- **`get_profile`** — Fetch the user’s full profile (static + dynamic facts)

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#chat-middleware)  Chat middleware

Intercept chat requests to automatically inject memory context. Useful when you want memory injection without the session-based context provider pattern.

```
import asyncio
from agent_framework.openai import OpenAIResponsesClient
from supermemory_agent_framework import (
    AgentSupermemory,
    SupermemoryChatMiddleware,
    SupermemoryMiddlewareOptions,
)

async def main():
    conn = AgentSupermemory(container_tag="user-123")

    middleware = SupermemoryChatMiddleware(
        conn,
        options=SupermemoryMiddlewareOptions(
            mode="full",
            add_memory="always",
        ),
    )

    agent = OpenAIResponsesClient().as_agent(
        name="MemoryAgent",
        instructions="You are a helpful assistant.",
        middleware=[middleware],
    )

    response = await agent.run("What's my favorite programming language?")
    print(response.text)

asyncio.run(main())
```

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#memory-modes)  Memory modes

```
SupermemoryContextProvider(conn, mode="full")  # or "profile" / "query"
```

| Mode | What it fetches | Best for |
| --- | --- | --- |
| `"profile"` | User profile (static + dynamic facts) only | Personalization without query overhead |
| `"query"` | Memories relevant to the current message only | Targeted recall, no profile data |
| `"full"` (default) | Profile + query search combined | Maximum context |

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#example-support-agent-with-memory)  Example: support agent with memory

A support agent that remembers customers across sessions:

```
import asyncio
from agent_framework import AgentSession
from agent_framework.openai import OpenAIResponsesClient
from supermemory_agent_framework import (
    AgentSupermemory,
    SupermemoryChatMiddleware,
    SupermemoryMiddlewareOptions,
    SupermemoryContextProvider,
    SupermemoryTools,
)

async def main():
    conn = AgentSupermemory(
        container_tag="customer-456",
        conversation_id="support-session-789",
        entity_context="Enterprise customer on the Pro plan.",
    )

    provider = SupermemoryContextProvider(
        conn,
        mode="full",
        store_conversations=True,
    )

    middleware = SupermemoryChatMiddleware(
        conn,
        options=SupermemoryMiddlewareOptions(
            mode="full",
            add_memory="always",
        ),
    )

    tools = SupermemoryTools(conn)

    agent = OpenAIResponsesClient().as_agent(
        name="SupportAgent",
        instructions="""You are a customer support agent.

Use the user context provided to personalize your responses.
Reference past interactions when relevant.
Save important new information about the customer.""",
        context_providers=[provider],
        middleware=[middleware],
    )

    session = AgentSession()

    # First interaction
    response = await agent.run(
        "My order hasn't arrived yet. Order ID is ORD-789.",
        session=session,
        tools=tools.get_tools(),
    )
    print(response.text)

    # Follow-up — agent automatically has context from first message
    response = await agent.run(
        "Actually, can you also check my previous order?",
        session=session,
        tools=tools.get_tools(),
    )
    print(response.text)

asyncio.run(main())
```

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#error-handling)  Error handling

The package provides specific exception types:

```
from supermemory_agent_framework import (
    AgentSupermemory,
    SupermemoryConfigurationError,
    SupermemoryAPIError,
    SupermemoryNetworkError,
)

try:
    conn = AgentSupermemory()  # no API key set
except SupermemoryConfigurationError as e:
    print(f"Missing API key: {e}")
```

| Exception | When |
| --- | --- |
| `SupermemoryConfigurationError` | Missing API key or invalid config |
| `SupermemoryAPIError` | API returned an error response |
| `SupermemoryNetworkError` | Connection failure |
| `SupermemoryTimeoutError` | Request timed out |
| `SupermemoryMemoryOperationError` | Memory add/search failed |

* * *

## [​](https://supermemory.ai/docs/integrations/agent-framework\#related-docs)  Related docs

[**User profiles** \\
\\
How automatic profiling works](https://supermemory.ai/docs/user-profiles)

[**Search** \\
\\
Filtering and search modes](https://supermemory.ai/docs/search)

[**OpenAI Agents SDK** \\
\\
Memory for OpenAI Agents SDK](https://supermemory.ai/docs/integrations/openai-agents-sdk)

[**LangChain** \\
\\
Memory for LangChain apps](https://supermemory.ai/docs/integrations/langchain)

Was this page helpful?

YesNo

[OpenAI Agents SDK](https://supermemory.ai/docs/integrations/openai-agents-sdk) [Mastra](https://supermemory.ai/docs/integrations/mastra)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)