---
url: https://supermemory.ai/docs/integrations/openai
title: OpenAI SDK - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/integrations/openai#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

OpenAI SDK

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [withSupermemory Wrapper](https://supermemory.ai/docs/integrations/openai#withsupermemory-wrapper)
- [Installation](https://supermemory.ai/docs/integrations/openai#installation)
- [Quick Start](https://supermemory.ai/docs/integrations/openai#quick-start)
- [Configuration Options](https://supermemory.ai/docs/integrations/openai#configuration-options)
- [Modes Explained](https://supermemory.ai/docs/integrations/openai#modes-explained)
- [Works with Responses API Too](https://supermemory.ai/docs/integrations/openai#works-with-responses-api-too)
- [Environment Variables](https://supermemory.ai/docs/integrations/openai#environment-variables)
- [Function Calling Tools](https://supermemory.ai/docs/integrations/openai#function-calling-tools)
- [Installation](https://supermemory.ai/docs/integrations/openai#installation-2)
- [Quick Start](https://supermemory.ai/docs/integrations/openai#quick-start-2)
- [Configuration](https://supermemory.ai/docs/integrations/openai#configuration)
- [Memory Tools Configuration](https://supermemory.ai/docs/integrations/openai#memory-tools-configuration)
- [Available Tools](https://supermemory.ai/docs/integrations/openai#available-tools)
- [Search Memories](https://supermemory.ai/docs/integrations/openai#search-memories)
- [Add Memory](https://supermemory.ai/docs/integrations/openai#add-memory)
- [Individual Tools](https://supermemory.ai/docs/integrations/openai#individual-tools)
- [Complete Chat Example](https://supermemory.ai/docs/integrations/openai#complete-chat-example)
- [Error Handling](https://supermemory.ai/docs/integrations/openai#error-handling)
- [API Reference](https://supermemory.ai/docs/integrations/openai#api-reference)
- [Python SDK](https://supermemory.ai/docs/integrations/openai#python-sdk)
- [SupermemoryTools](https://supermemory.ai/docs/integrations/openai#supermemorytools)
- [execute\_memory\_tool\_calls](https://supermemory.ai/docs/integrations/openai#execute_memory_tool_calls)
- [JavaScript SDK](https://supermemory.ai/docs/integrations/openai#javascript-sdk)
- [supermemoryTools](https://supermemory.ai/docs/integrations/openai#supermemorytools-2)
- [createToolCallExecutor](https://supermemory.ai/docs/integrations/openai#createtoolcallexecutor)
- [Environment Variables](https://supermemory.ai/docs/integrations/openai#environment-variables-2)
- [Development](https://supermemory.ai/docs/integrations/openai#development)
- [Python Setup](https://supermemory.ai/docs/integrations/openai#python-setup)
- [JavaScript Setup](https://supermemory.ai/docs/integrations/openai#javascript-setup)
- [Next Steps](https://supermemory.ai/docs/integrations/openai#next-steps)

Add memory capabilities to the official OpenAI SDKs using Supermemory. Two approaches available:

1. **`withSupermemory` wrapper** \- Automatic memory injection into system prompts (zero-config)
2. **Function calling tools** \- Explicit tool calls for search/add memory operations

**New to Supermemory?** Start with `withSupermemory` for the simplest integration. It automatically injects relevant memories into your prompts.

[**Supermemory tools on npm** \\
\\
Check out the NPM page for more details](https://www.npmjs.com/package/@supermemory/tools)

[**Supermemory AI SDK** \\
\\
Check out the PyPI page for more details](https://pypi.org/project/supermemory-openai-sdk/)

* * *

## [​](https://supermemory.ai/docs/integrations/openai\#withsupermemory-wrapper)  withSupermemory Wrapper

The simplest way to add memory to your OpenAI client. Wraps your client to automatically inject relevant memories into system prompts.

### [​](https://supermemory.ai/docs/integrations/openai\#installation)  Installation

```
npm install @supermemory/tools openai
```

### [​](https://supermemory.ai/docs/integrations/openai\#quick-start)  Quick Start

```
import OpenAI from "openai"
import { withSupermemory } from "@supermemory/tools/openai"

const openai = new OpenAI()

// Wrap client with memory - memories auto-injected into system prompts
const client = withSupermemory(openai, "user-123", {
  mode: "full",        // "profile" | "query" | "full"
  addMemory: "always", // "always" | "never"
})

// Use normally - memories are automatically included
const response = await client.chat.completions.create({
  model: "gpt-5",
  messages: [\
    { role: "system", content: "You are a helpful assistant." },\
    { role: "user", content: "What's my favorite programming language?" }\
  ]
})
```

### [​](https://supermemory.ai/docs/integrations/openai\#configuration-options)  Configuration Options

```
const client = withSupermemory(openai, "user-123", {
  // Memory search mode
  mode: "full",  // "profile" (user profile only), "query" (search only), "full" (both)

  // Auto-save conversations as memories
  addMemory: "always",  // "always" | "never"

  // Group messages into conversations
  conversationId: "conv-456",

  // Enable debug logging
  verbose: true,

  // Custom API endpoint
  baseUrl: "https://custom.api.com"
})
```

### [​](https://supermemory.ai/docs/integrations/openai\#modes-explained)  Modes Explained

| Mode | Description | Use Case |
| --- | --- | --- |
| `profile` | Injects user profile (static + dynamic facts) | General personalization |
| `query` | Searches memories based on user message | Question answering |
| `full` | Both profile and query-based search | Best for chatbots |

### [​](https://supermemory.ai/docs/integrations/openai\#works-with-responses-api-too)  Works with Responses API Too

```
const client = withSupermemory(openai, "user-123", { mode: "full" })

// Memories injected into instructions
const response = await client.responses.create({
  model: "gpt-5",
  instructions: "You are a helpful assistant.",
  input: "What do you know about me?"
})
```

### [​](https://supermemory.ai/docs/integrations/openai\#environment-variables)  Environment Variables

```
SUPERMEMORY_API_KEY=your_supermemory_key
OPENAI_API_KEY=your_openai_key
```

* * *

## [​](https://supermemory.ai/docs/integrations/openai\#function-calling-tools)  Function Calling Tools

For explicit control over memory operations, use function calling tools. The model decides when to search or add memories.

## [​](https://supermemory.ai/docs/integrations/openai\#installation-2)  Installation

Python

JavaScript/TypeScript

```
# Using uv (recommended)
uv add supermemory-openai-sdk

# Or with pip
pip install supermemory-openai-sdk
```

## [​](https://supermemory.ai/docs/integrations/openai\#quick-start-2)  Quick Start

Python SDK

JavaScript/TypeScript SDK

```
import asyncio
import openai
from supermemory_openai import SupermemoryTools, execute_memory_tool_calls

async def main():
    # Initialize OpenAI client
    client = openai.AsyncOpenAI(api_key="your-openai-api-key")

    # Initialize Supermemory tools
    tools = SupermemoryTools(
        api_key="your-supermemory-api-key",
        config={"project_id": "my-project"}
    )

    # Chat with memory tools
    response = await client.chat.completions.create(
        model="gpt-5",
        messages=[\
            {\
                "role": "system",\
                "content": "You are a helpful assistant with access to user memories."\
            },\
            {\
                "role": "user",\
                "content": "Remember that I prefer tea over coffee"\
            }\
        ],
        tools=tools.get_tool_definitions()
    )

    # Handle tool calls if present
    if response.choices[0].message.tool_calls:
        tool_results = await execute_memory_tool_calls(
            api_key="your-supermemory-api-key",
            tool_calls=response.choices[0].message.tool_calls,
            config={"project_id": "my-project"}
        )
        print("Tool results:", tool_results)

    print(response.choices[0].message.content)

asyncio.run(main())
```

## [​](https://supermemory.ai/docs/integrations/openai\#configuration)  Configuration

### [​](https://supermemory.ai/docs/integrations/openai\#memory-tools-configuration)  Memory Tools Configuration

Python Configuration

JavaScript Configuration

```
from supermemory_openai import SupermemoryTools

tools = SupermemoryTools(
    api_key="your-supermemory-api-key",
    config={
        "project_id": "my-project",  # or use container_tags
        "base_url": "https://custom-endpoint.com",  # optional
    }
)
```

## [​](https://supermemory.ai/docs/integrations/openai\#available-tools)  Available Tools

### [​](https://supermemory.ai/docs/integrations/openai\#search-memories)  Search Memories

Search through user memories using semantic search:

Python

JavaScript

```
# Search memories
result = await tools.search_memories(
    information_to_get="user preferences",
    limit=10,
    include_full_docs=True
)
print(f"Found {len(result.memories)} memories")
```

### [​](https://supermemory.ai/docs/integrations/openai\#add-memory)  Add Memory

Store new information in memory:

Python

JavaScript

```
# Add memory
result = await tools.add_memory(
    memory="User prefers tea over coffee"
)
print(f"Added memory with ID: {result.memory.id}")
```

## [​](https://supermemory.ai/docs/integrations/openai\#individual-tools)  Individual Tools

Use tools separately for more granular control:

Python Individual Tools

JavaScript Individual Tools

```
from supermemory_openai import (
    create_search_memories_tool,
    create_add_memory_tool
)

search_tool = create_search_memories_tool("your-api-key")
add_tool = create_add_memory_tool("your-api-key")

# Use individual tools in OpenAI function calling
tools_list = [search_tool, add_tool]
```

## [​](https://supermemory.ai/docs/integrations/openai\#complete-chat-example)  Complete Chat Example

Here’s a complete example showing a multi-turn conversation with memory:

Complete Python Example

Complete JavaScript Example

```
import asyncio
import openai
from supermemory_openai import SupermemoryTools, execute_memory_tool_calls

async def chat_with_memory():
    client = openai.AsyncOpenAI()
    tools = SupermemoryTools(
        api_key="your-supermemory-api-key",
        config={"project_id": "chat-example"}
    )

    messages = [\
        {\
            "role": "system",\
            "content": """You are a helpful assistant with memory capabilities.\
            When users share personal information, remember it using addMemory.\
            When they ask questions, search your memories to provide personalized responses."""\
        }\
    ]

    while True:
        user_input = input("You: ")
        if user_input.lower() == 'quit':
            break

        messages.append({"role": "user", "content": user_input})

        # Get AI response with tools
        response = await client.chat.completions.create(
            model="gpt-5",
            messages=messages,
            tools=tools.get_tool_definitions()
        )

        # Handle tool calls
        if response.choices[0].message.tool_calls:
            messages.append(response.choices[0].message)

            tool_results = await execute_memory_tool_calls(
                api_key="your-supermemory-api-key",
                tool_calls=response.choices[0].message.tool_calls,
                config={"project_id": "chat-example"}
            )

            messages.extend(tool_results)

            # Get final response after tool execution
            final_response = await client.chat.completions.create(
                model="gpt-5",
                messages=messages
            )

            assistant_message = final_response.choices[0].message.content
        else:
            assistant_message = response.choices[0].message.content
            messages.append({"role": "assistant", "content": assistant_message})

        print(f"Assistant: {assistant_message}")

# Run the chat
asyncio.run(chat_with_memory())
```

## [​](https://supermemory.ai/docs/integrations/openai\#error-handling)  Error Handling

Handle errors gracefully in your applications:

Python Error Handling

JavaScript Error Handling

```
from supermemory_openai import SupermemoryTools
import openai

async def safe_chat():
    try:
        client = openai.AsyncOpenAI()
        tools = SupermemoryTools(api_key="your-api-key")

        response = await client.chat.completions.create(
            model="gpt-5",
            messages=[{"role": "user", "content": "Hello"}],
            tools=tools.get_tool_definitions()
        )

    except openai.APIError as e:
        print(f"OpenAI API error: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")
```

## [​](https://supermemory.ai/docs/integrations/openai\#api-reference)  API Reference

### [​](https://supermemory.ai/docs/integrations/openai\#python-sdk)  Python SDK

#### [​](https://supermemory.ai/docs/integrations/openai\#supermemorytools)  `SupermemoryTools`

**Constructor**

```
SupermemoryTools(
    api_key: str,
    config: Optional[SupermemoryToolsConfig] = None
)
```

**Methods**

- `get_tool_definitions()` \- Get OpenAI function definitions
- `search_memories(information_to_get, limit, include_full_docs)` \- Search user memories
- `add_memory(memory)` \- Add new memory
- `execute_tool_call(tool_call)` \- Execute individual tool call

#### [​](https://supermemory.ai/docs/integrations/openai\#execute_memory_tool_calls)  `execute_memory_tool_calls`

```
execute_memory_tool_calls(
    api_key: str,
    tool_calls: List[ToolCall],
    config: Optional[SupermemoryToolsConfig] = None
) -> List[dict]
```

### [​](https://supermemory.ai/docs/integrations/openai\#javascript-sdk)  JavaScript SDK

#### [​](https://supermemory.ai/docs/integrations/openai\#supermemorytools-2)  `supermemoryTools`

```
supermemoryTools(
  apiKey: string,
  config?: { projectId?: string; baseUrl?: string }
)
```

#### [​](https://supermemory.ai/docs/integrations/openai\#createtoolcallexecutor)  `createToolCallExecutor`

```
createToolCallExecutor(
  apiKey: string,
  config?: { projectId?: string; baseUrl?: string }
) -> (toolCall: OpenAI.Chat.ChatCompletionMessageToolCall) => Promise<any>
```

## [​](https://supermemory.ai/docs/integrations/openai\#environment-variables-2)  Environment Variables

Set these environment variables:

```
SUPERMEMORY_API_KEY=your_supermemory_key
OPENAI_API_KEY=your_openai_key
SUPERMEMORY_BASE_URL=https://custom-endpoint.com  # optional
```

## [​](https://supermemory.ai/docs/integrations/openai\#development)  Development

### [​](https://supermemory.ai/docs/integrations/openai\#python-setup)  Python Setup

```
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Setup project
git clone <repository-url>
cd packages/openai-sdk-python
uv sync --dev

# Run tests
uv run pytest

# Type checking
uv run mypy src/supermemory_openai

# Formatting
uv run black src/ tests/
uv run isort src/ tests/
```

### [​](https://supermemory.ai/docs/integrations/openai\#javascript-setup)  JavaScript Setup

```
# Install dependencies
npm install

# Run tests
npm test

# Type checking
npm run type-check

# Linting
npm run lint
```

## [​](https://supermemory.ai/docs/integrations/openai\#next-steps)  Next Steps

[**AI SDK Integration** \\
\\
Use with Vercel AI SDK for streamlined development](https://supermemory.ai/docs/integrations/ai-sdk)

[**Memory API** \\
\\
Direct API access for advanced memory management](https://supermemory.ai/docs/memory-api/overview)

Was this page helpful?

YesNo

[Vercel AI SDK](https://supermemory.ai/docs/integrations/ai-sdk) [LangGraph](https://supermemory.ai/docs/integrations/langgraph)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)