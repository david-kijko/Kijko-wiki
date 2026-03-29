---
url: https://supermemory.ai/docs/api-reference/manage-documents/add-document
title: Add document - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/api-reference/manage-documents/add-document#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Manage Documents

Add document

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

Add document

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({content: '<string>'})
};

fetch('https://api.supermemory.ai/v3/documents', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

200

401

500

```
{
  "id": "<string>",
  "status": "<string>"
}
```

POST

/

v3

/

documents

Try it

Add document

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({content: '<string>'})
};

fetch('https://api.supermemory.ai/v3/documents', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

200

401

500

```
{
  "id": "<string>",
  "status": "<string>"
}
```

#### Authorizations

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#authorization-authorization)

Authorization

string

header

required

Bearer authentication header of the form `Bearer <token>`, where `<token>` is your auth token.

#### Body

application/json

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-content)

content

string

required

The content to extract and process into a document. This can be a URL to a website, a PDF, an image, or a video.

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-container-tag)

containerTag

string

Optional tag this document should be containerized by. Max 100 characters, alphanumeric with hyphens, underscores, and dots only.

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-container-tags)

containerTags

string\[\]

deprecated

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-entity-context)

entityContext

string

Optional entity context for this container tag. Max 1500 characters. Used during document processing to guide memory extraction.

Maximum string length: `1500`

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-custom-id)

customId

string

Optional custom ID of the document. Max 100 characters, alphanumeric with hyphens, underscores, and dots only.

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#body-metadata)

metadata

object

Optional metadata for the document.

Showchild attributes

#### Response

200

application/json

Document added successfully

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#response-id)

id

string

required

Unique identifier of the document

[​](https://supermemory.ai/docs/api-reference/manage-documents/add-document#response-status)

status

string

required

Status of the document

Was this page helpful?

YesNo

[Batch add documents](https://supermemory.ai/docs/api-reference/manage-documents/batch-add-documents)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)