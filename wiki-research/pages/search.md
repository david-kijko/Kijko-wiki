---
url: https://supermemory.ai/docs/search
title: Search - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/search#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Using supermemory

Search

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Quick Start](https://supermemory.ai/docs/search#quick-start)
- [Parameters](https://supermemory.ai/docs/search#parameters)
- [Search Modes](https://supermemory.ai/docs/search#search-modes)
- [Filtering](https://supermemory.ai/docs/search#filtering)
- [Query Optimization](https://supermemory.ai/docs/search#query-optimization)
- [Reranking](https://supermemory.ai/docs/search#reranking)
- [Threshold](https://supermemory.ai/docs/search#threshold)
- [Chatbot Example](https://supermemory.ai/docs/search#chatbot-example)
- [Next Steps](https://supermemory.ai/docs/search#next-steps)

Search through your memories and documents with a single API call.

**Use `searchMode: "hybrid"`** for best results. It searches both memories and document chunks, returning the most relevant content.

## [​](https://supermemory.ai/docs/search\#quick-start)  Quick Start

- TypeScript

- Python

- cURL


```
import Supermemory from 'supermemory';

const client = new Supermemory();

const results = await client.search.memories({
  q: "machine learning",
  containerTag: "user_123",
  searchMode: "hybrid",
  limit: 5
});

results.results.forEach(result => {
  console.log(result.memory || result.chunk, result.similarity);
});
```

```
from supermemory import Supermemory

client = Supermemory()

results = client.search.memories(
    q="machine learning",
    container_tag="user_123",
    search_mode="hybrid",
    limit=5
)

for result in results.results:
    print(result.memory or result.chunk, result.similarity)
```

```
curl -X POST "https://api.supermemory.ai/v4/search" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "q": "machine learning",
    "containerTag": "user_123",
    "searchMode": "hybrid",
    "limit": 5
  }'
```

**Response:**

```
{
  "results": [\
    {\
      "id": "mem_xyz",\
      "memory": "User is interested in machine learning for product recommendations",\
      "similarity": 0.91,\
      "metadata": { "topic": "interests" },\
      "updatedAt": "2024-01-15T10:30:00.000Z",\
      "version": 1\
    },\
    {\
      "id": "chunk_abc",\
      "chunk": "Machine learning enables personalized experiences at scale...",\
      "similarity": 0.87,\
      "metadata": { "source": "onboarding_doc" },\
      "updatedAt": "2024-01-14T09:15:00.000Z",\
      "version": 1\
    }\
  ],
  "timing": 92,
  "total": 5
}
```

In hybrid mode, results contain either a `memory` field (extracted facts) or a `chunk` field (document content), depending on the source.

* * *

## [​](https://supermemory.ai/docs/search\#parameters)  Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `q` | string | required | Search query |
| `containerTag` | string | — | Filter by user/project |
| `searchMode` | string | `"hybrid"` | `"hybrid"` (recommended) or `"memories"` |
| `limit` | number | 10 | Max results |
| `threshold` | 0-1 | 0.5 | Similarity cutoff (higher = fewer, better results) |
| `rerank` | boolean | false | Re-score for better relevance (+100ms) |
| `filters` | object | — | Metadata filters (`AND`/`OR` structure) |

### [​](https://supermemory.ai/docs/search\#search-modes)  Search Modes

- **`hybrid`** (recommended) — Searches both memories and document chunks, returns the most relevant
- **`memories`** — Only searches extracted memories

```
// Hybrid: memories + document chunks (recommended)
await client.search.memories({
  q: "quarterly goals",
  containerTag: "user_123",
  searchMode: "hybrid"
});

// Memories only: just extracted facts
await client.search.memories({
  q: "user preferences",
  containerTag: "user_123",
  searchMode: "memories"
});
```

* * *

## [​](https://supermemory.ai/docs/search\#filtering)  Filtering

Filter by `containerTag` to scope results to a user or project:

```
const results = await client.search.memories({
  q: "project updates",
  containerTag: "user_123",
  searchMode: "hybrid"
});
```

Use `filters` for metadata-based filtering:

```
const results = await client.search.memories({
  q: "meeting notes",
  containerTag: "user_123",
  filters: {
    AND: [\
      { key: "type", value: "meeting" },\
      { key: "year", value: "2024" }\
    ]
  }
});
```

Filter Types

- **String equality:**`{ key: "status", value: "active" }`
- **String contains:**`{ filterType: "string_contains", key: "title", value: "react" }`
- **Numeric:**`{ filterType: "numeric", key: "priority", value: "5", numericOperator: ">=" }`
- **Array contains:**`{ filterType: "array_contains", key: "tags", value: "important" }`
- **Negate:**`{ key: "status", value: "draft", negate: true }`

See [Organizing & Filtering](https://supermemory.ai/docs/concepts/filtering) for full syntax.

* * *

## [​](https://supermemory.ai/docs/search\#query-optimization)  Query Optimization

### [​](https://supermemory.ai/docs/search\#reranking)  Reranking

Re-scores results for better relevance. Adds ~100ms latency.

```
const results = await client.search.memories({
  q: "complex technical question",
  containerTag: "user_123",
  rerank: true
});
```

### [​](https://supermemory.ai/docs/search\#threshold)  Threshold

Control result quality vs quantity:

```
// Broad search — more results
await client.search.memories({ q: "...", threshold: 0.3 });

// Precise search — fewer, better results
await client.search.memories({ q: "...", threshold: 0.8 });
```

* * *

## [​](https://supermemory.ai/docs/search\#chatbot-example)  Chatbot Example

Optimal configuration for conversational AI:

```
async function getContext(userId: string, message: string) {
  const results = await client.search.memories({
    q: message,
    containerTag: userId,
    searchMode: "hybrid",
    threshold: 0.6,
    limit: 5
  });

  return results.results
    .map(r => r.memory || r.chunk)
    .join('\n\n');
}
```

Response Schema

```
interface SearchResult {
  id: string;
  memory?: string;        // Present for memory results
  chunk?: string;         // Present for document chunk results
  similarity: number;     // 0-1
  metadata: object | null;
  updatedAt: string;
  version: number;
}

interface SearchResponse {
  results: SearchResult[];
  timing: number;         // ms
  total: number;
}
```

* * *

## [​](https://supermemory.ai/docs/search\#next-steps)  Next Steps

- [Ingesting Content](https://supermemory.ai/docs/add-memories) — Add content to search
- [User Profiles](https://supermemory.ai/docs/user-profiles) — Get user context with search
- [Organizing & Filtering](https://supermemory.ai/docs/concepts/filtering) — Container tags and metadata

Was this page helpful?

YesNo

[Add context](https://supermemory.ai/docs/add-memories) [User Profiles](https://supermemory.ai/docs/user-profiles)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)