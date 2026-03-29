---
url: https://supermemory.ai/docs/authentication
title: Authentication - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/authentication#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

Authentication

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [API Keys](https://supermemory.ai/docs/authentication#api-keys)
- [Connector Branding](https://supermemory.ai/docs/authentication#connector-branding)
- [Scoped API Keys](https://supermemory.ai/docs/authentication#scoped-api-keys)

## [​](https://supermemory.ai/docs/authentication\#api-keys)  API Keys

All API requests require authentication using a Bearer token. Get your API key from the [Developer Platform](https://console.supermemory.ai/).Include your key in all requests:

cURL

TypeScript

Python

```
curl https://api.supermemory.ai/v3/search \
  --header 'Authorization: Bearer YOUR_API_KEY' \
  --header 'Content-Type: application/json' \
  -d '{"q": "hello"}'
```

* * *

## [​](https://supermemory.ai/docs/authentication\#connector-branding)  Connector Branding

When users connect external services (Google Drive, Notion, OneDrive), they see a “Log in to **Supermemory**” prompt by default. You can replace this with your own app name by providing your own OAuth credentials via the settings endpoint.

```
await client.settings.update({
  googleDriveCustomKeyEnabled: true,
  googleDriveClientId: "your-client-id.apps.googleusercontent.com",
  googleDriveClientSecret: "your-client-secret"
});
```

This works for Google Drive, Notion, and OneDrive. See the full setup in [Customization](https://supermemory.ai/docs/concepts/customization).

* * *

## [​](https://supermemory.ai/docs/authentication\#scoped-api-keys)  Scoped API Keys

Container-scoped keys

Scoped keys are restricted to a single `containerTag`. They can only access documents and search within that container — useful for giving limited access to specific projects, users, or tenants without exposing your full API key.**Allowed endpoints:**`/v3/documents`, `/v3/memories`, `/v4/memories`, `/v3/search`, `/v4/search`, `/v4/profile`

### [​](https://supermemory.ai/docs/authentication\#create-a-scoped-key)  Create a scoped key

```
curl https://api.supermemory.ai/v3/auth/scoped-key \
  --request POST \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer YOUR_API_KEY' \
  -d '{
    "containerTag": "my-project",
    "name": "my-key-name",
    "expiresInDays": 30
  }'
```

### [​](https://supermemory.ai/docs/authentication\#parameters)  Parameters

| Parameter | Required | Default | Description |
| --- | --- | --- | --- |
| `containerTag` | Yes | — | Alphanumeric, hyphens, underscores, colons, dots |
| `name` | No | `scoped_{containerTag}` | Display name for the key |
| `expiresInDays` | No | — | 1–365 days |
| `rateLimitMax` | No | `500` | Max requests per window (1–10,000) |
| `rateLimitTimeWindow` | No | `60000` | Window in milliseconds (1–3,600,000) |

### [​](https://supermemory.ai/docs/authentication\#response)  Response

```
{
  "key": "sm_orgId_...",
  "id": "key-id",
  "name": "scoped_my-project",
  "containerTag": "my-project",
  "expiresAt": "2026-03-08T00:00:00.000Z",
  "allowedEndpoints": ["/v3/documents", "/v3/memories", "/v4/memories", "/v3/search", "/v4/search", "/v4/profile"]
}
```

Use the returned key exactly like a normal API key — it just won’t work outside its container scope.

### [​](https://supermemory.ai/docs/authentication\#disable-a-scoped-key)  Disable a scoped key

To revoke a scoped key, send a `DELETE` request with the `id` returned at creation time. This disables the key immediately — any subsequent requests using it will get a `401`. Memories and container tags are **not** affected.

```
curl https://api.supermemory.ai/v3/auth/scoped-key/KEY_ID \
  --request DELETE \
  --header 'Authorization: Bearer YOUR_API_KEY'
```

**Response:**

```
{ "success": true }
```

Was this page helpful?

YesNo

[Customization](https://supermemory.ai/docs/concepts/customization) [Add context](https://supermemory.ai/docs/add-memories)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)