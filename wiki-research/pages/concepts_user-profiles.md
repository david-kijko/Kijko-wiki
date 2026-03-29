---
url: https://supermemory.ai/docs/concepts/user-profiles
title: User Profiles - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/concepts/user-profiles#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

User Profiles

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Why Profiles?](https://supermemory.ai/docs/concepts/user-profiles#why-profiles)
- [Static vs Dynamic](https://supermemory.ai/docs/concepts/user-profiles#static-vs-dynamic)
- [Static Profile](https://supermemory.ai/docs/concepts/user-profiles#static-profile)
- [Dynamic Profile](https://supermemory.ai/docs/concepts/user-profiles#dynamic-profile)
- [How It Works](https://supermemory.ai/docs/concepts/user-profiles#how-it-works)
- [Profiles + Search](https://supermemory.ai/docs/concepts/user-profiles#profiles-%2B-search)
- [Example](https://supermemory.ai/docs/concepts/user-profiles#example)
- [Use Cases](https://supermemory.ai/docs/concepts/user-profiles#use-cases)
- [Personalized AI Assistants](https://supermemory.ai/docs/concepts/user-profiles#personalized-ai-assistants)
- [Customer Support](https://supermemory.ai/docs/concepts/user-profiles#customer-support)
- [Educational Platforms](https://supermemory.ai/docs/concepts/user-profiles#educational-platforms)
- [Development Tools](https://supermemory.ai/docs/concepts/user-profiles#development-tools)
- [Next Steps](https://supermemory.ai/docs/concepts/user-profiles#next-steps)

User profiles are **automatically maintained collections of facts about your users** that Supermemory builds from all their interactions. Think of it as a persistent “about me” document that’s always up-to-date.

## Instant Context

No search needed — comprehensive user info always ready

## Auto-Updated

Profiles update as users interact with your system

## [​](https://supermemory.ai/docs/concepts/user-profiles\#why-profiles)  Why Profiles?

Traditional memory systems rely entirely on search:

| Problem | Search Only | With Profiles |
| --- | --- | --- |
| Context retrieval | 3-5 queries | 1 call |
| Response time | 200-500ms | 50-100ms |
| Basic user info | Requires specific queries | Always available |

**Search is too narrow**: When you search for “project updates”, you miss that the user prefers bullet points, works in PST, and uses specific terminology.**Profiles provide the foundation**: Instead of searching for basic context, profiles give your LLM a complete picture of who the user is.

* * *

## [​](https://supermemory.ai/docs/concepts/user-profiles\#static-vs-dynamic)  Static vs Dynamic

Profiles separate two types of information:

### [​](https://supermemory.ai/docs/concepts/user-profiles\#static-profile)  Static Profile

Long-term, stable facts:

- “Sarah is a senior software engineer at TechCorp”
- “Sarah specializes in distributed systems”
- “Sarah prefers technical docs over video tutorials”

### [​](https://supermemory.ai/docs/concepts/user-profiles\#dynamic-profile)  Dynamic Profile

Recent context and temporary states:

- “Sarah is migrating the payment service to microservices”
- “Sarah is preparing for a conference talk next month”
- “Sarah is debugging a memory leak in auth service”

* * *

## [​](https://supermemory.ai/docs/concepts/user-profiles\#how-it-works)  How It Works

Profiles are built automatically through ingestion:

1. **Ingest content** — Users [add documents](https://supermemory.ai/docs/add-memories), chat, or any content
2. **Extract facts** — AI analyzes content for facts about the user
3. **Update profile** — System adds, updates, or removes facts
4. **Always current** — Profiles reflect the latest information

You don’t manually manage profiles — they build themselves as users interact. Start by [adding content](https://supermemory.ai/docs/add-memories) to see profiles in action.

* * *

## [​](https://supermemory.ai/docs/concepts/user-profiles\#profiles-+-search)  Profiles + Search

Profiles don’t replace search — they complement it:

- **Profile** = broad foundation (who the user is, preferences, background)
- **Search** = specific details (exact memories matching a query)

### [​](https://supermemory.ai/docs/concepts/user-profiles\#example)  Example

User asks: **“Can you help me debug this?”****Without profiles**: LLM has no context about expertise, projects, or preferences.**With profiles**: LLM knows:

- Senior engineer (adjust technical level)
- Working on payment service (likely context)
- Prefers CLI tools (tool suggestions)
- Recent memory leak issues (possible connection)

* * *

## [​](https://supermemory.ai/docs/concepts/user-profiles\#use-cases)  Use Cases

### [​](https://supermemory.ai/docs/concepts/user-profiles\#personalized-ai-assistants)  Personalized AI Assistants

Profiles provide: expertise level, communication preferences, tools used, current projects.

```
const systemPrompt = `You are assisting ${userName}.

Background: ${profile.static.join('\n')}
Current focus: ${profile.dynamic.join('\n')}

Adjust responses to their expertise and preferences.`;
```

### [​](https://supermemory.ai/docs/concepts/user-profiles\#customer-support)  Customer Support

Profiles provide: product usage, previous issues, tech proficiency.

- No more “let me look up your account”
- Agents immediately understand context
- AI support references past interactions naturally

### [​](https://supermemory.ai/docs/concepts/user-profiles\#educational-platforms)  Educational Platforms

Profiles provide: learning style, completed courses, strengths/weaknesses.

### [​](https://supermemory.ai/docs/concepts/user-profiles\#development-tools)  Development Tools

Profiles provide: preferred languages, coding style, current project context.

* * *

## [​](https://supermemory.ai/docs/concepts/user-profiles\#next-steps)  Next Steps

[**User Profiles API** \\
\\
Fetch and use profiles via the API](https://supermemory.ai/docs/user-profiles)

[**Graph Memory** \\
\\
How the underlying knowledge graph works](https://supermemory.ai/docs/concepts/graph-memory)

[**AI SDK Integration** \\
\\
Automatic profile injection with AI SDK](https://supermemory.ai/docs/integrations/ai-sdk)

[**Add Memories** \\
\\
Build profiles by adding content](https://supermemory.ai/docs/add-memories)

Was this page helpful?

YesNo

[Multi-Tenancy / Filtering](https://supermemory.ai/docs/concepts/filtering) [Customization](https://supermemory.ai/docs/concepts/customization)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)