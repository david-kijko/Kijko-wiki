---
url: https://supermemory.ai/docs/cookbook/personal-assistant
title: Personal AI Assistant - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/cookbook/personal-assistant#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Quick Start Recipes

Personal AI Assistant

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [What You’ll Build](https://supermemory.ai/docs/cookbook/personal-assistant#what-you%E2%80%99ll-build)
- [Choose Your Implementation](https://supermemory.ai/docs/cookbook/personal-assistant#choose-your-implementation)
- [Prerequisites](https://supermemory.ai/docs/cookbook/personal-assistant#prerequisites)
- [Python Implementation](https://supermemory.ai/docs/cookbook/personal-assistant#python-implementation)
- [Step 1: Project Setup](https://supermemory.ai/docs/cookbook/personal-assistant#step-1-project-setup)
- [Step 2: Backend (FastAPI)](https://supermemory.ai/docs/cookbook/personal-assistant#step-2-backend-fastapi)
- [Import Dependencies](https://supermemory.ai/docs/cookbook/personal-assistant#import-dependencies)
- [Initialize Application and Clients](https://supermemory.ai/docs/cookbook/personal-assistant#initialize-application-and-clients)
- [Define System Prompt](https://supermemory.ai/docs/cookbook/personal-assistant#define-system-prompt)
- [Create Identity Helpers](https://supermemory.ai/docs/cookbook/personal-assistant#create-identity-helpers)
- [Memory Search Function](https://supermemory.ai/docs/cookbook/personal-assistant#memory-search-function)
- [Memory Storage Function](https://supermemory.ai/docs/cookbook/personal-assistant#memory-storage-function)
- [Main Chat Endpoint](https://supermemory.ai/docs/cookbook/personal-assistant#main-chat-endpoint)
- [Derive User Identity](https://supermemory.ai/docs/cookbook/personal-assistant#derive-user-identity)
- [Search and Inject Memories](https://supermemory.ai/docs/cookbook/personal-assistant#search-and-inject-memories)
- [Stream OpenAI Response](https://supermemory.ai/docs/cookbook/personal-assistant#stream-openai-response)
- [Handle Streaming](https://supermemory.ai/docs/cookbook/personal-assistant#handle-streaming)
- [Optional Memory Storage](https://supermemory.ai/docs/cookbook/personal-assistant#optional-memory-storage)
- [Return Streaming Response](https://supermemory.ai/docs/cookbook/personal-assistant#return-streaming-response)
- [Local Development Server](https://supermemory.ai/docs/cookbook/personal-assistant#local-development-server)
- [Step 3: Frontend (Streamlit)](https://supermemory.ai/docs/cookbook/personal-assistant#step-3-frontend-streamlit)
- [Step 4: Run It](https://supermemory.ai/docs/cookbook/personal-assistant#step-4-run-it)
- [TypeScript Implementation](https://supermemory.ai/docs/cookbook/personal-assistant#typescript-implementation)
- [Step 1: Project Setup](https://supermemory.ai/docs/cookbook/personal-assistant#step-1-project-setup-2)
- [Step 2: API Route](https://supermemory.ai/docs/cookbook/personal-assistant#step-2-api-route)
- [Import Dependencies](https://supermemory.ai/docs/cookbook/personal-assistant#import-dependencies-2)
- [Initialize OpenAI Provider](https://supermemory.ai/docs/cookbook/personal-assistant#initialize-openai-provider)
- [Define System Prompt](https://supermemory.ai/docs/cookbook/personal-assistant#define-system-prompt-2)
- [Create POST Handler](https://supermemory.ai/docs/cookbook/personal-assistant#create-post-handler)
- [Validate Input](https://supermemory.ai/docs/cookbook/personal-assistant#validate-input)
- [Create Container Tag](https://supermemory.ai/docs/cookbook/personal-assistant#create-container-tag)
- [Call streamText with Tools](https://supermemory.ai/docs/cookbook/personal-assistant#call-streamtext-with-tools)
- [Return Streaming Response](https://supermemory.ai/docs/cookbook/personal-assistant#return-streaming-response-2)
- [Error Handling](https://supermemory.ai/docs/cookbook/personal-assistant#error-handling)
- [Step 3: Chat UI](https://supermemory.ai/docs/cookbook/personal-assistant#step-3-chat-ui)
- [Step 4: Run It](https://supermemory.ai/docs/cookbook/personal-assistant#step-4-run-it-2)
- [Testing Your Assistant](https://supermemory.ai/docs/cookbook/personal-assistant#testing-your-assistant)
- [Verify Memory Storage](https://supermemory.ai/docs/cookbook/personal-assistant#verify-memory-storage)
- [Python](https://supermemory.ai/docs/cookbook/personal-assistant#python)
- [TypeScript](https://supermemory.ai/docs/cookbook/personal-assistant#typescript)
- [Troubleshooting](https://supermemory.ai/docs/cookbook/personal-assistant#troubleshooting)

Build a personal AI assistant that learns and remembers everything about the user - their preferences, habits, work context, and conversation history.

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#what-you%E2%80%99ll-build)  What You’ll Build

A personal AI assistant that:

- **Remembers user preferences** (dietary restrictions, work schedule, communication style)
- **Maintains context** across multiple chat sessions
- **Provides personalized recommendations** based on user history
- **Handles multiple conversation topics** while maintaining context

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#choose-your-implementation)  Choose Your Implementation

[**Python + FastAPI** \\
\\
Thoroughly tested, production-ready. Uses FastAPI + Streamlit + OpenAI.](https://supermemory.ai/docs/cookbook/personal-assistant#python-implementation)

[**TypeScript + AI SDK** \\
\\
Modern React approach. Uses Next.js + Vercel AI SDK + Supermemory tools.](https://supermemory.ai/docs/cookbook/personal-assistant#typescript-implementation)

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#prerequisites)  Prerequisites

- **Python 3.8+** or **Node.js 18+**
- **Supermemory API key** ( [get one here](https://console.supermemory.ai/))
- **OpenAI API key** ( [get one here](https://platform.openai.com/api-keys))

Never hardcode API keys in your code. Use environment variables.

* * *

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#python-implementation)  Python Implementation

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-1-project-setup)  Step 1: Project Setup

```
mkdir personal-ai && cd personal-ai
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install supermemory openai fastapi uvicorn python-dotenv streamlit requests
```

Create a `.env` file:

```
SUPERMEMORY_API_KEY=your_supermemory_key_here
OPENAI_API_KEY=your_openai_key_here
```

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-2-backend-fastapi)  Step 2: Backend (FastAPI)

Create `main.py`. Let’s build it step by step:

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#import-dependencies)  Import Dependencies

```
from fastapi import FastAPI, HTTPException
from fastapi.responses import StreamingResponse
from openai import AsyncOpenAI
from supermemory import Supermemory
import json
import os
import uuid
from dotenv import load_dotenv
```

- **FastAPI**: Web framework for building the API endpoint
- **StreamingResponse**: Enables real-time response streaming (words appear as they’re generated)
- **AsyncOpenAI**: OpenAI client that supports async/await for non-blocking operations
- **Supermemory**: Client for storing and retrieving long-term memories
- **uuid**: Creates stable, deterministic user IDs from emails

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#initialize-application-and-clients)  Initialize Application and Clients

```
load_dotenv()
app = FastAPI()

openai_client = AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY"))
supermemory_client = Supermemory(api_key=os.getenv("SUPERMEMORY_API_KEY"))
```

`load_dotenv()` loads API keys from your `.env` file into environment variables. We create two clients:

- **OpenAI client**: Handles conversations and generates responses
- **Supermemory client**: Stores and retrieves user-specific memories

These are separate because you can swap providers independently (e.g., switch from OpenAI to Anthropic without changing memory logic).

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#define-system-prompt)  Define System Prompt

```
SYSTEM_PROMPT = """You are a highly personalized AI assistant.

MEMORY MANAGEMENT:
1. When users share personal information, store it immediately
2. Search for relevant context before responding
3. Use past conversations to inform current responses

Always be helpful while respecting privacy."""
```

This prompt guides the assistant’s behavior. It tells the AI to:

- Be proactive about learning user preferences
- Always search memory before responding
- Respect privacy boundaries

The system prompt is injected at the start of every conversation, so the AI consistently follows these rules.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#create-identity-helpers)  Create Identity Helpers

```
def normalize_email(email: str) -> str:
    return (email or "").strip().lower()

def stable_user_id_from_email(email: str) -> str:
    norm = normalize_email(email)
    if not norm:
        raise ValueError("Email is required")
    return uuid.uuid5(uuid.NAMESPACE_DNS, norm).hex
```

**Why normalize?**`"User@Mail.com"` and `" user@mail.com "` should map to the same person. We trim whitespace and lowercase to ensure consistency.**Why UUIDv5?** It’s deterministic—same email always produces the same ID. This means:

- User memories persist across sessions
- No raw emails in logs or database tags
- Privacy-preserving yet stable identity

We use `uuid.NAMESPACE_DNS` as the namespace to ensure uniqueness.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#memory-search-function)  Memory Search Function

```
async def search_user_memories(query: str, container_tag: str) -> str:
    try:
        results = supermemory_client.search.memories(
            q=query,
            container_tag=container_tag,
            limit=5
        )
        if results.results:
            context = "\n".join([r.memory for r in results.results])
            return f"Relevant memories:\n{context}"
        return "No relevant memories found."
    except Exception as e:
        return f"Error searching memories: {e}"
```

This searches the user’s memory store for context relevant to their current message.**Parameters:**

- `q`: The search query (usually the user’s latest message)
- `container_tag`: Isolates memories per user (e.g., `user_abc123`)
- `limit=5`: Returns top 5 most relevant memories

**Why search before responding?** The AI can provide personalized answers based on what it knows about the user (e.g., dietary preferences, work context, communication style).**Error handling:** If memory search fails, we return a fallback message instead of crashing. The conversation continues even if memory has a hiccup.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#memory-storage-function)  Memory Storage Function

```
async def add_user_memory(content: str, container_tag: str, email: str = None):
    try:
        supermemory_client.add(
            content=content,
            container_tag=container_tag,
            metadata={"type": "personal_info", "email": normalize_email(email) if email else None}
        )
    except Exception as e:
        print(f"Error adding memory: {e}")
```

Stores new information about the user.**Parameters:**

- `content`: The text to remember
- `container_tag`: User isolation tag
- `metadata`: Additional context (type of info, associated email)

**Why metadata?** Makes it easier to filter and organize memories later (e.g., “show me all personal\_info memories”).**Error handling:** We log errors but don’t crash. Failing to save one memory shouldn’t break the entire conversation.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#main-chat-endpoint)  Main Chat Endpoint

```
@app.post("/chat")
async def chat_endpoint(data: dict):
    messages = data.get("messages", [])
    email = data.get("email")

    if not messages:
        raise HTTPException(status_code=400, detail="No messages provided")
    if not email:
        raise HTTPException(status_code=400, detail="Email required")
```

This endpoint receives the chat request. It expects:

- `messages`: Full conversation history `[{role: "user", content: "..."}]`
- `email`: User’s email for identity

**Why require email?** Without it, we can’t create a stable user ID, meaning no persistent personalization.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#derive-user-identity)  Derive User Identity

```
    try:
        user_id = stable_user_id_from_email(email)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

    container_tag = f"user_{user_id}"
```

Convert email → stable user ID → container tag.The container tag (`user_abc123`) isolates this user’s memories from everyone else’s. Each user has their own “memory box.”

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#search-and-inject-memories)  Search and Inject Memories

```
    user_message = messages[-1]["content"]
    memory_context = await search_user_memories(user_message, container_tag)

    enhanced_messages = [\
        {"role": "system", "content": f"{SYSTEM_PROMPT}\n\n{memory_context}"}\
    ] + messages
```

We take the user’s latest message, search for relevant memories, then inject them into the system prompt.**Example:**

```
Original: "What should I eat for breakfast?"

Enhanced system message:
"You are a helpful assistant... [system prompt]

Relevant memories:
- User is vegetarian
- User works out at 6 AM
- User prefers quick meals"
```

Now the AI can answer: “Try overnight oats with plant-based protein—perfect for post-workout!”

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#stream-openai-response)  Stream OpenAI Response

```
    try:
        response = await openai_client.chat.completions.create(
            model="gpt-5",
            messages=enhanced_messages,
            temperature=0.7,
            stream=True
        )
```

**Key parameters:**

- `model="gpt-5"`: Fast, capable model
- `messages`: Full conversation + memory context
- `temperature=0.7`: Balanced creativity (0=deterministic, 1=creative)
- `stream=True`: Enables word-by-word streaming

**Why stream?** Users see responses appear in real-time instead of waiting for the complete answer. Much better UX.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#handle-streaming)  Handle Streaming

```
        async def generate():
            try:
                async for chunk in response:
                    if chunk.choices[0].delta.content:
                        content = chunk.choices[0].delta.content
                        yield f"data: {json.dumps({'content': content})}\n\n"
            except Exception as e:
                yield f"data: {json.dumps({'error': str(e)})}\n\n"
```

This async generator:

1. Receives chunks from OpenAI as they’re generated
2. Extracts the text content from each chunk
3. Formats it as Server-Sent Events (SSE): `data: {...}\n\n`
4. Yields it to the client

**SSE format** is a web standard for server→client streaming. The frontend can process each chunk as it arrives.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#optional-memory-storage)  Optional Memory Storage

```
            if "remember this" in user_message.lower():
                await add_user_memory(user_message, container_tag, email=email)
```

After streaming completes, check if the user explicitly asked to remember something. If yes, store it.**Why opt-in?** Gives users control over what gets remembered. You could also make this automatic based on content analysis.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#return-streaming-response)  Return Streaming Response

```
        return StreamingResponse(generate(), media_type="text/plain")

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

`StreamingResponse` keeps the HTTP connection open and sends chunks as they’re generated. The frontend receives them in real-time.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#local-development-server)  Local Development Server

```
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

Run with `python main.py` and the server starts on port 8000. `0.0.0.0` means it accepts connections from any IP (useful for testing from other devices).

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-3-frontend-streamlit)  Step 3: Frontend (Streamlit)

Create `streamlit_app.py`:

Complete Frontend Code

```
import streamlit as st
import requests
import json
import uuid

st.set_page_config(page_title="Personal AI Assistant", page_icon="🤖", layout="wide")

def normalize_email(email: str) -> str:
    return (email or "").strip().lower()

def stable_user_id_from_email(email: str) -> str:
    return uuid.uuid5(uuid.NAMESPACE_DNS, normalize_email(email)).hex

# Session state
if 'messages' not in st.session_state:
    st.session_state.messages = []
if 'user_name' not in st.session_state:
    st.session_state.user_name = None
if 'email' not in st.session_state:
    st.session_state.email = None
if 'user_id' not in st.session_state:
    st.session_state.user_id = None

st.title("🤖 Personal AI Assistant")
st.markdown("*Your AI that learns and remembers*")

with st.sidebar:
    st.header("👤 User Profile")

    if not st.session_state.user_name or not st.session_state.email:
        name = st.text_input("What should I call you?")
        email = st.text_input("Email", placeholder="you@example.com")

        if st.button("Get Started"):
            if name and email:
                st.session_state.user_name = name
                st.session_state.email = normalize_email(email)
                st.session_state.user_id = stable_user_id_from_email(st.session_state.email)
                st.session_state.messages.append({
                    "role": "user",
                    "content": f"Hi! My name is {name}."
                })
                st.rerun()
            else:
                st.warning("Please enter both fields.")
    else:
        st.write(f"**Name:** {st.session_state.user_name}")
        st.write(f"**Email:** {st.session_state.email}")
        if st.button("Reset Conversation"):
            st.session_state.messages = []
            st.rerun()

if st.session_state.user_name and st.session_state.email:
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    if prompt := st.chat_input("Message..."):
        st.session_state.messages.append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)

        with st.chat_message("assistant"):
            try:
                response = requests.post(
                    "http://localhost:8000/chat",
                    json={
                        "messages": st.session_state.messages,
                        "email": st.session_state.email
                    },
                    stream=True,
                    timeout=30
                )

                if response.status_code == 200:
                    full_response = ""
                    for line in response.iter_lines():
                        if line:
                            try:
                                data = json.loads(line.decode('utf-8').replace('data: ', ''))
                                if 'content' in data:
                                    full_response += data['content']
                            except:
                                continue

                    st.markdown(full_response)
                    st.session_state.messages.append({"role": "assistant", "content": full_response})
                else:
                    st.error(f"Error: {response.status_code}")
            except Exception as e:
                st.error(f"Error: {e}")
else:
    st.info("Please enter your profile in the sidebar")
```

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-4-run-it)  Step 4: Run It

Terminal 1 - Start backend:

```
python main.py
```

Terminal 2 - Start frontend:

```
streamlit run streamlit_app.py
```

Open `http://localhost:8501` in your browser.

* * *

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#typescript-implementation)  TypeScript Implementation

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-1-project-setup-2)  Step 1: Project Setup

```
npx create-next-app@latest personal-ai --typescript --tailwind --app
cd personal-ai
npm install @supermemory/tools ai @ai-sdk/openai
```

Create `.env.local`:

```
SUPERMEMORY_API_KEY=your_supermemory_key_here
OPENAI_API_KEY=your_openai_key_here
```

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-2-api-route)  Step 2: API Route

Create `app/api/chat/route.ts`. Let’s break it down:

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#import-dependencies-2)  Import Dependencies

```
import { streamText } from 'ai'
import { createOpenAI } from '@ai-sdk/openai'
import { supermemoryTools } from '@supermemory/tools/ai-sdk'
```

- **streamText**: Vercel AI SDK function that handles streaming responses and tool calling
- **createOpenAI**: Factory function to create an OpenAI provider
- **supermemoryTools**: Pre-built tools for memory search and storage

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#initialize-openai-provider)  Initialize OpenAI Provider

```
const openai = createOpenAI({
  apiKey: process.env.OPENAI_API_KEY!
})
```

Creates an OpenAI provider configured with your API key. The `!` tells TypeScript “this definitely exists” (because we set it in `.env.local`).This provider object will be passed to `streamText` to specify which AI model to use.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#define-system-prompt-2)  Define System Prompt

```
const SYSTEM_PROMPT = `You are a highly personalized AI assistant.

When users share personal information, remember it using the addMemory tool.
Before responding, search your memories using searchMemories to provide personalized help.
Always be helpful while respecting privacy.`
```

This guides the AI’s behavior and tells it:

- **When to use tools**: Search memories before responding, add memories when users share info
- **Personality**: Be helpful and personalized
- **Boundaries**: Respect privacy

The AI SDK uses this to decide when to call `searchMemories` and `addMemory` tools automatically.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#create-post-handler)  Create POST Handler

```
export async function POST(req: Request) {
  try {
    const { messages, email } = await req.json()
```

Next.js App Router convention: export an async function named after the HTTP method. This handles POST requests to `/api/chat`.We extract:

- `messages`: Chat history array `[{role, content}]`
- `email`: User identifier

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#validate-input)  Validate Input

```
    if (!messages?.length) {
      return new Response('No messages provided', { status: 400 })
    }
    if (!email) {
      return new Response('Email required', { status: 400 })
    }
```

**Why validate?** Prevents crashes from malformed requests. We need:

- At least one message to respond to
- An email to isolate user memories

Without email, we can’t maintain personalization across sessions.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#create-container-tag)  Create Container Tag

```
    const containerTag = `user_${email.toLowerCase().trim()}`
```

Convert email to a container tag for memory isolation.**Simpler than Python**: We skip UUID generation here for simplicity. In production, you might want to hash the email for privacy:

```
// Optional: More privacy-preserving approach
import crypto from 'crypto'
const containerTag = `user_${crypto.createHash('sha256').update(email).digest('hex').slice(0, 16)}`
```

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#call-streamtext-with-tools)  Call streamText with Tools

```
    const result = streamText({
      model: openai('gpt-5'),
      messages,
      tools: supermemoryTools(process.env.SUPERMEMORY_API_KEY!, {
        containerTags: [containerTag]
      }),
      system: SYSTEM_PROMPT
    })
```

This is where the magic happens! Let’s break down each parameter:**`model: openai('gpt-5')`**

- Specifies which AI model to use
- The AI SDK handles the API calls

**`messages`**

- Full conversation history
- Format: `[{role: "user"|"assistant", content: "..."}]`

**`tools: supermemoryTools(...)`**

- Gives the AI access to memory operations
- The AI SDK automatically:
  - Decides when to call tools based on the conversation
  - Calls `searchMemories` when it needs context
  - Calls `addMemory` when users share information
  - Handles tool execution and error handling

**`containerTags: [containerTag]`**

- Scopes all memory operations to this specific user
- Ensures User A can’t access User B’s memories

**`system: SYSTEM_PROMPT`**

- Guides the AI’s behavior and tool usage

**How tools work:**

1. User: “Remember that I’m vegetarian”
2. AI SDK detects this is memory-worthy
3. Automatically calls `addMemory("User is vegetarian")`
4. Stores in Supermemory with the user’s container tag
5. Responds: “Got it, I’ll remember that!”

Later:

1. User: “What should I eat?”
2. AI SDK calls `searchMemories("food preferences")`
3. Retrieves: “User is vegetarian”
4. Responds: “How about a delicious veggie stir-fry?”

**No manual tool handling needed!** The AI SDK manages the entire flow.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#return-streaming-response-2)  Return Streaming Response

```
    return result.toAIStreamResponse()
```

`toAIStreamResponse()` converts the streaming result into a format the frontend can consume. It:

- Sets appropriate headers for streaming
- Formats data for the `useChat` hook
- Handles errors gracefully

This returns immediately (doesn’t wait for completion), and chunks stream to the client as they’re generated.

#### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#error-handling)  Error Handling

```
  } catch (error: any) {
    console.error('Chat error:', error)
    return new Response(error.message, { status: 500 })
  }
}
```

Catches any errors (API failures, tool errors, etc.) and returns a clean error response.**Why log to console?** In production, you’d send this to a monitoring service (Sentry, DataDog, etc.) to track issues.

* * *

**Key Differences from Python:**

| Aspect | Python | TypeScript |
| --- | --- | --- |
| **Memory Search** | Manual `search_user_memories()` call | AI SDK calls `searchMemories` tool automatically |
| **Memory Add** | Manual `add_user_memory()` call | AI SDK calls `addMemory` tool automatically |
| **Tool Decision** | You decide when to search/add | AI decides based on conversation context |
| **Streaming** | Manual SSE formatting | `toAIStreamResponse()` handles it |
| **Error Handling** | Try/catch in each function | AI SDK handles tool errors |

**Python = Manual Control**
You explicitly search and add memories. More control, more code.**TypeScript = AI-Driven**
The AI decides when to use tools. Less code, more “magic.”

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-3-chat-ui)  Step 3: Chat UI

Replace `app/page.tsx`:

Complete Frontend Code

```
'use client'
import { useChat } from 'ai/react'
import { useState } from 'react'

export default function ChatPage() {
  const [email, setEmail] = useState('')
  const [userName, setUserName] = useState('')
  const [tempEmail, setTempEmail] = useState('')
  const [tempName, setTempName] = useState('')

  const { messages, input, handleInputChange, handleSubmit } = useChat({
    api: '/api/chat',
    body: { email }
  })

  if (!email) {
    return (
      <div className="flex items-center justify-center min-h-screen p-4">
        <div className="w-full max-w-md space-y-4 p-6 bg-white rounded-lg shadow-lg">
          <h1 className="text-2xl font-bold text-center">🤖 Personal AI Assistant</h1>
          <input
            type="text"
            placeholder="Your name"
            value={tempName}
            onChange={(e) => setTempName(e.target.value)}
            className="w-full px-4 py-2 border rounded-lg"
          />
          <input
            type="email"
            placeholder="your@email.com"
            value={tempEmail}
            onChange={(e) => setTempEmail(e.target.value)}
            className="w-full px-4 py-2 border rounded-lg"
          />
          <button
            onClick={() => {
              if (tempName && tempEmail) {
                setUserName(tempName)
                setEmail(tempEmail.toLowerCase().trim())
              }
            }}
            className="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            Get Started
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="flex flex-col h-screen max-w-4xl mx-auto p-4">
      <div className="flex-1 overflow-y-auto space-y-4 mb-4">
        {messages.map((message) => (
          <div
            key={message.id}
            className={`p-4 rounded-lg ${
              message.role === 'user'
                ? 'bg-blue-100 ml-auto max-w-[80%]'
                : 'bg-gray-100 mr-auto max-w-[80%]'
            }`}
          >
            <p className="whitespace-pre-wrap">{message.content}</p>
          </div>
        ))}
      </div>

      <form onSubmit={handleSubmit} className="flex gap-2">
        <input
          value={input}
          onChange={handleInputChange}
          placeholder="Tell me about yourself..."
          className="flex-1 p-3 border rounded-lg"
        />
        <button
          type="submit"
          className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
        >
          Send
        </button>
      </form>
    </div>
  )
}
```

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#step-4-run-it-2)  Step 4: Run It

```
npm run dev
```

Open `http://localhost:3000`

* * *

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#testing-your-assistant)  Testing Your Assistant

Try these conversations to test memory:**Personal Preferences:**

```
User: "I'm Sarah, a product manager. I prefer brief responses."
[Later]
User: "What's a good way to prioritize features?"
Assistant: [Should reference PM role and brevity preference]
```

**Dietary & Lifestyle:**

```
User: "Remember I'm vegan and work out at 6 AM."
[Later]
User: "Suggest a quick breakfast."
Assistant: [Should suggest vegan options for pre/post workout]
```

**Work Context:**

```
User: "I'm working on a React project with TypeScript."
[Later]
User: "Help me with state management."
Assistant: [Should suggest TypeScript-specific solutions]
```

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#verify-memory-storage)  Verify Memory Storage

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#python)  Python

Create `check_memories.py`:

```
from supermemory import Supermemory
import os
from dotenv import load_dotenv

load_dotenv()
client = Supermemory(api_key=os.getenv("SUPERMEMORY_API_KEY"))

# Replace with your user_id from console logs
user_id = "your_user_id_here"
container_tag = f"user_{user_id}"

memories = client.documents.list(
    container_tags=[container_tag],
    limit=20,
    sort="updatedAt",
    order="desc"
)

print(f"Found {len(memories.memories)} memories:")
for i, memory in enumerate(memories.memories):
    full = client.documents.get(id=memory.id)
    print(f"\n{i + 1}. {full.content}")
```

### [​](https://supermemory.ai/docs/cookbook/personal-assistant\#typescript)  TypeScript

Create `scripts/check-memories.ts`:

```
const userId = "your_user_id_here"
const containerTag = `user_${userId}`

const response = await fetch('https://api.supermemory.ai/v3/memories', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${process.env.SUPERMEMORY_API_KEY}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    containerTags: [containerTag],
    limit: 20,
    sort: 'updatedAt',
    order: 'desc'
  })
})

const data = await response.json()
console.log(`Found ${data.memories?.length || 0} memories`)
```

## [​](https://supermemory.ai/docs/cookbook/personal-assistant\#troubleshooting)  Troubleshooting

**Memory not persisting?**

- Verify container tags are consistent
- Check API key has write permissions
- Ensure email is properly normalized

**Responses not personalized?**

- Increase search limit to find more memories
- Check that memories are being added
- Verify system prompt guides tool usage

**Performance issues?**

- Reduce search limits
- Implement caching for frequent queries
- Use appropriate thresholds

* * *

_Built with Supermemory. Customize based on your needs._

Was this page helpful?

YesNo

[Overview](https://supermemory.ai/docs/cookbook/overview) [Document Q&A System](https://supermemory.ai/docs/cookbook/document-qa)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)