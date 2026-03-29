---
url: https://supermemory.ai/docs/concepts/content-types
title: Supported Content Types - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/concepts/content-types#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

Supported Content Types

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Text Content](https://supermemory.ai/docs/concepts/content-types#text-content)
- [URLs & Web Pages](https://supermemory.ai/docs/concepts/content-types#urls-%26-web-pages)
- [Documents](https://supermemory.ai/docs/concepts/content-types#documents)
- [PDF](https://supermemory.ai/docs/concepts/content-types#pdf)
- [Microsoft Office](https://supermemory.ai/docs/concepts/content-types#microsoft-office)
- [Google Workspace](https://supermemory.ai/docs/concepts/content-types#google-workspace)
- [Code & Markdown](https://supermemory.ai/docs/concepts/content-types#code-%26-markdown)
- [Images](https://supermemory.ai/docs/concepts/content-types#images)
- [Audio & Video](https://supermemory.ai/docs/concepts/content-types#audio-%26-video)
- [Structured Data](https://supermemory.ai/docs/concepts/content-types#structured-data)
- [JSON](https://supermemory.ai/docs/concepts/content-types#json)
- [CSV](https://supermemory.ai/docs/concepts/content-types#csv)
- [File Upload](https://supermemory.ai/docs/concepts/content-types#file-upload)
- [Auto-Detection](https://supermemory.ai/docs/concepts/content-types#auto-detection)
- [Content Limits](https://supermemory.ai/docs/concepts/content-types#content-limits)
- [Next Steps](https://supermemory.ai/docs/concepts/content-types#next-steps)

Supermemory automatically extracts and indexes content from various formats. Just send it—we handle the rest. See [Add Memories](https://supermemory.ai/docs/add-memories) to learn how to ingest content via the API.

## [​](https://supermemory.ai/docs/concepts/content-types\#text-content)  Text Content

Raw text, conversations, notes, or any string content.

```
await client.add({
  content: "User prefers dark mode and uses vim keybindings",
  containerTags: ["user_123"]
});
```

**Best for:** Chat messages, user preferences, notes, logs, transcripts.

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#urls-&-web-pages)  URLs & Web Pages

Send a URL and Supermemory fetches, extracts, and indexes the content.

```
await client.add({
  content: "https://docs.example.com/api-reference",
  containerTags: ["documentation"]
});
```

**Extracts:** Article text, headings, metadata. Strips navigation, ads, boilerplate.

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#documents)  Documents

### [​](https://supermemory.ai/docs/concepts/content-types\#pdf)  PDF

```
await client.add({
  content: pdfBase64,
  contentType: "pdf",
  title: "Q4 Financial Report"
});
```

**Extracts:** Text, tables, headers. OCR for scanned documents.

### [​](https://supermemory.ai/docs/concepts/content-types\#microsoft-office)  Microsoft Office

| Format | Extension | Content Type |
| --- | --- | --- |
| Word | `.docx` | `docx` |
| Excel | `.xlsx` | `xlsx` |
| PowerPoint | `.pptx` | `pptx` |

```
await client.add({
  content: docxBase64,
  contentType: "docx",
  title: "Product Roadmap"
});
```

### [​](https://supermemory.ai/docs/concepts/content-types\#google-workspace)  Google Workspace

Automatically handled via [Google Drive connector](https://supermemory.ai/docs/connectors/google-drive):

- Google Docs
- Google Sheets
- Google Slides

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#code-&-markdown)  Code & Markdown

```
// Markdown
await client.add({
  content: markdownContent,
  contentType: "md",
  title: "README.md"
});

// Code files (auto-detected language)
await client.add({
  content: codeContent,
  contentType: "code",
  metadata: { language: "typescript" }
});
```

**Extracts:** Structure, headings, code blocks with syntax awareness.Code is chunked using [code-chunk](https://github.com/supermemoryai/code-chunk), which understands AST boundaries to keep functions, classes, and logical blocks intact. See [Super RAG](https://supermemory.ai/docs/concepts/super-rag) for how Supermemory optimizes chunking for each content type.

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#images)  Images

```
await client.add({
  content: imageBase64,
  contentType: "image",
  title: "Architecture Diagram"
});
```

**Extracts:** OCR text, visual descriptions, diagram interpretations.**Supported:** PNG, JPG, JPEG, WebP, GIF

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#audio-&-video)  Audio & Video

```
// Audio
await client.add({
  content: audioBase64,
  contentType: "audio",
  title: "Customer Call Recording"
});

// Video
await client.add({
  content: videoBase64,
  contentType: "video",
  title: "Product Demo"
});
```

**Extracts:** Transcription, speaker detection, topic segmentation.**Supported:** MP3, WAV, M4A, MP4, WebM

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#structured-data)  Structured Data

### [​](https://supermemory.ai/docs/concepts/content-types\#json)  JSON

```
await client.add({
  content: JSON.stringify(userData),
  contentType: "json",
  title: "User Profile Data"
});
```

### [​](https://supermemory.ai/docs/concepts/content-types\#csv)  CSV

```
await client.add({
  content: csvContent,
  contentType: "csv",
  title: "Sales Data Q4"
});
```

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#file-upload)  File Upload

For binary files, encode as base64:

```
import { readFileSync } from 'fs';

const file = readFileSync('./document.pdf');
const base64 = file.toString('base64');

await client.add({
  content: base64,
  contentType: "pdf",
  title: "document.pdf"
});
```

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#auto-detection)  Auto-Detection

If you don’t specify `contentType`, Supermemory auto-detects:

```
// URL detected automatically
await client.add({ content: "https://example.com/page" });

// Plain text detected automatically
await client.add({ content: "User said they prefer email contact" });
```

For binary content (files), always specify `contentType` for reliable processing.

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#content-limits)  Content Limits

| Type | Max Size |
| --- | --- |
| Text | 1MB |
| Files | 50MB |
| URLs | Fetched content up to 10MB |

For large files, consider chunking or using [connectors](https://supermemory.ai/docs/connectors/overview) for automatic sync.

* * *

## [​](https://supermemory.ai/docs/concepts/content-types\#next-steps)  Next Steps

[**Add Memories** \\
\\
Upload content via the API](https://supermemory.ai/docs/add-memories)

[**Super RAG** \\
\\
How content is chunked and indexed](https://supermemory.ai/docs/concepts/super-rag)

Was this page helpful?

YesNo

[Graph Memory](https://supermemory.ai/docs/concepts/graph-memory) [SuperRAG](https://supermemory.ai/docs/concepts/super-rag)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)