---
url: https://supermemory.ai/docs/integrations/langchain
title: LangChain - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/integrations/langchain#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

LangChain

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Overview](https://supermemory.ai/docs/integrations/langchain#overview)
- [Setup](https://supermemory.ai/docs/integrations/langchain#setup)
- [Basic Integration](https://supermemory.ai/docs/integrations/langchain#basic-integration)
- [Core Concepts](https://supermemory.ai/docs/integrations/langchain#core-concepts)
- [User Profiles](https://supermemory.ai/docs/integrations/langchain#user-profiles)
- [Memory Storage](https://supermemory.ai/docs/integrations/langchain#memory-storage)
- [Memory Search](https://supermemory.ai/docs/integrations/langchain#memory-search)
- [Complete Example: Code Review Assistant](https://supermemory.ai/docs/integrations/langchain#complete-example-code-review-assistant)
- [Advanced Patterns](https://supermemory.ai/docs/integrations/langchain#advanced-patterns)
- [Conversation History with Memory](https://supermemory.ai/docs/integrations/langchain#conversation-history-with-memory)
- [Metadata Filtering](https://supermemory.ai/docs/integrations/langchain#metadata-filtering)
- [Batch Memory Operations](https://supermemory.ai/docs/integrations/langchain#batch-memory-operations)
- [Next Steps](https://supermemory.ai/docs/integrations/langchain#next-steps)

Build AI applications with LangChain that remember context across conversations. Supermemory handles memory storage, retrieval, and user profiling while LangChain manages your conversation flow.

## [​](https://supermemory.ai/docs/integrations/langchain\#overview)  Overview

This guide shows how to integrate Supermemory with LangChain to create AI agents that:

- Maintain user context through automatic profiling
- Store and retrieve relevant memories semantically
- Personalize responses based on conversation history

## [​](https://supermemory.ai/docs/integrations/langchain\#setup)  Setup

Install the required packages:

```
pip install langchain langchain-openai supermemory python-dotenv
```

Configure your environment:

```
# .env
SUPERMEMORY_API_KEY=your-supermemory-api-key
OPENAI_API_KEY=your-openai-api-key
```

Get your Supermemory API key from [console.supermemory.ai](https://console.supermemory.ai/).

## [​](https://supermemory.ai/docs/integrations/langchain\#basic-integration)  Basic Integration

Initialize both clients and set up a simple chat function with memory:

```
import os
from langchain_openai import ChatOpenAI
from langchain_core.messages import SystemMessage, HumanMessage
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from supermemory import Supermemory
from dotenv import load_dotenv

load_dotenv()

# Initialize clients
llm = ChatOpenAI(model="gpt-4o")
memory = Supermemory()

def chat(user_id: str, message: str) -> str:
    # 1. Get user profile for context
    profile_result = memory.profile(container_tag=user_id, q=message)

    # 2. Build context from profile
    static_facts = profile_result.profile.static or []
    dynamic_context = profile_result.profile.dynamic or []
    search_results = profile_result.search_results.results if profile_result.search_results else []

    context = f"""
User Background:
{chr(10).join(static_facts) if static_facts else 'No profile yet.'}

Recent Context:
{chr(10).join(dynamic_context) if dynamic_context else 'No recent activity.'}

Relevant Memories:
{chr(10).join([r.memory or r.chunk for r in search_results]) if search_results else 'None found.'}
"""

    # 3. Generate response
    prompt = ChatPromptTemplate.from_messages([\
        SystemMessage(content=f"You are a helpful assistant. Use this context to personalize your response:\n{context}"),\
        HumanMessage(content=message)\
    ])

    chain = prompt | llm
    response = chain.invoke({})

    # 4. Store the interaction as memory
    memory.add(
        content=f"User: {message}\nAssistant: {response.content}",
        container_tag=user_id
    )

    return response.content
```

* * *

## [​](https://supermemory.ai/docs/integrations/langchain\#core-concepts)  Core Concepts

### [​](https://supermemory.ai/docs/integrations/langchain\#user-profiles)  User Profiles

Supermemory automatically maintains user profiles with two types of information:

- **Static facts**: Long-term information about the user (preferences, expertise, background)
- **Dynamic context**: Recent activity and current focus areas

```
# Fetch profile with optional search
result = memory.profile(
    container_tag="user_123",
    q="optional search query"  # Also returns relevant memories
)

print(result.profile.static)   # ["User is a Python developer", "Prefers dark mode"]
print(result.profile.dynamic)  # ["Currently working on API integration", "Debugging auth issues"]
```

### [​](https://supermemory.ai/docs/integrations/langchain\#memory-storage)  Memory Storage

Content you add is automatically processed into searchable memories:

```
# Store a conversation
memory.add(
    content="User asked about async Python patterns. Explained asyncio basics.",
    container_tag="user_123",
    metadata={"topic": "python", "type": "conversation"}
)

# Store a document
memory.add(
    content="https://docs.python.org/3/library/asyncio.html",
    container_tag="user_123"
)
```

### [​](https://supermemory.ai/docs/integrations/langchain\#memory-search)  Memory Search

Search returns both extracted memories and document chunks:

```
results = memory.search.memories(
    q="async programming",
    container_tag="user_123",
    search_mode="hybrid",  # Searches memories + document chunks
    limit=5
)

for r in results.results:
    print(r.memory or r.chunk, r.similarity)
```

* * *

## [​](https://supermemory.ai/docs/integrations/langchain\#complete-example-code-review-assistant)  Complete Example: Code Review Assistant

Here’s a full example of a code review assistant that learns from past reviews and adapts to the user’s coding style:

````
import os
from typing import Optional
from langchain_openai import ChatOpenAI
from langchain_core.messages import SystemMessage, HumanMessage, AIMessage
from langchain_core.prompts import ChatPromptTemplate
from supermemory import Supermemory
from dotenv import load_dotenv

load_dotenv()

class CodeReviewAssistant:
    def __init__(self):
        self.llm = ChatOpenAI(model="gpt-4o", temperature=0.3)
        self.memory = Supermemory()

    def get_context(self, user_id: str, code: str) -> str:
        """Retrieve user profile and relevant past reviews."""
        # Get profile with search for similar code patterns
        result = self.memory.profile(
            container_tag=user_id,
            q=code[:500],  # Use code snippet for semantic search
            threshold=0.6
        )

        static = result.profile.static or []
        dynamic = result.profile.dynamic or []
        memories = result.search_results.results if result.search_results else []

        return f"""
## Developer Profile
{chr(10).join(f"- {fact}" for fact in static) if static else "New developer, no profile yet."}

## Current Focus
{chr(10).join(f"- {ctx}" for ctx in dynamic) if dynamic else "No recent context."}

## Relevant Past Reviews
{chr(10).join(f"- {m.memory}" for m in memories[:3]) if memories else "No similar reviews found."}
"""

    def review(self, user_id: str, code: str, language: Optional[str] = None) -> str:
        """Review code with personalized feedback."""
        context = self.get_context(user_id, code)

        prompt = ChatPromptTemplate.from_messages([\
            SystemMessage(content=f"""You are a code review assistant. Provide constructive feedback\
tailored to the developer's experience level and preferences.\
\
{context}\
\
Guidelines:\
- Reference past feedback when relevant patterns appear\
- Adapt explanation depth to the developer's expertise\
- Focus on issues that matter most to this developer"""),\
            HumanMessage(content=f"Review this {language or 'code'}:\n\n```\n{code}\n```")\
        ])

        chain = prompt | self.llm
        response = chain.invoke({})

        # Store the review for future context
        self.memory.add(
            content=f"Code review feedback: {response.content[:500]}",
            container_tag=user_id,
            metadata={"type": "code_review", "language": language}
        )

        return response.content

    def learn_preference(self, user_id: str, preference: str):
        """Store a coding preference or style guideline."""
        self.memory.add(
            content=f"Developer preference: {preference}",
            container_tag=user_id,
            metadata={"type": "preference"}
        )

# Usage
if __name__ == "__main__":
    assistant = CodeReviewAssistant()
    user_id = "dev_alice"

    # Teach the assistant about preferences
    assistant.learn_preference(user_id, "Prefers functional programming patterns")
    assistant.learn_preference(user_id, "Values descriptive variable names over comments")

    # Review some code
    code = """
def calc(x, y):
    r = []
    for i in x:
        if i in y:
            r.append(i)
    return r
    """

    review = assistant.review(user_id, code, language="python")
    print(review)
````

* * *

## [​](https://supermemory.ai/docs/integrations/langchain\#advanced-patterns)  Advanced Patterns

### [​](https://supermemory.ai/docs/integrations/langchain\#conversation-history-with-memory)  Conversation History with Memory

Maintain multi-turn conversations while building long-term memory:

```
from langchain_core.messages import BaseMessage

class ConversationalAgent:
    def __init__(self, user_id: str):
        self.user_id = user_id
        self.llm = ChatOpenAI(model="gpt-4o")
        self.memory = Supermemory()
        self.messages: list[BaseMessage] = []

    def _build_system_prompt(self, query: str) -> str:
        """Build system prompt with user context."""
        result = self.memory.profile(
            container_tag=self.user_id,
            q=query,
            threshold=0.5
        )

        profile = result.profile
        memories = result.search_results.results if result.search_results else []

        return f"""You are a helpful assistant with memory of past conversations.

About this user:
{chr(10).join(profile.static) if profile.static else 'No profile yet.'}

Current context:
{chr(10).join(profile.dynamic) if profile.dynamic else 'No recent context.'}

Relevant memories:
{chr(10).join(m.memory or m.chunk for m in memories[:5]) if memories else 'None.'}

Use this context to provide personalized, contextual responses."""

    def chat(self, message: str) -> str:
        """Process a message and return response."""
        # Add user message to conversation
        self.messages.append(HumanMessage(content=message))

        # Build prompt with memory context
        system = SystemMessage(content=self._build_system_prompt(message))

        # Generate response
        response = self.llm.invoke([system] + self.messages)
        self.messages.append(response)

        # Store interaction for long-term memory
        self.memory.add(
            content=f"User: {message}\nAssistant: {response.content}",
            container_tag=self.user_id
        )

        return response.content

    def clear_session(self):
        """Clear conversation but keep long-term memory."""
        self.messages = []
```

### [​](https://supermemory.ai/docs/integrations/langchain\#metadata-filtering)  Metadata Filtering

Use metadata to organize and filter memories:

```
# Store with metadata
memory.add(
    content="Discussed React hooks and state management",
    container_tag="user_123",
    metadata={
        "topic": "react",
        "type": "discussion",
        "project": "frontend-redesign"
    }
)

# Search with filters
results = memory.search.memories(
    q="state management",
    container_tag="user_123",
    filters={
        "AND": [\
            {"key": "topic", "value": "react"},\
            {"key": "project", "value": "frontend-redesign"}\
        ]
    }
)
```

### [​](https://supermemory.ai/docs/integrations/langchain\#batch-memory-operations)  Batch Memory Operations

Efficiently store multiple memories:

```
# Store meeting notes as separate memories
notes = [\
    "Decided to use PostgreSQL for the new service",\
    "Timeline: MVP ready by end of Q2",\
    "Alice will lead the database migration"\
]

for note in notes:
    memory.add(
        content=note,
        container_tag="team_standup",
        metadata={"date": "2024-01-15", "type": "decision"}
    )
```

* * *

## [​](https://supermemory.ai/docs/integrations/langchain\#next-steps)  Next Steps

[**User Profiles** \\
\\
Deep dive into automatic user profiling](https://supermemory.ai/docs/user-profiles)

[**Search API** \\
\\
Advanced search patterns and filtering](https://supermemory.ai/docs/search)

[**OpenAI SDK** \\
\\
Native OpenAI integration with memory tools](https://supermemory.ai/docs/integrations/openai)

[**Vercel AI SDK** \\
\\
Memory middleware for Next.js apps](https://supermemory.ai/docs/integrations/ai-sdk)

Was this page helpful?

YesNo

[Mastra](https://supermemory.ai/docs/integrations/mastra) [CrewAI](https://supermemory.ai/docs/integrations/crewai)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)