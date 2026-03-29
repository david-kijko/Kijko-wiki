---
url: https://supermemory.ai/docs/connectors/github
title: GitHub Connector - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/connectors/github#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Connectors

GitHub Connector

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Quick Setup](https://supermemory.ai/docs/connectors/github#quick-setup)
- [1\. Create GitHub Connection](https://supermemory.ai/docs/connectors/github#1-create-github-connection)
- [2\. Handle OAuth Callback](https://supermemory.ai/docs/connectors/github#2-handle-oauth-callback)
- [3\. List and Configure Repositories](https://supermemory.ai/docs/connectors/github#3-list-and-configure-repositories)
- [Supported Document Types](https://supermemory.ai/docs/connectors/github#supported-document-types)
- [Incremental Sync with Webhooks](https://supermemory.ai/docs/connectors/github#incremental-sync-with-webhooks)
- [How It Works](https://supermemory.ai/docs/connectors/github#how-it-works)
- [Webhook Security](https://supermemory.ai/docs/connectors/github#webhook-security)
- [Connection Management](https://supermemory.ai/docs/connectors/github#connection-management)
- [List All Connections](https://supermemory.ai/docs/connectors/github#list-all-connections)
- [Update Repository Configuration](https://supermemory.ai/docs/connectors/github#update-repository-configuration)
- [Delete Connection](https://supermemory.ai/docs/connectors/github#delete-connection)
- [Manual Sync](https://supermemory.ai/docs/connectors/github#manual-sync)
- [Advanced Configuration](https://supermemory.ai/docs/connectors/github#advanced-configuration)
- [Custom OAuth Application](https://supermemory.ai/docs/connectors/github#custom-oauth-application)

Connect GitHub repositories to sync documentation files into your Supermemory knowledge base with OAuth authentication, webhook support, and automatic incremental syncing.

The GitHub connector requires a **Scale Plan** or **Enterprise Plan**.

## [​](https://supermemory.ai/docs/connectors/github\#quick-setup)  Quick Setup

### [​](https://supermemory.ai/docs/connectors/github\#1-create-github-connection)  1\. Create GitHub Connection

- TypeScript

- Python

- cURL


```
import Supermemory from 'supermemory';

const client = new Supermemory({
  apiKey: process.env.SUPERMEMORY_API_KEY!
});

const connection = await client.connections.create('github', {
  redirectUrl: 'https://yourapp.com/auth/github/callback',
  containerTags: ['user-123', 'github-sync'],
  documentLimit: 5000,
  metadata: {
    source: 'github',
    team: 'engineering'
  }
});

// Redirect user to GitHub OAuth
window.location.href = connection.authLink;
console.log('Auth expires in:', connection.expiresIn);
```

```
from supermemory import Supermemory
import os

client = Supermemory(api_key=os.environ.get("SUPERMEMORY_API_KEY"))

connection = client.connections.create(
    'github',
    redirect_url='https://yourapp.com/auth/github/callback',
    container_tags=['user-123', 'github-sync'],
    document_limit=10000,
    metadata={
        'source': 'github',
        'team': 'engineering'
    }
)

# Redirect user to GitHub OAuth
print(f'Redirect to: {connection.auth_link}')
print(f'Expires in: {connection.expires_in}')
```

```
curl -X POST "https://api.supermemory.ai/v3/connections/github" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "redirectUrl": "https://yourapp.com/auth/github/callback",
    "containerTags": ["user-123", "github-sync"],
    "documentLimit": 5000,
    "metadata": {
      "source": "github",
      "team": "engineering"
    }
  }'
```

**OAuth Scopes:** The GitHub connector requires these scopes:

- `repo` \- Access to private and public repositories
- `user:email` \- Access to user’s email address
- `admin:repo_hook` \- Manage webhooks for incremental sync

### [​](https://supermemory.ai/docs/connectors/github\#2-handle-oauth-callback)  2\. Handle OAuth Callback

After the user grants permissions, GitHub redirects to your callback URL. The connection is automatically established, and the user can now select which repositories to sync.

### [​](https://supermemory.ai/docs/connectors/github\#3-list-and-configure-repositories)  3\. List and Configure Repositories

Unlike other connectors, GitHub requires repository selection before syncing begins. This gives your users control over which repositories to index.

**Generic Endpoints:** GitHub uses the generic resource management endpoints (Get Resources and Configure Connection) that work for any provider supporting resource management. See [Managing Connection Resources](https://supermemory.ai/docs/memory-api/connectors/managing-resources) for detailed API documentation.

- TypeScript

- Python

- cURL


```
// List available repositories for the user
const repositories = await client.connections.github.listRepositories(
  connectionId,
  {
    page: 1,
    perPage: 100
  }
);

// Display repositories in your UI
repositories.forEach(repo => {
  console.log(`${repo.full_name} - ${repo.description}`);
  console.log(`Private: ${repo.private}`);
  console.log(`Default branch: ${repo.default_branch}`);
  console.log(`Last updated: ${repo.updated_at}`);
});

// After user selects repositories, configure them
await client.connections.github.configure(connectionId, {
  repositories: [\
    {\
      id: repo.id,\
      name: repo.full_name,\
      defaultBranch: repo.default_branch\
    }\
  ]
});

console.log('Repository sync initiated');
```

```
# List available repositories for the user
repositories = client.connections.github.list_repositories(
    connection_id,
    page=1,
    per_page=100
)

# Display repositories in your UI
for repo in repositories:
    print(f'{repo.full_name} - {repo.description}')
    print(f'Private: {repo.private}')
    print(f'Default branch: {repo.default_branch}')
    print(f'Last updated: {repo.updated_at}')

# After user selects repositories, configure them
client.connections.github.configure(
    connection_id,
    repositories=[\
        {\
            'id': repo.id,\
            'name': repo.full_name,\
            'defaultBranch': repo.default_branch\
        }\
    ]
)

print('Repository sync initiated')
```

```
# List available repositories
curl -X GET "https://api.supermemory.ai/v3/connections/{connectionId}/resources?page=1&per_page=100" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"

# Configure selected repositories
curl -X POST "https://api.supermemory.ai/v3/connections/{connectionId}/configure" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "resources": [\
      {\
        "id": 123456789,\
        "name": "your-org/documentation",\
        "defaultBranch": "main"\
      },\
      {\
        "id": 987654321,\
        "name": "your-org/api-docs",\
        "defaultBranch": "main"\
      }\
    ]
  }'
```

**API-First Design:**Supermemory provides the API endpoints to list and configure repositories. As a Supermemory customer, you need to build the UI in your application where your end-users can:

1. View their available GitHub repositories
2. Select which repositories to sync
3. Confirm the selection

This gives you complete control over the user experience and allows you to integrate repository selection seamlessly into your application’s workflow.

## [​](https://supermemory.ai/docs/connectors/github\#supported-document-types)  Supported Document Types

The GitHub connector syncs documentation and text files with the following extensions:

- **Markdown files**: `.md`, `.mdx`, `.markdown`
- **Text files**: `.txt`
- **reStructuredText**: `.rst`
- **AsciiDoc**: `.adoc`
- **Org-mode**: `.org`

Files are indexed as `github_markdown` document type in Supermemory.

Only text-based documentation files are synced. Binary files, images, and code files (`.js`, `.py`, `.go`, etc.) are excluded by default to focus on searchable documentation content.

## [​](https://supermemory.ai/docs/connectors/github\#incremental-sync-with-webhooks)  Incremental Sync with Webhooks

The GitHub connector automatically sets up webhooks for real-time incremental syncing. When files are pushed or deleted in configured repositories, Supermemory is notified immediately.

**Batch Processing:** Webhook events are processed in batches with a 10-minute delay to optimize performance and prevent excessive syncing during rapid commits. This means changes pushed to your repository will be reflected in Supermemory within approximately 10 minutes.

### [​](https://supermemory.ai/docs/connectors/github\#how-it-works)  How It Works

1. **Webhook Setup**: When you configure repositories, a webhook is automatically installed in each repository
2. **Push Events**: When commits are pushed to the default branch, changed documentation files are synced
3. **Delete Events**: When documentation files are deleted, they’re removed from your Supermemory knowledge base
4. **Incremental Updates**: Only changed files are processed, keeping sync fast and efficient

### [​](https://supermemory.ai/docs/connectors/github\#webhook-security)  Webhook Security

Webhooks are secured using HMAC-SHA256 signature validation with constant-time comparison. Supermemory automatically validates that webhook events come from GitHub before processing them. Each repository gets a unique webhook secret for maximum security.

- TypeScript

- Python

- cURL


```
// Check webhook status
const connection = await client.connections.get(connectionId);

console.log('Webhooks configured:', connection.metadata.webhooks?.length);
console.log('Last sync:', new Date(connection.metadata.lastSyncedAt));
console.log('Repositories:', connection.metadata.repositories);
```

```
# Check webhook status
connection = client.connections.get(connection_id)

print(f'Webhooks configured: {len(connection.metadata.get("webhooks", []))}')
print(f'Last sync: {connection.metadata.get("lastSyncedAt")}')
print(f'Repositories: {connection.metadata.get("repositories")}')
```

```
# Get connection details including webhook status
curl -X POST "https://api.supermemory.ai/v3/connections/list" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

## [​](https://supermemory.ai/docs/connectors/github\#connection-management)  Connection Management

### [​](https://supermemory.ai/docs/connectors/github\#list-all-connections)  List All Connections

- TypeScript

- Python

- cURL


```
// List all GitHub connections for specific container tags
const connections = await client.connections.list({
  containerTags: ['user-123'],
  provider: 'github'
});

connections.forEach(conn => {
  console.log(`Provider: ${conn.provider}`);
  console.log(`ID: ${conn.id}`);
  console.log(`Email: ${conn.email}`);
  console.log(`Created: ${conn.createdAt}`);
  console.log(`Document limit: ${conn.documentLimit}`);
  console.log(`Repositories: ${conn.metadata.repositories?.length || 0}`);
  console.log('---');
});
```

```
# List all GitHub connections for specific container tags
connections = client.connections.list(
    container_tags=['user-123'],
    provider='github'
)

for conn in connections:
    print(f'Provider: {conn.provider}')
    print(f'ID: {conn.id}')
    print(f'Email: {conn.email}')
    print(f'Created: {conn.created_at}')
    print(f'Document limit: {conn.document_limit}')
    print(f'Repositories: {len(conn.metadata.get("repositories", []))}')
    print('---')
```

```
# List all GitHub connections for specific container tags
curl -X POST "https://api.supermemory.ai/v3/connections/list" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "containerTags": ["user-123"],
    "provider": "github"
  }'
```

### [​](https://supermemory.ai/docs/connectors/github\#update-repository-configuration)  Update Repository Configuration

You can update which repositories are synced at any time:

- TypeScript

- Python

- cURL


```
// Add or remove repositories
await client.connections.github.configure(connectionId, {
  repositories: [\
    {\
      id: 123456789,\
      name: 'your-org/documentation',\
      defaultBranch: 'main'\
    },\
    {\
      id: 987654321,\
      name: 'your-org/new-repo',\
      defaultBranch: 'develop'  // Can specify different branch\
    }\
  ]
});

console.log('Repository configuration updated');
```

```
# Add or remove repositories
client.connections.github.configure(
    connection_id,
    repositories=[\
        {\
            'id': 123456789,\
            'name': 'your-org/documentation',\
            'defaultBranch': 'main'\
        },\
        {\
            'id': 987654321,\
            'name': 'your-org/new-repo',\
            'defaultBranch': 'develop'  # Can specify different branch\
        }\
    ]
)

print('Repository configuration updated')
```

```
# Update repository configuration
curl -X POST "https://api.supermemory.ai/v3/connections/{connectionId}/configure" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "resources": [\
      {\
        "id": 123456789,\
        "name": "your-org/documentation",\
        "defaultBranch": "main"\
      },\
      {\
        "id": 987654321,\
        "name": "your-org/new-repo",\
        "defaultBranch": "develop"\
      }\
    ]
  }'
```

When you update the repository configuration:

- New repositories are added and synced immediately
- Removed repositories have their webhooks deleted
- Existing documents from removed repositories remain in Supermemory unless you delete them manually

### [​](https://supermemory.ai/docs/connectors/github\#delete-connection)  Delete Connection

- TypeScript

- Python

- cURL


```
// Delete by connection ID
const result = await client.connections.deleteByID(connectionId);

// Or delete by provider (requires container tags)
const result = await client.connections.deleteByProvider('github', {
  containerTags: ['user-123']
});

console.log('Deleted connection:', result.id);
```

```
# Delete by connection ID
result = client.connections.delete_by_id(connection_id)

# Or delete by provider (requires container tags)
result = client.connections.delete_by_provider(
    provider='github',
    container_tags=['user-123']
)

print(f'Deleted connection: {result.id}')
```

```
# Delete by connection ID
curl -X DELETE "https://api.supermemory.ai/v3/connections/{connectionId}" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"
```

Deleting a GitHub connection will:

- Stop all future syncs from configured repositories
- Remove all webhooks from the repositories
- Revoke the OAuth authorization
- **Permanently delete all synced documents** from your Supermemory knowledge base (unless you pass `deleteDocuments=false` as a query parameter to keep them)

### [​](https://supermemory.ai/docs/connectors/github\#manual-sync)  Manual Sync

Trigger a manual synchronization for all configured repositories:

- TypeScript

- Python

- cURL


```
// Trigger sync for GitHub connections
await client.connections.import('github');

// Trigger sync for specific container tags
await client.connections.import('github', {
  containerTags: ['user-123']
});

console.log('Manual sync initiated');
```

```
# Trigger sync for GitHub connections
client.connections.import_('github')

# Trigger sync for specific container tags
client.connections.import_(
    'github',
    container_tags=['user-123']
)

print('Manual sync initiated')
```

```
# Trigger sync for all GitHub connections
curl -X POST "https://api.supermemory.ai/v3/connections/github/import" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"

# Trigger sync for specific container tags
curl -X POST "https://api.supermemory.ai/v3/connections/github/import" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "containerTags": ["user-123"]
  }'

# Response: {"message": "Manual sync initiated", "provider": "github"}
```

## [​](https://supermemory.ai/docs/connectors/github\#advanced-configuration)  Advanced Configuration

### [​](https://supermemory.ai/docs/connectors/github\#custom-oauth-application)  Custom OAuth Application

For white-label deployments or custom branding, configure your own GitHub OAuth app using the settings API:

- TypeScript

- Python

- cURL


```
// Update organization settings with your GitHub OAuth app
await client.settings.update({
  githubCustomKeyEnabled: true,
  githubClientId: 'Iv1.1234567890abcdef',
  githubClientSecret: 'your-github-client-secret'
});

// Get current settings
const settings = await client.settings.get();
console.log('GitHub custom key enabled:', settings.githubCustomKeyEnabled);
console.log('Client ID configured:', !!settings.githubClientId);
```

```
# Update organization settings with your GitHub OAuth app
client.settings.update(
    github_custom_key_enabled=True,
    github_client_id='Iv1.1234567890abcdef',
    github_client_secret='your-github-client-secret'
)

# Get current settings
settings = client.settings.get()
print(f'GitHub custom key enabled: {settings.github_custom_key_enabled}')
print(f'Client ID configured: {bool(settings.github_client_id)}')
```

```
# Update organization settings
curl -X PATCH "https://api.supermemory.ai/v3/settings" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "githubCustomKeyEnabled": true,
    "githubClientId": "Iv1.1234567890abcdef",
    "githubClientSecret": "your-github-client-secret"
  }'

# Get current settings
curl -X GET "https://api.supermemory.ai/v3/settings" \
  -H "Authorization: Bearer $SUPERMEMORY_API_KEY"
```

**Setting up a GitHub OAuth App:**

1. Go to GitHub Settings → Developer settings → OAuth Apps
2. Click “New OAuth App”
3. Set Authorization callback URL to: `https://api.supermemory.ai/v3/connections/auth/callback/github`
4. Copy the Client ID and generate a Client Secret
5. Configure them in Supermemory using the settings API above

After configuration, all new GitHub connections will use your custom OAuth app instead of Supermemory’s default app.

Was this page helpful?

YesNo

[S3 Connector](https://supermemory.ai/docs/connectors/s3) [Web Crawler Connector](https://supermemory.ai/docs/connectors/web-crawler)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)