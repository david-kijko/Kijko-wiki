---
url: https://supermemory.ai/docs/document-operations
title: Document Operations - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/document-operations#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Manage Content

Document Operations

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [List Documents](https://supermemory.ai/docs/document-operations#list-documents)
- [Parameters](https://supermemory.ai/docs/document-operations#parameters)
- [Get Document](https://supermemory.ai/docs/document-operations#get-document)
- [Processing Status](https://supermemory.ai/docs/document-operations#processing-status)
- [Update Document](https://supermemory.ai/docs/document-operations#update-document)
- [Delete Documents](https://supermemory.ai/docs/document-operations#delete-documents)
- [Processing Queue](https://supermemory.ai/docs/document-operations#processing-queue)
- [Next Steps](https://supermemory.ai/docs/document-operations#next-steps)

Manage documents after ingestion using the SDK.

## [​](https://supermemory.ai/docs/document-operations\#list-documents)  List Documents

Retrieve paginated documents with filtering.

- TypeScript

- Python

- cURL


```
const documents = await client.documents.list({
  limit: 10,
  containerTags: ["user_123"]
});

documents.memories.forEach(d => {
  console.log(d.id, d.title, d.status);
});
```

```
documents = client.documents.list(
    limit=10,
    container_tags=["user_123"]
)

for doc in documents.memories:
    print(doc.id, doc.title, doc.status)
```

```
curl -X POST "https://api.supermemory.ai/v3/documents/list" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"limit": 10, "containerTags": ["user_123"]}'
```

**Response:**

```
{
  "memories": [\
    {\
      "id": "doc_abc123",\
      "title": "Meeting notes",\
      "status": "done",\
      "type": "text",\
      "createdAt": "2024-01-15T10:30:00Z",\
      "containerTags": ["user_123"],\
      "metadata": { "source": "slack" }\
    }\
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalItems": 25
  }
}
```

### [​](https://supermemory.ai/docs/document-operations\#parameters)  Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `limit` | number | 50 | Items per page (max 200) |
| `page` | number | 1 | Page number |
| `containerTags` | string\[\] | — | Filter by tags |
| `sort` | string | `createdAt` | Sort by `createdAt` or `updatedAt` |
| `order` | string | `desc` | `desc` (newest) or `asc` (oldest) |

Pagination Example

```
async function getAllDocuments(containerTag: string) {
  const all = [];
  let page = 1;

  while (true) {
    const { memories, pagination } = await client.documents.list({
      containerTags: [containerTag],
      limit: 100,
      page
    });

    all.push(...memories);
    if (page >= pagination.totalPages) break;
    page++;
  }

  return all;
}
```

Filter by Metadata

```
const documents = await client.documents.list({
  containerTags: ["user_123"],
  filters: {
    AND: [\
      { key: "status", value: "reviewed", negate: false },\
      { key: "priority", value: "high", negate: false }\
    ]
  }
});
```

* * *

## [​](https://supermemory.ai/docs/document-operations\#get-document)  Get Document

Get a specific document with its processing status.

- TypeScript

- Python

- cURL


```
const doc = await client.documents.get("doc_abc123");

console.log(doc.status);  // "queued" | "processing" | "done" | "failed"
console.log(doc.content);
```

```
doc = client.documents.get("doc_abc123")

print(doc.status)
print(doc.content)
```

```
curl "https://api.supermemory.ai/v3/documents/doc_abc123" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"
```

### [​](https://supermemory.ai/docs/document-operations\#processing-status)  Processing Status

| Status | Description |
| --- | --- |
| `queued` | Waiting to process |
| `extracting` | Extracting content (OCR, transcription) |
| `chunking` | Breaking into searchable pieces |
| `embedding` | Creating vector representations |
| `done` | Ready for search |
| `failed` | Processing failed |

Poll for Completion

```
async function waitForProcessing(docId: string) {
  while (true) {
    const doc = await client.documents.get(docId);

    if (doc.status === "done") return doc;
    if (doc.status === "failed") throw new Error("Processing failed");

    await new Promise(r => setTimeout(r, 2000));
  }
}
```

* * *

## [​](https://supermemory.ai/docs/document-operations\#update-document)  Update Document

Update a document’s content or metadata. **Content changes** trigger full reprocessing; **metadata-only changes** (e.g. updating `accepted`, `version`) do not reindex.

- TypeScript

- Python

- cURL


```
await client.documents.update("doc_abc123", {
  content: "Updated content here",
  metadata: { version: 2, reviewed: true }
});
```

```
client.documents.update(
    "doc_abc123",
    content="Updated content here",
    metadata={"version": 2, "reviewed": True}
)
```

```
curl -X PATCH "https://api.supermemory.ai/v3/documents/doc_abc123" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"content": "Updated content here", "metadata": {"version": 2}}'
```

* * *

## [​](https://supermemory.ai/docs/document-operations\#delete-documents)  Delete Documents

Permanently remove documents.

- TypeScript

- Python

- cURL


```
// Single delete
await client.documents.delete("doc_abc123");

// Bulk delete by IDs
await client.documents.deleteBulk({
  ids: ["doc_1", "doc_2", "doc_3"]
});

// Bulk delete by container tag (delete all for a user)
await client.documents.deleteBulk({
  containerTags: ["user_123"]
});
```

```
# Single delete
client.documents.delete("doc_abc123")

# Bulk delete by IDs
client.documents.delete_bulk(ids=["doc_1", "doc_2", "doc_3"])

# Bulk delete by container tag
client.documents.delete_bulk(container_tags=["user_123"])
```

```
# Single delete
curl -X DELETE "https://api.supermemory.ai/v3/documents/doc_abc123" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"

# Bulk delete by IDs
curl -X DELETE "https://api.supermemory.ai/v3/documents/bulk" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"ids": ["doc_1", "doc_2", "doc_3"]}'
```

Deletes are permanent — no recovery.

* * *

## [​](https://supermemory.ai/docs/document-operations\#processing-queue)  Processing Queue

Check documents currently being processed.

- TypeScript

- Python

- cURL


```
const response = await client.documents.listProcessing();
console.log(`${response.documents.length} documents processing`);
```

```
response = client.documents.list_processing()
print(f"{len(response.documents)} documents processing")
```

```
curl "https://api.supermemory.ai/v3/documents/processing" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"
```

* * *

## [​](https://supermemory.ai/docs/document-operations\#next-steps)  Next Steps

- [Memory Operations](https://supermemory.ai/docs/memory-operations) — Advanced v4 memory operations
- [Search](https://supermemory.ai/docs/search) — Query your memories
- [Ingesting Content](https://supermemory.ai/docs/add-memories) — Add new content

Was this page helpful?

YesNo

[User Profiles](https://supermemory.ai/docs/user-profiles) [Memories](https://supermemory.ai/docs/memory-operations)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)