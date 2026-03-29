---
url: https://supermemory.ai/docs/add-memories
title: Ingesting context to supermemory - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/add-memories#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Using supermemory

Ingesting context to supermemory

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Quick Start](https://supermemory.ai/docs/add-memories#quick-start)
- [Updating Content](https://supermemory.ai/docs/add-memories#updating-content)
- [Two ways to update:](https://supermemory.ai/docs/add-memories#two-ways-to-update)
- [Replace entire document](https://supermemory.ai/docs/add-memories#replace-entire-document)
- [Formatting conversations](https://supermemory.ai/docs/add-memories#formatting-conversations)
- [Upload Files](https://supermemory.ai/docs/add-memories#upload-files)
- [Supported File Types](https://supermemory.ai/docs/add-memories#supported-file-types)
- [Parameters](https://supermemory.ai/docs/add-memories#parameters)
- [Processing Pipeline](https://supermemory.ai/docs/add-memories#processing-pipeline)
- [Next Steps](https://supermemory.ai/docs/add-memories#next-steps)

Send any raw content to Supermemory — conversations, documents, files, URLs. We extract the memories automatically.

**Use `customId`** to identify your content (conversation ID, document ID, etc.). This enables updates and prevents duplicates.

## [​](https://supermemory.ai/docs/add-memories\#quick-start)  Quick Start

- TypeScript

- Python

- cURL


```
import Supermemory from 'supermemory';

const client = new Supermemory();

// Add text content
await client.add({
  content: "Machine learning enables computers to learn from data",
  containerTag: "user_123",
  metadata: { category: "ai" }
});

// Add a URL (auto-extracted)
await client.add({
  content: "https://youtube.com/watch?v=dQw4w9WgXcQ",
  containerTag: "user_123"
});
```

```
from supermemory import Supermemory

client = Supermemory()

# Add text content
client.add(
    content="Machine learning enables computers to learn from data",
    container_tag="user_123",
    metadata={"category": "ai"}
)

# Add a URL (auto-extracted)
client.add(
    content="https://youtube.com/watch?v=dQw4w9WgXcQ",
    container_tag="user_123"
)
```

```
curl -X POST "https://api.supermemory.ai/v3/documents" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "content": "Machine learning enables computers to learn from data",
    "containerTag": "user_123",
    "metadata": {"category": "ai"}
  }'
```

**Response:**

```
{ "id": "abc123", "status": "queued" }
```

* * *

## [​](https://supermemory.ai/docs/add-memories\#updating-content)  Updating Content

Use `customId` to update existing documents or conversations. When you send content with the same `customId`, Supermemory intelligently processes only what’s new.

### [​](https://supermemory.ai/docs/add-memories\#two-ways-to-update)  Two ways to update:

**Option 1: Send only the new content**

```
// First request
await client.add({
  content: "user: Hi, I'm Sarah.\nassistant: Nice to meet you!",
  customId: "conv_123",
  containerTag: "user_sarah"
});

// Later: send only new messages
await client.add({
  content: "user: What's the weather?\nassistant: It's sunny today.",
  customId: "conv_123",  // Same ID — Supermemory links them
  containerTag: "user_sarah"
});
```

**Option 2: Send the full updated content**

```
// Supermemory detects the diff and only processes new parts
await client.add({
  content: "user: Hi, I'm Sarah.\nassistant: Nice to meet you!\nuser: What's the weather?\nassistant: It's sunny today.",
  customId: "conv_123",
  containerTag: "user_sarah"
});
```

Both work — choose what fits your architecture.

### [​](https://supermemory.ai/docs/add-memories\#replace-entire-document)  Replace entire document

To completely replace a document’s content (not append), use `memories.update()`:

```
// Replace the entire document content
await client.documents.update("doc_id_123", {
  content: "Completely new content replacing everything",
  metadata: { version: 2 }
});
```

This triggers full reprocessing of the document. If you only update metadata (no content change), the document is updated in place with no reindexing.

### [​](https://supermemory.ai/docs/add-memories\#formatting-conversations)  Formatting conversations

Format your conversations however you want. Supermemory handles any string format:

```
// Simple string
content: "user: Hello\nassistant: Hi there!"

// JSON stringify
content: JSON.stringify(messages)

// Template literal
content: messages.map(m => `${m.role}: ${m.content}`).join('\n')

// Any format — just make it a string
content: formatConversation(messages)
```

* * *

## [​](https://supermemory.ai/docs/add-memories\#upload-files)  Upload Files

Upload PDFs, images, and documents directly.

- TypeScript

- Python

- cURL


```
import fs from 'fs';

await client.documents.uploadFile({
  file: fs.createReadStream('document.pdf'),
  containerTags: 'user_123'
});
```

```
with open('document.pdf', 'rb') as file:
    client.documents.upload_file(
        file=file,
        container_tags='user_123'
    )
```

```
curl -X POST "https://api.supermemory.ai/v3/documents/file" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -F "file=@document.pdf" \
  -F "containerTags=user_123"
```

### [​](https://supermemory.ai/docs/add-memories\#supported-file-types)  Supported File Types

| Type | Formats | Processing |
| --- | --- | --- |
| Documents | PDF, DOC, DOCX, TXT, MD | Text extraction, OCR for scans |
| Images | JPG, PNG, GIF, WebP | OCR text extraction |
| Spreadsheets | CSV, Google Sheets | Structured data extraction |
| Videos | YouTube URLs, MP4 | Auto-transcription |

**Limits:** 50MB max file size

* * *

## [​](https://supermemory.ai/docs/add-memories\#parameters)  Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `content` | string | **Required.** Any raw content — text, conversations, URLs, HTML |
| `customId` | string | **Recommended.** Your ID for the content (conversation ID, doc ID). Enables updates and deduplication |
| `containerTag` | string | Group by user/project. Required for user profiles |
| `metadata` | object | Key-value pairs for filtering (strings, numbers, booleans) |
| `entityContext` | string | Context for memory extraction on this container tag. Max 1500 chars. See [Customization](https://supermemory.ai/docs/concepts/customization#entity-context) |

Parameter Details & Examples

**Content Types:**

```
// Any text — conversations, notes, documents
{ content: "Meeting notes from today's standup" }
{ content: JSON.stringify(messages) }

// URLs (auto-detected and extracted)
{ content: "https://example.com/article" }
{ content: "https://youtube.com/watch?v=abc123" }

// Markdown, HTML, or any format
{ content: "# Project Docs\n\n## Features\n- Real-time sync" }
```

**Container Tags:**

```
// By user
{ containerTag: "user_123" }

// By project
{ containerTag: "project_alpha" }

// Hierarchical
{ containerTag: "org_456_team_backend" }
```

**Custom IDs (Recommended):**

```
// Use IDs from your system
{ customId: "conv_abc123" }        // Conversation ID
{ customId: "doc_456" }            // Document ID
{ customId: "thread_789" }         // Thread ID
{ customId: "meeting_2024_01_15" } // Meeting ID

// Updates: same customId = same document
// Supermemory only processes new/changed content
await client.add({
  content: "Updated content...",
  customId: "doc_456"  // Links to existing document
});
```

**Metadata:**

```
{
  metadata: {
    source: "slack",
    author: "john",
    priority: 1,
    reviewed: true
  }
}
```

- No nested objects or arrays
- Values: string, number, or boolean only

**Entity Context:**

```
// Guide memory extraction for this container tag
{
  containerTag: "session_abc123",
  entityContext: `Design exploration conversation between john@acme.com and Brand.ai assistant.
    Focus on John's design preferences and brand requirements.`
}
```

- Max 1500 characters
- Persists on the container tag
- Combines with org-level filter prompts

* * *

## [​](https://supermemory.ai/docs/add-memories\#processing-pipeline)  Processing Pipeline

When you add content, Supermemory:

1. **Validates** your request
2. **Stores** the document and queues for processing
3. **Extracts** content (OCR, transcription, web scraping)
4. **Chunks** into searchable memories
5. **Embeds** for vector search
6. **Indexes** for retrieval

Track progress with `GET /v3/documents/{id}`:

```
const doc = await client.documents.get("abc123");
console.log(doc.status); // "queued" | "processing" | "done"
```

Batch Upload

Process multiple documents with rate limiting:

```
async function batchUpload(documents: Array<{id: string, content: string}>) {
  const results = [];

  for (const doc of documents) {
    try {
      const result = await client.add({
        content: doc.content,
        customId: doc.id,
        containerTag: "batch_import"
      });
      results.push({ id: doc.id, success: true, docId: result.id });
    } catch (error) {
      results.push({ id: doc.id, success: false, error });
    }

    // Rate limit: 1 second between requests
    await new Promise(r => setTimeout(r, 1000));
  }

  return results;
}
```

**Tips:**

- Batch size: 3-5 documents at once
- Delay: 1-2 seconds between requests
- Use `customId` to track and deduplicate

Error Handling

| Status | Error | Cause |
| --- | --- | --- |
| 400 | BadRequestError | Missing required fields, invalid parameters |
| 401 | AuthenticationError | Invalid or missing API key |
| 403 | PermissionDeniedError | Insufficient permissions |
| 429 | RateLimitError | Too many requests or quota exceeded |
| 500 | InternalServerError | Processing failure |

```
import { BadRequestError, RateLimitError } from 'supermemory';

try {
  await client.add({ content: "..." });
} catch (error) {
  if (error instanceof RateLimitError) {
    // Wait and retry
    await new Promise(r => setTimeout(r, 60000));
  } else if (error instanceof BadRequestError) {
    // Fix request parameters
    console.error("Invalid request:", error.message);
  }
}
```

Delete Content

**Single delete:**

```
await client.documents.delete("doc_id_123");
```

**Bulk delete by IDs:**

```
await client.documents.deleteBulk({
  ids: ["doc_1", "doc_2", "doc_3"]
});
```

**Bulk delete by container tag:**

```
// Delete all content for a user
await client.documents.deleteBulk({
  containerTags: ["user_123"]
});
```

Deletes are permanent — no recovery.

* * *

## [​](https://supermemory.ai/docs/add-memories\#next-steps)  Next Steps

- [Search Memories](https://supermemory.ai/docs/search) — Query your content
- [User Profiles](https://supermemory.ai/docs/user-profiles) — Get user context
- [Organizing & Filtering](https://supermemory.ai/docs/concepts/filtering) — Container tags and metadata

Was this page helpful?

YesNo

[Authentication](https://supermemory.ai/docs/authentication) [Search Memories and Docs](https://supermemory.ai/docs/search)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)