---
url: https://supermemory.ai/docs/concepts/super-rag
title: SuperRAG (Managed RAG as a service) - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/concepts/super-rag#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

SuperRAG (Managed RAG as a service)

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Automatic Content Intelligence](https://supermemory.ai/docs/concepts/super-rag#automatic-content-intelligence)
- [Smart Chunking by Content Type](https://supermemory.ai/docs/concepts/super-rag#smart-chunking-by-content-type)
- [Documents (PDF, DOCX)](https://supermemory.ai/docs/concepts/super-rag#documents-pdf-docx)
- [Code](https://supermemory.ai/docs/concepts/super-rag#code)
- [Web Pages](https://supermemory.ai/docs/concepts/super-rag#web-pages)
- [Markdown](https://supermemory.ai/docs/concepts/super-rag#markdown)
- [Hybrid Memory + RAG](https://supermemory.ai/docs/concepts/super-rag#hybrid-memory-%2B-rag)
- [Search Optimization](https://supermemory.ai/docs/concepts/super-rag#search-optimization)
- [Reranking](https://supermemory.ai/docs/concepts/super-rag#reranking)
- [Query Rewriting](https://supermemory.ai/docs/concepts/super-rag#query-rewriting)
- [Why It’s “Super”](https://supermemory.ai/docs/concepts/super-rag#why-it%E2%80%99s-%E2%80%9Csuper%E2%80%9D)
- [Next Steps](https://supermemory.ai/docs/concepts/super-rag#next-steps)

Supermemory doesn’t just store your content—it transforms it into optimized, searchable knowledge. Every upload goes through an intelligent pipeline that extracts, chunks, and indexes content in the ideal way for its type.

## [​](https://supermemory.ai/docs/concepts/super-rag\#automatic-content-intelligence)  Automatic Content Intelligence

When you add content, Supermemory:

1. **Detects the content type** — PDF, code, markdown, images, video, etc.
2. **Extracts content optimally** — Uses type-specific extraction (OCR for images, transcription for audio)
3. **Chunks intelligently** — Applies the right chunking strategy for the content type
4. **Generates embeddings** — Creates vector representations for semantic search
5. **Builds relationships** — Connects new knowledge to existing memories

```
// Just add content — Supermemory handles the rest
await client.add({
  content: pdfBase64,
  contentType: "pdf",
  title: "Technical Documentation"
});
```

No chunking strategies to configure. No embedding models to choose. It just works.

* * *

## [​](https://supermemory.ai/docs/concepts/super-rag\#smart-chunking-by-content-type)  Smart Chunking by Content Type

Different content types need different chunking strategies. Supermemory applies the optimal approach automatically:

### [​](https://supermemory.ai/docs/concepts/super-rag\#documents-pdf-docx)  Documents (PDF, DOCX)

PDFs and documents are chunked by **semantic sections** — headers, paragraphs, and logical boundaries. This preserves context better than arbitrary character splits.

```
├── Executive Summary (chunk 1)
├── Introduction (chunk 2)
├── Section 1: Architecture
│   ├── Overview (chunk 3)
│   └── Components (chunk 4)
└── Conclusion (chunk 5)
```

### [​](https://supermemory.ai/docs/concepts/super-rag\#code)  Code

Code is chunked using [code-chunk](https://github.com/supermemoryai/code-chunk), our open-source library that understands AST (Abstract Syntax Tree) boundaries:

- Functions and methods stay intact
- Classes are chunked by method
- Import statements grouped separately
- Comments attached to their code blocks

```
// A 500-line file becomes meaningful chunks:
// - Imports + type definitions
// - Each function as a separate chunk
// - Class methods individually indexed
```

This means searching for “authentication middleware” finds the actual function, not a random slice of code.

### [​](https://supermemory.ai/docs/concepts/super-rag\#web-pages)  Web Pages

URLs are fetched, cleaned of navigation/ads, and chunked by article structure — headings, paragraphs, lists.

### [​](https://supermemory.ai/docs/concepts/super-rag\#markdown)  Markdown

Chunked by heading hierarchy, preserving the document structure.See [Content Types](https://supermemory.ai/docs/concepts/content-types) for the full list of supported formats.

* * *

## [​](https://supermemory.ai/docs/concepts/super-rag\#hybrid-memory-+-rag)  Hybrid Memory + RAG

Supermemory combines the best of both approaches in every search:

## Traditional RAG

- Finds similar document chunks
- Great for knowledge retrieval
- Stateless — same results for everyone

## Memory System

- Extracts and tracks user facts
- Understands temporal context
- Personalizes results per user

With `searchMode: "hybrid"` (the default), you get both:

```
const results = await client.search({
  q: "how do I deploy the app?",
  containerTag: "user_123",
  searchMode: "hybrid"
});

// Returns:
// - Deployment docs from your knowledge base (RAG)
// - User's previous deployment preferences (Memory)
// - Their specific environment configs (Memory)
```

* * *

## [​](https://supermemory.ai/docs/concepts/super-rag\#search-optimization)  Search Optimization

Two flags give you fine-grained control over result quality:

### [​](https://supermemory.ai/docs/concepts/super-rag\#reranking)  Reranking

Re-scores results using a cross-encoder model for better relevance:

```
const results = await client.search({
  q: "complex technical question",
  rerank: true  // +~100ms, significantly better ranking
});
```

**When to use:** Complex queries, technical documentation, when precision matters more than speed.

### [​](https://supermemory.ai/docs/concepts/super-rag\#query-rewriting)  Query Rewriting

Expands your query to capture more relevant results:

```
const results = await client.search({
  q: "how to auth",
  rewriteQuery: true  // Expands to "authentication login oauth jwt..."
});
```

**When to use:** Short queries, user-facing search, when recall matters.

* * *

## [​](https://supermemory.ai/docs/concepts/super-rag\#why-it%E2%80%99s-%E2%80%9Csuper%E2%80%9D)  Why It’s “Super”

| Traditional RAG | SUPER RAG |
| --- | --- |
| Manual chunking config | Automatic per content type |
| One-size-fits-all splits | AST-aware code chunking |
| Just document retrieval | Hybrid memory + documents |
| Static embeddings | Relationship-aware graph |
| Generic search | Rerank + query rewriting |

You focus on building your product. Supermemory handles the RAG complexity.

* * *

## [​](https://supermemory.ai/docs/concepts/super-rag\#next-steps)  Next Steps

[**Content Types** \\
\\
All supported formats and how they’re processed](https://supermemory.ai/docs/concepts/content-types)

[**How It Works** \\
\\
The full processing pipeline](https://supermemory.ai/docs/concepts/how-it-works)

[**Memory vs RAG** \\
\\
When to use each approach](https://supermemory.ai/docs/concepts/memory-vs-rag)

[**Search** \\
\\
Search parameters and optimization](https://supermemory.ai/docs/search)

Was this page helpful?

YesNo

[Content Types](https://supermemory.ai/docs/concepts/content-types) [Memory vs RAG](https://supermemory.ai/docs/concepts/memory-vs-rag)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)