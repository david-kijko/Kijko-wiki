---
url: https://supermemory.ai/docs/connectors/overview
title: Connectors Overview - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/connectors/overview#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Connectors and sync

Connectors Overview

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Supported Connectors](https://supermemory.ai/docs/connectors/overview#supported-connectors)
- [Quick Start](https://supermemory.ai/docs/connectors/overview#quick-start)
- [1\. Create Connection](https://supermemory.ai/docs/connectors/overview#1-create-connection)
- [2\. Handle OAuth Callback](https://supermemory.ai/docs/connectors/overview#2-handle-oauth-callback)
- [3\. Monitor Sync Status](https://supermemory.ai/docs/connectors/overview#3-monitor-sync-status)
- [How Connectors Work](https://supermemory.ai/docs/connectors/overview#how-connectors-work)
- [Authentication Flow](https://supermemory.ai/docs/connectors/overview#authentication-flow)
- [Document Processing Pipeline](https://supermemory.ai/docs/connectors/overview#document-processing-pipeline)
- [Sync Mechanisms](https://supermemory.ai/docs/connectors/overview#sync-mechanisms)
- [Connection Management](https://supermemory.ai/docs/connectors/overview#connection-management)
- [List All Connections](https://supermemory.ai/docs/connectors/overview#list-all-connections)
- [Delete Connections](https://supermemory.ai/docs/connectors/overview#delete-connections)

Connect external platforms to automatically sync documents into supermemory. Supported connectors include Google Drive, Gmail, Notion, OneDrive, GitHub and Web Crawler with real-time synchronization and intelligent content processing.

## [​](https://supermemory.ai/docs/connectors/overview\#supported-connectors)  Supported Connectors

[**Google Drive** \\
\\
**Google Docs, Slides, Sheets**Real-time sync via webhooks. Supports shared drives, nested folders, and collaborative documents.](https://supermemory.ai/docs/connectors/google-drive)

[**Gmail** \\
\\
**Email Threads**Real-time sync via Pub/Sub webhooks. Syncs threads with full conversation history and metadata.](https://supermemory.ai/docs/connectors/gmail)

[**Notion** \\
\\
**Pages, Databases, Blocks**Instant sync of workspace content. Handles rich formatting, embeds, and database properties.](https://supermemory.ai/docs/connectors/notion)

[**OneDrive** \\
\\
**Word, Excel, PowerPoint**Scheduled sync every 4 hours. Supports personal and business accounts with file versioning.](https://supermemory.ai/docs/connectors/onedrive)

[**GitHub** \\
\\
**GitHub Repositories**Real-time incremental sync via webhooks. Supports documentation files in repositories.](https://supermemory.ai/docs/connectors/github)

[**Web Crawler** \\
\\
**Web Pages, Documentation**Crawl websites automatically with robots.txt compliance. Scheduled recrawling keeps content up to date.](https://supermemory.ai/docs/connectors/web-crawler)

## [​](https://supermemory.ai/docs/connectors/overview\#quick-start)  Quick Start

### [​](https://supermemory.ai/docs/connectors/overview\#1-create-connection)  1\. Create Connection

Typescript

Python

cURL

```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

const connection = await client.connections.create('notion', {
  redirectUrl: 'https://yourapp.com/callback',
  containerTags: ['user-123', 'workspace-alpha'],
  documentLimit: 5000,
  metadata: { department: 'sales' }
});

// Redirect user to complete OAuth
console.log('Auth URL:', connection.authLink);
console.log('Expires in:', connection.expiresIn);
// Output: Auth URL: https://api.notion.com/v1/oauth/authorize?...
// Output: Expires in: 1 hour
```

### [​](https://supermemory.ai/docs/connectors/overview\#2-handle-oauth-callback)  2\. Handle OAuth Callback

After user completes OAuth, the connection is automatically established and sync begins.

### [​](https://supermemory.ai/docs/connectors/overview\#3-monitor-sync-status)  3\. Monitor Sync Status

Typescript

Python

cURL

```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

// List all connections using SDK
const connections = await client.connections.list({
  containerTags: ['user-123', 'workspace-alpha']
});

connections.forEach(conn => {
  console.log('Connection:', conn.id);
  console.log('Provider:', conn.provider);
  console.log('Email:', conn.email);
  console.log('Created:', conn.createdAt);
});

// List synced documents (memories) using SDK
const memories = await client.documents.list({
  containerTags: ['user-123', 'workspace-alpha']
});

console.log(`Synced ${memories.memories.length} documents`);
// Output: Synced 45 documents
```

## [​](https://supermemory.ai/docs/connectors/overview\#how-connectors-work)  How Connectors Work

### [​](https://supermemory.ai/docs/connectors/overview\#authentication-flow)  Authentication Flow

1. **Create Connection**: Call `/v3/connections/{provider}` to get OAuth URL (or direct connection for web-crawler)
2. **User Authorization**: Redirect user to complete OAuth flow (not required for web-crawler)
3. **Automatic Setup**: Connection established, sync begins immediately
4. **Continuous Sync**: Real-time updates via webhooks + scheduled sync every 4 hours (or scheduled recrawling for web-crawler)

### [​](https://supermemory.ai/docs/connectors/overview\#document-processing-pipeline)  Document Processing Pipeline

External Document

Webhook/Schedule Trigger

Content Extraction

Chunking & Embedding

Index in Supermemory

Searchable Memory

Document Search

### [​](https://supermemory.ai/docs/connectors/overview\#sync-mechanisms)  Sync Mechanisms

| Provider | Real-time Sync | Scheduled Sync | Manual Sync |
| --- | --- | --- | --- |
| **Google Drive** | ✅ Webhooks (7-day expiry) | ✅ Every 4 hours | ✅ On-demand |
| **Gmail** | ✅ Pub/Sub (7-day expiry) | ✅ Every 4 hours | ✅ On-demand |
| **Notion** | ✅ Webhooks | ✅ Every 4 hours | ✅ On-demand |
| **OneDrive** | ✅ Webhooks (30-day expiry) | ✅ Every 4 hours | ✅ On-demand |
| **GitHub** | ✅ Webhooks | ✅ Every 4 hours | ✅ On-demand |
| **Web Crawler** | ❌ Not supported | ✅ Scheduled recrawling (7+ days) | ✅ On-demand |

## [​](https://supermemory.ai/docs/connectors/overview\#connection-management)  Connection Management

### [​](https://supermemory.ai/docs/connectors/overview\#list-all-connections)  List All Connections

Typescript

Python

cURL

```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

const connections = await client.connections.list({
  containerTags: ['org-123']
});
```

### [​](https://supermemory.ai/docs/connectors/overview\#delete-connections)  Delete Connections

The `DELETE /v3/connections/:connectionId` endpoint accepts an optional `deleteDocuments` query parameter:

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `deleteDocuments` | boolean | `true` | When `true`, all documents imported by the connection are permanently deleted. When `false`, the connection is removed but documents are kept. |

Setting `deleteDocuments=false` is useful when you want to disconnect an integration without losing the memories that were already imported.

Typescript

Python

cURL

```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

// Delete connection and all imported documents (default)
const result = await client.connections.deleteByID(connectionId);

// Delete connection but keep imported documents
const result = await client.connections.deleteByID(connectionId, {
  deleteDocuments: false
});

// Or delete by provider (requires container tags)
const result = await client.connections.deleteByProvider('notion', {
  containerTags: ['user-123']
});

console.log('Deleted:', result.id, result.provider);
```

Was this page helpful?

YesNo

[Use Cases](https://supermemory.ai/docs/overview/use-cases) [Notion Connector](https://supermemory.ai/docs/connectors/notion)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)