---
url: https://supermemory.ai/docs/memory-router/overview
title: Overview - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/memory-router/overview#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Overview

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [What is the Memory Router?](https://supermemory.ai/docs/memory-router/overview#what-is-the-memory-router)
- [How It Works](https://supermemory.ai/docs/memory-router/overview#how-it-works)
- [Key Benefits](https://supermemory.ai/docs/memory-router/overview#key-benefits)
- [For Developers](https://supermemory.ai/docs/memory-router/overview#for-developers)
- [For Applications](https://supermemory.ai/docs/memory-router/overview#for-applications)
- [When to Use the Memory Router](https://supermemory.ai/docs/memory-router/overview#when-to-use-the-memory-router)
- [Supported Providers](https://supermemory.ai/docs/memory-router/overview#supported-providers)
- [Authentication](https://supermemory.ai/docs/memory-router/overview#authentication)
- [How Memories Work](https://supermemory.ai/docs/memory-router/overview#how-memories-work)
- [Response Headers](https://supermemory.ai/docs/memory-router/overview#response-headers)
- [Error Handling](https://supermemory.ai/docs/memory-router/overview#error-handling)
- [Rate Limits & Pricing](https://supermemory.ai/docs/memory-router/overview#rate-limits-%26-pricing)
- [Rate Limits](https://supermemory.ai/docs/memory-router/overview#rate-limits)
- [Pricing](https://supermemory.ai/docs/memory-router/overview#pricing)

The Memory Router is a transparent proxy that sits between your application and your LLM provider, automatically managing context and memories without requiring any code changes.

**Live Demo**: Try the Memory Router at [supermemory.chat](https://supermemory.chat/) to see it in action.

**Using Vercel AI SDK?** Check out our [AI SDK integration](https://supermemory.ai/docs/integrations/ai-sdk) for the cleanest implementation with `@supermemory/tools/ai-sdk` \- it’s our recommended approach for new projects.

## [​](https://supermemory.ai/docs/memory-router/overview\#what-is-the-memory-router)  What is the Memory Router?

The Memory Router gives your LLM applications:

- **Unlimited Context**: No more token limits - conversations can extend indefinitely
- **Automatic Memory Management**: Intelligently chunks, stores, and retrieves relevant context
- **Zero Code Changes**: Works with your existing OpenAI-compatible clients
- **Cost Optimization**: Save up to 70% on token costs through intelligent context management

## [​](https://supermemory.ai/docs/memory-router/overview\#how-it-works)  How It Works

1

[Navigate to header](https://supermemory.ai/docs/memory-router/overview#)

Proxy Request

Your application sends requests to Supermemory instead of directly to your LLM provider

2

[Navigate to header](https://supermemory.ai/docs/memory-router/overview#)

Context Management

Supermemory automatically:

- Removes unnecessary context from long conversations
- Searches relevant memories from previous interactions
- Appends the most relevant context to your prompt

3

[Navigate to header](https://supermemory.ai/docs/memory-router/overview#)

Forward to LLM

The optimized request is forwarded to your chosen LLM provider

4

[Navigate to header](https://supermemory.ai/docs/memory-router/overview#)

Async Memory Creation

New memories are created asynchronously without blocking the response

## [​](https://supermemory.ai/docs/memory-router/overview\#key-benefits)  Key Benefits

### [​](https://supermemory.ai/docs/memory-router/overview\#for-developers)  For Developers

- **Drop-in Integration**: Just change your base URL - no other code changes needed
- **Provider Agnostic**: Works with OpenAI, Anthropic, Google, Groq, and more
- **Shared Memory Pool**: Memories created via API are available to the Router and vice versa
- **Automatic Fallback**: If Supermemory has issues, requests pass through directly

### [​](https://supermemory.ai/docs/memory-router/overview\#for-applications)  For Applications

- **Better Long Conversations**: Maintains context even after thousands of messages
- **Consistent Responses**: Memories ensure consistent information across sessions
- **Smart Retrieval**: Only relevant context is included, improving response quality
- **Cost Savings**: Automatic chunking reduces token usage significantly

## [​](https://supermemory.ai/docs/memory-router/overview\#when-to-use-the-memory-router)  When to Use the Memory Router

The Memory Router is ideal for:

- Perfect For

- Consider API Instead


- **Chat Applications**: Customer support, AI assistants, chatbots
- **Long Conversations**: Sessions that exceed model context windows
- **Multi-Session Memory**: Users who return and continue conversations
- **Quick Prototypes**: Get memory capabilities without building infrastructure

- **Custom Retrieval Logic**: Need specific control over what memories to fetch
- **Non-Conversational Use**: Document processing, analysis tools
- **Complex Filtering**: Need advanced metadata filtering
- **Batch Operations**: Processing multiple documents at once

## [​](https://supermemory.ai/docs/memory-router/overview\#supported-providers)  Supported Providers

The Memory Router works with any OpenAI-compatible endpoint:

| Provider | Base URL | Status |
| --- | --- | --- |
| OpenAI | `api.openai.com/v1` | ✅ Fully Supported |
| Anthropic | `api.anthropic.com/v1` | ✅ Fully Supported |
| Google Gemini | `generativelanguage.googleapis.com/v1beta/openai` | ✅ Fully Supported |
| Groq | `api.groq.com/openai/v1` | ✅ Fully Supported |
| DeepInfra | `api.deepinfra.com/v1/openai` | ✅ Fully Supported |
| OpenRouter | `openrouter.ai/api/v1` | ✅ Fully Supported |
| Custom | Any OpenAI-compatible | ✅ Supported |

**Not Yet Supported**:

- OpenAI Assistants API (`/v1/assistants`)

## [​](https://supermemory.ai/docs/memory-router/overview\#authentication)  Authentication

The Memory Router requires two API keys:

1. **Supermemory API Key**: For memory management
2. **Provider API Key**: For your chosen LLM provider

You can provide these via:

- Headers (recommended for production)
- URL parameters (useful for testing)
- Request body (for compatibility)

## [​](https://supermemory.ai/docs/memory-router/overview\#how-memories-work)  How Memories Work

When using the Memory Router:

1. **Automatic Extraction**: Important information from conversations is automatically extracted
2. **Intelligent Chunking**: Long messages are split into semantic chunks
3. **Relationship Building**: New memories connect to existing knowledge
4. **Smart Retrieval**: Only the most relevant memories are included in context

Memories are shared between the Memory Router and Memory API when using the same `user_id`, allowing you to use both together.

## [​](https://supermemory.ai/docs/memory-router/overview\#response-headers)  Response Headers

The Memory Router adds diagnostic headers to help you understand what’s happening:

| Header | Description |
| --- | --- |
| `x-supermemory-conversation-id` | Unique conversation identifier |
| `x-supermemory-context-modified` | Whether context was modified (`true`/`false`) |
| `x-supermemory-tokens-processed` | Number of tokens processed |
| `x-supermemory-chunks-created` | New memory chunks created |
| `x-supermemory-chunks-retrieved` | Memory chunks added to context |

## [​](https://supermemory.ai/docs/memory-router/overview\#error-handling)  Error Handling

The Memory Router is designed for reliability:

- **Automatic Fallback**: If Supermemory encounters an error, your request passes through unmodified
- **Error Headers**: `x-supermemory-error` header provides error details
- **Zero Downtime**: Your application continues working even if memory features are unavailable

## [​](https://supermemory.ai/docs/memory-router/overview\#rate-limits-&-pricing)  Rate Limits & Pricing

### [​](https://supermemory.ai/docs/memory-router/overview\#rate-limits)  Rate Limits

- No Supermemory-specific rate limits
- Subject only to your LLM provider’s limits

### [​](https://supermemory.ai/docs/memory-router/overview\#pricing)  Pricing

- **Free Tier**: 100k tokens stored at no cost
- **Standard Plan**: $20/month after free tier
- **Usage-Based**: Each conversation includes 20k free tokens, then $1 per million tokens

Was this page helpful?

YesNo

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)