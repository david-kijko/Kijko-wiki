---
url: https://supermemory.ai/docs/memory-operations
title: Memory Operations - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/memory-operations#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Manage Content

Memory Operations

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Create Memories](https://supermemory.ai/docs/memory-operations#create-memories)
- [Parameters](https://supermemory.ai/docs/memory-operations#parameters)
- [Response](https://supermemory.ai/docs/memory-operations#response)
- [Forget Memory](https://supermemory.ai/docs/memory-operations#forget-memory)
- [Update Memory (Versioned)](https://supermemory.ai/docs/memory-operations#update-memory-versioned)
- [Parameters](https://supermemory.ai/docs/memory-operations#parameters-2)
- [Next Steps](https://supermemory.ai/docs/memory-operations#next-steps)

These v4 endpoints operate on extracted memories (not raw documents). SDK support coming soon — use fetch or cURL for now.For document management (list, get, update, delete), see [Document Operations](https://supermemory.ai/docs/document-operations).
For ingesting raw content (text, files, URLs) through the processing pipeline, see [Add Context](https://supermemory.ai/docs/add-memories).

## [​](https://supermemory.ai/docs/memory-operations\#create-memories)  Create Memories

Create memories directly without going through the document ingestion workflow. Memories are embedded and immediately searchable.This is useful for storing user preferences, traits, or any structured facts where you already know the exact memory content.

- fetch

- cURL


```
const response = await fetch("https://api.supermemory.ai/v4/memories", {
  method: "POST",
  headers: {
    "Authorization": `Bearer ${API_KEY}`,
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    memories: [\
      {\
        content: "John prefers dark mode",\
        isStatic: false,\
        metadata: { source: "user_preference" }\
      },\
      {\
        content: "John is from Seattle",\
        isStatic: true\
      }\
    ],
    containerTag: "user_123"
  })
});

const data = await response.json();
// {
//   documentId: "abc123",
//   memories: [\
//     { id: "mem_1", memory: "John prefers dark mode", isStatic: false, createdAt: "2025-..." },\
//     { id: "mem_2", memory: "John is from Seattle", isStatic: true, createdAt: "2025-..." }\
//   ]
// }
```

```
curl -X POST "https://api.supermemory.ai/v4/memories" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "memories": [\
      {\
        "content": "John prefers dark mode",\
        "isStatic": false,\
        "metadata": { "source": "user_preference" }\
      },\
      {\
        "content": "John is from Seattle",\
        "isStatic": true\
      }\
    ],
    "containerTag": "user_123"
  }'
```

### [​](https://supermemory.ai/docs/memory-operations\#parameters)  Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `memories` | array | yes | Array of memory objects (1–100 items) |
| `memories[].content` | string | yes | The memory text (max 10,000 chars). Should be entity-centric, e.g. “John prefers dark mode” |
| `memories[].isStatic` | boolean | no | `true` for permanent identity traits (name, hometown). Defaults to `false` |
| `memories[].metadata` | object | no | Key-value metadata (strings, numbers, booleans) |
| `containerTag` | string | yes | Space / container tag these memories belong to |

### [​](https://supermemory.ai/docs/memory-operations\#response)  Response

```
{
  "documentId": "abc123",
  "memories": [\
    {\
      "id": "mem_1",\
      "memory": "John prefers dark mode",\
      "isStatic": false,\
      "createdAt": "2025-01-15T10:30:00.000Z"\
    }\
  ]
}
```

| Field | Type | Description |
| --- | --- | --- |
| `documentId` | string \| null | ID of the lightweight source document created for traceability |
| `memories` | array | The created memory entries |
| `memories[].id` | string | Unique memory ID |
| `memories[].memory` | string | The memory content |
| `memories[].isStatic` | boolean | Whether this is a permanent trait |
| `memories[].createdAt` | string | ISO 8601 timestamp |

**When to use this vs [Add Context](https://supermemory.ai/docs/add-memories)?**Use **Create Memories** when you already know the exact facts to store (user preferences, traits, structured data). Use **Add Context** when you have raw content (conversations, documents, URLs) that Supermemory should process and extract memories from.

* * *

## [​](https://supermemory.ai/docs/memory-operations\#forget-memory)  Forget Memory

Soft-delete a memory — excluded from search results but preserved in the system. Use this when you might want to restore later.

- fetch

- cURL


```
await fetch("https://api.supermemory.ai/v4/memories/mem_abc123/forget", {
  method: "POST",
  headers: {
    "Authorization": `Bearer ${API_KEY}`
  }
});
```

```
curl -X POST "https://api.supermemory.ai/v4/memories/mem_abc123/forget" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"
```

The memory will no longer appear in search results but remains in the database.

* * *

## [​](https://supermemory.ai/docs/memory-operations\#update-memory-versioned)  Update Memory (Versioned)

Update a memory by creating a new version. The original is preserved with `isLatest=false`.

- fetch

- cURL


```
await fetch("https://api.supermemory.ai/v4/memories", {
  method: "PATCH",
  headers: {
    "Authorization": `Bearer ${API_KEY}`,
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    // Identify by ID or content
    id: "mem_abc123",
    // content: "Original content to match",

    newContent: "Updated content goes here",
    metadata: {
      tags: ["updated"]
    }
  })
});
```

```
curl -X PATCH "https://api.supermemory.ai/v4/memories" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "mem_abc123",
    "newContent": "Updated content goes here",
    "metadata": {"tags": ["updated"]}
  }'
```

### [​](https://supermemory.ai/docs/memory-operations\#parameters-2)  Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | \* | Memory ID to update |
| `content` | string | \* | Original content to match (alternative to ID) |
| `newContent` | string | yes | New content for the memory |
| `metadata` | object | no | Updated metadata |

\\* Either `id` or `content` must be provided.

* * *

## [​](https://supermemory.ai/docs/memory-operations\#next-steps)  Next Steps

- [Document Operations](https://supermemory.ai/docs/document-operations) — Manage documents (SDK supported)
- [Search](https://supermemory.ai/docs/search) — Query your memories
- [Ingesting Content](https://supermemory.ai/docs/add-memories) — Add new content

Was this page helpful?

YesNo

[Documents](https://supermemory.ai/docs/document-operations) [Use Cases](https://supermemory.ai/docs/overview/use-cases)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)