---
url: https://supermemory.ai/docs/api-reference/memories/create-memories-directly
title: Create memories directly - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Memories

Create memories directly

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

Create memories directly

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({
    memories: [\
      {\
        content: 'John prefers dark mode',\
        isStatic: false,\
        metadata: {},\
        forgetAfter: '2026-06-01T00:00:00Z',\
        forgetReason: 'temporary project deadline',\
        temporalContext: {documentDate: '<string>', eventDate: ['<string>']}\
      }\
    ],
    containerTag: 'user_123'
  })
};

fetch('https://api.supermemory.ai/v4/memories', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

201

400

401

404

500

```
{
  "documentId": "<string>",
  "memories": [\
    {\
      "id": "<string>",\
      "memory": "<string>",\
      "isStatic": true,\
      "createdAt": "<string>",\
      "forgetAfter": "<string>",\
      "forgetReason": "<string>"\
    }\
  ]
}
```

POST

/

v4

/

memories

Try it

Create memories directly

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({
    memories: [\
      {\
        content: 'John prefers dark mode',\
        isStatic: false,\
        metadata: {},\
        forgetAfter: '2026-06-01T00:00:00Z',\
        forgetReason: 'temporary project deadline',\
        temporalContext: {documentDate: '<string>', eventDate: ['<string>']}\
      }\
    ],
    containerTag: 'user_123'
  })
};

fetch('https://api.supermemory.ai/v4/memories', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

201

400

401

404

500

```
{
  "documentId": "<string>",
  "memories": [\
    {\
      "id": "<string>",\
      "memory": "<string>",\
      "isStatic": true,\
      "createdAt": "<string>",\
      "forgetAfter": "<string>",\
      "forgetReason": "<string>"\
    }\
  ]
}
```

#### Authorizations

[​](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#authorization-authorization)

Authorization

string

header

required

Bearer authentication header of the form `Bearer <token>`, where `<token>` is your auth token.

#### Body

application/json

[​](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#body-memories)

memories

object\[\]

required

Array of memories to create

Required array length: `1 - 100` elements

Showchild attributes

[​](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#body-container-tag)

containerTag

string

required

The space / container tag these memories belong to.

Maximum string length: `100`

Pattern: `^[a-zA-Z0-9_:-]+$`

Example:

`"user_123"`

#### Response

201

application/json

Memories created successfully

Response after creating memories

[​](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#response-document-id-one-of-0)

documentId

string \| null

required

ID of the source document created

[​](https://supermemory.ai/docs/api-reference/memories/create-memories-directly#response-memories)

memories

object\[\]

required

Showchild attributes

Was this page helpful?

YesNo

[Merge container tags](https://supermemory.ai/docs/api-reference/container-tags/merge-container-tags) [Forget a memory](https://supermemory.ai/docs/api-reference/memories/forget-a-memory)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)