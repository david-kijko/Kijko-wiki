---
url: https://supermemory.ai/docs/concepts/how-it-works
title: How Supermemory Works - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/concepts/how-it-works#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

How Supermemory Works

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [The Mental Model](https://supermemory.ai/docs/concepts/how-it-works#the-mental-model)
- [Documents vs Memories](https://supermemory.ai/docs/concepts/how-it-works#documents-vs-memories)
- [Documents: Your Raw Input](https://supermemory.ai/docs/concepts/how-it-works#documents-your-raw-input)
- [Memories: Intelligent Knowledge Units](https://supermemory.ai/docs/concepts/how-it-works#memories-intelligent-knowledge-units)
- [Memory Relationships](https://supermemory.ai/docs/concepts/how-it-works#memory-relationships)
- [Updates: Information Changes](https://supermemory.ai/docs/concepts/how-it-works#updates-information-changes)
- [Extends: Information Enriches](https://supermemory.ai/docs/concepts/how-it-works#extends-information-enriches)
- [Derives: Information Infers](https://supermemory.ai/docs/concepts/how-it-works#derives-information-infers)
- [Processing Pipeline](https://supermemory.ai/docs/concepts/how-it-works#processing-pipeline)
- [Next Steps](https://supermemory.ai/docs/concepts/how-it-works#next-steps)

Supermemory isn’t just another document storage system. It’s designed to mirror how human memory actually works - forming connections, evolving over time, and generating insights from accumulated knowledge.![](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/graph-view.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=e05dffd1f85e514d65e962b8bcbe70c3)

## [​](https://supermemory.ai/docs/concepts/how-it-works\#the-mental-model)  The Mental Model

Traditional systems store files. Supermemory creates a living knowledge graph.

## Traditional Systems

- Static files in folders
- No connections between content
- Search matches keywords
- Information stays frozen

## Supermemory

- Dynamic knowledge graph
- Rich relationships between memories
- Semantic understanding
- Information evolves and connects

## [​](https://supermemory.ai/docs/concepts/how-it-works\#documents-vs-memories)  Documents vs Memories

Understanding this distinction is crucial to using Supermemory effectively.

### [​](https://supermemory.ai/docs/concepts/how-it-works\#documents-your-raw-input)  Documents: Your Raw Input

Documents are what you provide - the raw materials:

- PDF files you upload
- Web pages you save
- Text you paste
- Images with text
- Videos to transcribe

Think of documents as books you hand to Supermemory. See [Content Types](https://supermemory.ai/docs/concepts/content-types) for the full list of supported formats.

### [​](https://supermemory.ai/docs/concepts/how-it-works\#memories-intelligent-knowledge-units)  Memories: Intelligent Knowledge Units

Memories are what Supermemory creates - the understanding:

- Semantic chunks with meaning
- Embedded for similarity search
- Connected through relationships
- Dynamically updated over time

Think of memories as the insights and connections your brain makes after reading those books.

**Key Insight**: When you upload a 50-page PDF, Supermemory doesn’t just store it. It breaks it into hundreds of interconnected memories, each understanding its context and relationships to your other knowledge.

## [​](https://supermemory.ai/docs/concepts/how-it-works\#memory-relationships)  Memory Relationships

![](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/memories-inferred.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=1755eced95305da072bcd9a598d5e3b5)The graph connects memories through three types of relationships. For a deeper dive into how these relationships work, see [Graph Memory](https://supermemory.ai/docs/concepts/graph-memory).

### [​](https://supermemory.ai/docs/concepts/how-it-works\#updates-information-changes)  Updates: Information Changes

When new information contradicts or updates existing knowledge, Supermemory creates an “update” relationship.

Original Memory

New Memory (Updates Original)

```
"You work at Supermemory as a content engineer"
```

The system tracks which memory is latest with an `isLatest` field, ensuring searches return current information.

### [​](https://supermemory.ai/docs/concepts/how-it-works\#extends-information-enriches)  Extends: Information Enriches

When new information adds to existing knowledge without replacing it, Supermemory creates an “extends” relationship.Continuing our “working at supermemory” analogy, a memory about what you work on would extend the memory about your role given above.

Original Memory

New Memory (Extension) - Separate From Previous

```
"You work at Supermemory as the CMO"
```

Both memories remain valid and searchable, providing richer context.

### [​](https://supermemory.ai/docs/concepts/how-it-works\#derives-information-infers)  Derives: Information Infers

The most sophisticated relationship - when Supermemory infers new connections from patterns in your knowledge.

Memory 1

Memory 2

Derived Memory

```
"Dhravya is the founder of Supermemory"
```

These inferences help surface insights you might not have explicitly stated.

## [​](https://supermemory.ai/docs/concepts/how-it-works\#processing-pipeline)  Processing Pipeline

Understanding the pipeline helps you optimize your usage:

| Stage | What Happens |
| --- | --- |
| **Queued** | Document waiting to process |
| **Extracting** | Content being extracted |
| **Chunking** | Creating memory chunks |
| **Embedding** | Generating vectors |
| **Indexing** | Building relationships |
| **Done** | Fully searchable |

**Tip**: Larger documents and videos take longer. A 100-page PDF might take 1-2 minutes, while a 1-hour video could take 5-10 minutes.

## [​](https://supermemory.ai/docs/concepts/how-it-works\#next-steps)  Next Steps

Now that you understand how Supermemory works:

[**Add Memories** \\
\\
Start adding content to your knowledge graph](https://supermemory.ai/docs/add-memories)

[**Search Memories** \\
\\
Learn to query your knowledge effectively](https://supermemory.ai/docs/search)

Was this page helpful?

YesNo

[Install with AI](https://supermemory.ai/docs/vibe-coding) [Graph Memory](https://supermemory.ai/docs/concepts/graph-memory)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)

![](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/graph-view.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=adedf3be078c9cf54367acea4688cdbd)

![](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/memories-inferred.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=f1b8c0da6d86f195379bba3960462f91)