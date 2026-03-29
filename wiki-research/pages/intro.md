---
url: https://supermemory.ai/docs/intro
title: Overview — What is Supermemory? - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/intro#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Getting Started

Overview — What is Supermemory?

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [How does it work? (at a glance)](https://supermemory.ai/docs/intro#how-does-it-work-at-a-glance)
- [Supermemory is context engineering.](https://supermemory.ai/docs/intro#supermemory-is-context-engineering)
- [Ingestion and Extraction](https://supermemory.ai/docs/intro#ingestion-and-extraction)
- [Memory API — Learned user context](https://supermemory.ai/docs/intro#memory-api-%E2%80%94-learned-user-context)
- [User profiles](https://supermemory.ai/docs/intro#user-profiles)
- [RAG - Advanced semantic search](https://supermemory.ai/docs/intro#rag-advanced-semantic-search)
- [Next steps](https://supermemory.ai/docs/intro#next-steps)

Supermemory is the long-term and short-term memory and context infrastructure for AI agents. It is the [state of the art](https://supermemory.ai/research) across multiple different benchmarks, like LongMemEval and LoCoMo.With supermemory, developers can provide perfect recall about their users to build AI agents that are more intelligent, more personalized, and more consistent. Additionally, _supermemory_ has all the pieces of the context stack built in:

- [Agent memory](https://supermemory.ai/docs/concepts/graph-memory)
- [Content extraction](https://supermemory.ai/docs/concepts/content-types)
- [Connectors and syncing](https://supermemory.ai/docs/connectors/overview)
- [Managed RAG platform](https://supermemory.ai/docs/concepts/super-rag)

All this, coming together, makes supermemory the best abstraction to provide to agents.

## [​](https://supermemory.ai/docs/intro\#how-does-it-work-at-a-glance)  How does it work? (at a glance)

![](https://mintcdn.com/supermemory/mNihXFQpgDpUIsdK/images/232.png?fit=max&auto=format&n=mNihXFQpgDpUIsdK&q=85&s=8fbcd175c1a97443386928d0fa7b3171)

- You send Supermemory text, files, and chats.
- Supermemory [intelligently indexes them](https://supermemory.ai/docs/concepts/how-it-works) and builds a semantic understanding graph on top of an entity (e.g., a user, a document, a project, an organization).
- At query time, we fetch only the most relevant context and pass it to your models.

## [​](https://supermemory.ai/docs/intro\#supermemory-is-context-engineering)  Supermemory is context engineering.

#### [​](https://supermemory.ai/docs/intro\#ingestion-and-extraction)  Ingestion and Extraction

Supermemory handles all the extraction, for [any data type that you have](https://supermemory.ai/docs/concepts/content-types).

- Text
- Conversations
- Files (PDF, Images, Docs)
- Even videos!

… and then,We offer three ways to add context to your LLMs:

#### [​](https://supermemory.ai/docs/intro\#memory-api-%E2%80%94-learned-user-context)  Memory API — Learned user context

![memory graph](https://mintcdn.com/supermemory/kvivCPGSB_ZCTB86/images/memory-graph.png?fit=max&auto=format&n=kvivCPGSB_ZCTB86&q=85&s=185a097d41f6c437c4a131d132b7b11a)Supermemory learns and builds the memory for the user. These are extracted facts about the user, that:

- [Evolve on top of existing context about the user](https://supermemory.ai/docs/concepts/graph-memory), **in real time**
- Handle **knowledge updates, temporal changes, forgetfulness**
- Creates a **user profile** as the default context provider for the LLM.

_This can then be provided to the LLM, to give more contextual, personalized responses._

#### [​](https://supermemory.ai/docs/intro\#user-profiles)  User profiles

Having the latest, evolving context about the user allows us to also create a [**User Profile**](https://supermemory.ai/docs/concepts/user-profiles). This is a combination of static and dynamic facts about the user, that the agent should **always know**
Developers can configure supermemory with what static and dynamic contents are, depending on their use case.

- Static: Information that the agent should **always** know.
- Dynamic: **Episodic** information, about last few conversations etc.

This leads to a much better retrieval system, and extremely personalized responses.

#### [​](https://supermemory.ai/docs/intro\#rag-advanced-semantic-search)  RAG - Advanced semantic search

Along with the user context, developers can also choose to do a search on the raw context. We provide full RAG-as-a-service, along with

- Full advanced metadata filtering
- Contextual chunking
- Works well with the memory engine

See the full API Reference tab for detailed endpoint documentation.

All three approaches share the **same context pool** when using the same user ID (`containerTag`). You can mix and match based on your needs.

## [​](https://supermemory.ai/docs/intro\#next-steps)  Next steps

[**Quickstart** \\
\\
Make your first API call in minutes](https://supermemory.ai/docs/quickstart)

[**How it Works** \\
\\
Understand the knowledge graph architecture](https://supermemory.ai/docs/concepts/how-it-works)

Was this page helpful?

YesNo

[Quickstart](https://supermemory.ai/docs/quickstart)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)

![](https://mintcdn.com/supermemory/mNihXFQpgDpUIsdK/images/232.png?w=1100&fit=max&auto=format&n=mNihXFQpgDpUIsdK&q=85&s=05018befcdb8a4ddcf886e5ea12eb56a)

![memory graph](https://mintcdn.com/supermemory/kvivCPGSB_ZCTB86/images/memory-graph.png?w=1100&fit=max&auto=format&n=kvivCPGSB_ZCTB86&q=85&s=5418b82d4828cfb79fcabe13c4cecaef)