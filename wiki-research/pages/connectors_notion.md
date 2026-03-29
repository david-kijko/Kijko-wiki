---
url: https://supermemory.ai/docs/connectors/notion
title: Notion Connector - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/connectors/notion#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Connectors

Notion Connector

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Quick Setup](https://supermemory.ai/docs/connectors/notion#quick-setup)
- [1\. Create Notion Connection](https://supermemory.ai/docs/connectors/notion#1-create-notion-connection)
- [2\. Handle OAuth Flow](https://supermemory.ai/docs/connectors/notion#2-handle-oauth-flow)
- [3\. Monitor Sync Progress](https://supermemory.ai/docs/connectors/notion#3-monitor-sync-progress)
- [Supported Content Types](https://supermemory.ai/docs/connectors/notion#supported-content-types)
- [Notion Pages](https://supermemory.ai/docs/connectors/notion#notion-pages)
- [Notion Databases](https://supermemory.ai/docs/connectors/notion#notion-databases)
- [Block Types](https://supermemory.ai/docs/connectors/notion#block-types)
- [Delete Connection](https://supermemory.ai/docs/connectors/notion#delete-connection)
- [Advanced Configuration](https://supermemory.ai/docs/connectors/notion#advanced-configuration)
- [Custom Notion Integration](https://supermemory.ai/docs/connectors/notion#custom-notion-integration)
- [Content Filtering](https://supermemory.ai/docs/connectors/notion#content-filtering)
- [Workspace Permissions](https://supermemory.ai/docs/connectors/notion#workspace-permissions)
- [Database Integration](https://supermemory.ai/docs/connectors/notion#database-integration)
- [Database Properties](https://supermemory.ai/docs/connectors/notion#database-properties)
- [Optimization Strategies](https://supermemory.ai/docs/connectors/notion#optimization-strategies)

Connect Notion workspaces to automatically sync pages, databases, and content blocks into your Supermemory knowledge base. Supports real-time updates, rich formatting, and database properties.

## [​](https://supermemory.ai/docs/connectors/notion\#quick-setup)  Quick Setup

### [​](https://supermemory.ai/docs/connectors/notion\#1-create-notion-connection)  1\. Create Notion Connection

- TypeScript

- Python

- cURL


```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

const connection = await client.connections.create('notion', {
  redirectUrl: 'https://yourapp.com/auth/notion/callback',
  containerTags: ['user-123', 'notion-workspace'],
  documentLimit: 2000,
  metadata: {
    source: 'notion',
    workspaceType: 'team',
    department: 'product'
  }
});

// Redirect user to Notion OAuth
window.location.href = connection.authLink;
```

```
from supermemory import Supermemory
import os

client = Supermemory(api_key=os.environ.get("SUPERMEMORY_API_KEY"))

connection = client.connections.create(
    'notion',
    redirect_url='https://yourapp.com/auth/notion/callback',
    container_tags=['user-123', 'notion-workspace'],
    document_limit=2000,
    metadata={
        'source': 'notion',
        'workspaceType': 'team',
        'department': 'product'
    }
)

# Redirect user to Notion OAuth
print(f'Redirect to: {connection.auth_link}')
```

```
curl -X POST "https://api.supermemory.ai/v3/connections/notion" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "redirectUrl": "https://yourapp.com/auth/notion/callback",
    "containerTags": ["user-123", "notion-workspace"],
    "documentLimit": 2000,
    "metadata": {
      "source": "notion",
      "workspaceType": "team",
      "department": "product"
    }
  }'
```

### [​](https://supermemory.ai/docs/connectors/notion\#2-handle-oauth-flow)  2\. Handle OAuth Flow

After user grants workspace access, Notion redirects to your callback URL. The connection is automatically established.

### [​](https://supermemory.ai/docs/connectors/notion\#3-monitor-sync-progress)  3\. Monitor Sync Progress

- TypeScript

- Python

- cURL


```
// Check connection details
const connection = await client.connections.getByTags('notion', {
  containerTags: ['user-123', 'notion-workspace']
});

console.log('Connected workspace:', connection.email);
console.log('Connection created:', connection.createdAt);

// List synced pages and databases
const documents = await client.connections.listDocuments('notion', {
  containerTags: ['user-123', 'notion-workspace']
});
```

```
# Check connection details
connection = client.connections.get_by_tags(
    'notion',
    container_tags=['user-123', 'notion-workspace']
)

print(f'Connected workspace: {connection.email}')
print(f'Connection created: {connection.created_at}')

# List synced pages and databases
documents = client.connections.list_documents(
    'notion',
    container_tags=['user-123', 'notion-workspace']
)
```

```
# Get connection details by provider and tags
curl -X POST "https://api.supermemory.ai/v3/connections/notion/connection" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"containerTags": ["user-123", "notion-workspace"]}'

# Response includes connection details:
# {
#   "id": "conn_abc123",
#   "provider": "notion",
#   "email": "workspace@example.com",
#   "createdAt": "2024-01-15T10:00:00Z",
#   "documentLimit": 2000,
#   "metadata": {...}
# }

# List synced documents
curl -X POST "https://api.supermemory.ai/v3/connections/notion/documents" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"containerTags": ["user-123", "notion-workspace"]}'

# Response: Array of document objects with sync status
# [\
#   {"title": "Product Roadmap", "type": "notion_database", "status": "done"},\
#   {"title": "Meeting Notes", "type": "notion_page", "status": "done"}\
# ]
```

## [​](https://supermemory.ai/docs/connectors/notion\#supported-content-types)  Supported Content Types

### [​](https://supermemory.ai/docs/connectors/notion\#notion-pages)  Notion Pages

- **Rich text blocks** with formatting preserved
- **Nested pages** and hierarchical structure
- **Embedded content** (images, videos, files)
- **Code blocks** with syntax highlighting
- **Callouts and quotes** converted to markdown

### [​](https://supermemory.ai/docs/connectors/notion\#notion-databases)  Notion Databases

- **Database entries** synced as individual documents
- **Properties** included in metadata
- **Relations** between database entries
- **Formulas and rollups** calculated values
- **Multi-select and select** properties

### [​](https://supermemory.ai/docs/connectors/notion\#block-types)  Block Types

| Block Type | Processing | Markdown Output |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Text** | Formatting preserved | `**bold**`, `*italic*`, `~~strikethrough~~` |  |  |  |  |  |  |
| **Heading** | Hierarchy maintained | `# H1`, `## H2`, `### H3` |  |  |  |  |  |  |
| **Code** | Language detected | `python\ncode here\n` |  |  |  |  |  |  |
| **Quote** | Blockquote format | `> quoted text` |  |  |  |  |  |  |
| **Callout** | Custom formatting | `> 💡 **Note:** callout text` |  |  |  |  |  |  |
| **List** | Structure preserved | `- item 1\n  - nested item` |  |  |  |  |  |  |
| **Table** | Markdown tables | \` | Col 1 | Col 2 | \\n | \-\-\----- | \-\-\----- | \` |
| **Image** | Referenced with metadata | `![alt text](url)` |  |  |  |  |  |  |
| **Embed** | Link with context | `[Embedded Content](url)` |  |  |  |  |  |  |

## [​](https://supermemory.ai/docs/connectors/notion\#delete-connection)  Delete Connection

Remove a Notion connection when no longer needed:

- TypeScript

- Python

- cURL


```
// Delete by connection ID
const result = await client.connections.delete('connection_id_123');
console.log('Deleted connection:', result.id);

// Delete by provider and container tags
const providerResult = await client.connections.deleteByProvider('notion', {
  containerTags: ['user-123']
});
console.log('Deleted Notion connection for user');
```

```
# Delete by connection ID
result = client.connections.delete('connection_id_123')
print(f'Deleted connection: {result.id}')

# Delete by provider and container tags
provider_result = client.connections.delete_by_provider(
    'notion',
    container_tags=['user-123']
)
print('Deleted Notion connection for user')
```

```
# Delete by connection ID
curl -X DELETE "https://api.supermemory.ai/v3/connections/connection_id_123" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"

# Delete by provider and container tags
curl -X DELETE "https://api.supermemory.ai/v3/connections/notion" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"containerTags": ["user-123"]}'
```

Deleting a connection will:

- Stop all future syncs from Notion
- Remove the OAuth authorization
- Keep existing synced documents in Supermemory (they won’t be deleted)

## [​](https://supermemory.ai/docs/connectors/notion\#advanced-configuration)  Advanced Configuration

### [​](https://supermemory.ai/docs/connectors/notion\#custom-notion-integration)  Custom Notion Integration

For production deployments, create your own Notion integration:

- TypeScript

- Python

- cURL


```
// First, update organization settings with your Notion app credentials
await client.settings.update({
  notionCustomKeyEnabled: true,
  notionClientId: 'your-notion-client-id',
  notionClientSecret: 'your-notion-client-secret'
});

// Then create connections using your custom integration
const connection = await client.connections.create('notion', {
  redirectUrl: 'https://yourapp.com/callback',
  containerTags: ['org-456', 'user-789'],
  metadata: { customIntegration: true }
});
```

```
# First, update organization settings with your Notion app credentials
client.settings.update(
    notion_custom_key_enabled=True,
    notion_client_id='your-notion-client-id',
    notion_client_secret='your-notion-client-secret'
)

# Then create connections using your custom integration
connection = client.connections.create(
    'notion',
    redirect_url='https://yourapp.com/callback',
    container_tags=['org-456', 'user-789'],
    metadata={'customIntegration': True}
)
```

```
# Update organization settings
curl -X PATCH "https://api.supermemory.ai/v3/settings" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "notionCustomKeyEnabled": true,
    "notionClientId": "your-notion-client-id",
    "notionClientSecret": "your-notion-client-secret"
  }'
```

### [​](https://supermemory.ai/docs/connectors/notion\#content-filtering)  Content Filtering

Control which Notion content gets synced:

- TypeScript

- Python

- cURL


```
// Configure intelligent filtering for Notion content
await client.settings.update({
  shouldLLMFilter: true,
  includeItems: {
    pageTypes: ['page', 'database'],
    titlePatterns: ['*Spec*', '*Documentation*', '*Meeting Notes*'],
    databases: ['Project Tracker', 'Knowledge Base', 'Team Wiki']
  },
  excludeItems: {
    titlePatterns: ['*Draft*', '*Personal*', '*Archive*'],
    databases: ['Personal Tasks', 'Scratchpad']
  },
  filterPrompt: "Sync professional documentation, project specs, meeting notes, and team knowledge. Skip personal notes, drafts, and archived content."
});
```

```
# Configure intelligent filtering for Notion content
client.settings.update(
    should_llm_filter=True,
    include_items={
        'pageTypes': ['page', 'database'],
        'titlePatterns': ['*Spec*', '*Documentation*', '*Meeting Notes*'],
        'databases': ['Project Tracker', 'Knowledge Base', 'Team Wiki']
    },
    exclude_items={
        'titlePatterns': ['*Draft*', '*Personal*', '*Archive*'],
        'databases': ['Personal Tasks', 'Scratchpad']
    },
    filter_prompt="Sync professional documentation, project specs, meeting notes, and team knowledge. Skip personal notes, drafts, and archived content."
)
```

```
# Configure intelligent filtering for Notion content
curl -X PATCH "https://api.supermemory.ai/v3/settings" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "shouldLLMFilter": true,
    "includeItems": {
      "pageTypes": ["page", "database"],
      "titlePatterns": ["*Spec*", "*Documentation*", "*Meeting Notes*"],
      "databases": ["Project Tracker", "Knowledge Base", "Team Wiki"]
    },
    "excludeItems": {
      "titlePatterns": ["*Draft*", "*Personal*", "*Archive*"],
      "databases": ["Personal Tasks", "Scratchpad"]
    },
    "filterPrompt": "Sync professional documentation, project specs, meeting notes, and team knowledge. Skip personal notes, drafts, and archived content."
  }'

# Response:
# {
#   "success": true,
#   "message": "Settings updated successfully"
# }
```

## [​](https://supermemory.ai/docs/connectors/notion\#workspace-permissions)  Workspace Permissions

Notion connector respects workspace permissions:

| Permission Level | Sync Behavior |
| --- | --- |
| **Admin** | Full workspace access |
| **Member** | Pages with read access |
| **Guest** | Only shared pages |
| **No Access** | Removed from index |

## [​](https://supermemory.ai/docs/connectors/notion\#database-integration)  Database Integration

### [​](https://supermemory.ai/docs/connectors/notion\#database-properties)  Database Properties

Notion database properties are mapped to metadata:

```
// Example: Project database with properties
const documents = await client.connections.listDocuments('notion', {
  containerTags: ['user-123']
});

// Find database entries
const projectEntries = documents.filter(doc =>
  doc.metadata?.database === 'Projects'
);

// Database properties become searchable metadata
const projectWithStatus = await client.search.documents({
  q: "machine learning project",
  containerTags: ['user-123'],
  filters: JSON.stringify({
    AND: [\
      { key: "status", value: "In Progress", negate: false },\
      { key: "priority", value: "High", negate: false }\
    ]
  })
});
```

### [​](https://supermemory.ai/docs/connectors/notion\#optimization-strategies)  Optimization Strategies

1. **Set appropriate document limits** based on workspace size
2. **Use targeted container tags** for efficient organization
3. **Monitor database sync performance** for large datasets
4. **Implement content filtering** to sync only relevant pages
5. **Handle webhook delays** gracefully in your application

**Notion-Specific Benefits:**

- Real-time sync via webhooks for instant updates
- Rich formatting and block structure preserved
- Database properties become searchable metadata
- Hierarchical page structure maintained
- Collaborative workspace support

**Important Limitations:**

- Complex block formatting may be simplified in markdown conversion
- Large databases can take significant time to sync initially
- Workspace permissions affect which content is accessible
- Notion API rate limits may affect sync speed for large workspaces
- Embedded files and images are referenced, not stored directly

Was this page helpful?

YesNo

[Overview](https://supermemory.ai/docs/connectors/overview) [Google Drive Connector](https://supermemory.ai/docs/connectors/google-drive)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)