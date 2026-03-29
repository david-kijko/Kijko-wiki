---
url: https://supermemory.ai/docs/api-reference/search/search-memory-entries
title: Search memory entries - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/api-reference/search/search-memory-entries#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Search

Search memory entries

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

Search memory entries

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({q: 'machine learning concepts'})
};

fetch('https://api.supermemory.ai/v4/search', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

200

400

401

402

500

```
{
  "results": [\
    {\
      "id": "mem_abc123",\
      "metadata": {\
        "source": "conversation",\
        "confidence": 0.9\
      },\
      "updatedAt": "<string>",\
      "similarity": 0.89,\
      "memory": "John prefers machine learning over traditional programming",\
      "chunk": "This is a chunk of content from a document...",\
      "version": 3,\
      "context": {\
        "parents": [\
          {\
            "relation": "updates",\
            "memory": "Earlier version: Dhravya is working on a patent at Cloudflare.",\
            "updatedAt": "<string>",\
            "version": -1,\
            "metadata": {}\
          }\
        ],\
        "children": [\
          {\
            "relation": "extends",\
            "memory": "Later version: Dhravya has filed the patent successfully.",\
            "updatedAt": "<string>",\
            "version": 1,\
            "metadata": {}\
          }\
        ]\
      },\
      "documents": [\
        {\
          "id": "doc_xyz789",\
          "createdAt": "<string>",\
          "updatedAt": "<string>",\
          "title": "Introduction to Machine Learning",\
          "type": "web",\
          "metadata": {\
            "category": "technology",\
            "isPublic": true,\
            "readingTime": 5,\
            "source": "web",\
            "tag_1": "ai",\
            "tag_2": "machine-learning"\
          },\
          "summary": "A comprehensive guide to understanding the basics of machine learning and its applications."\
        }\
      ],\
      "chunks": [\
        {\
          "content": "This is a chunk of content from the document...",\
          "score": 0.85,\
          "position": 0,\
          "documentId": "doc_xyz789"\
        }\
      ]\
    }\
  ],
  "timing": 245,
  "total": 5
}
```

POST

/

v4

/

search

Try it

Search memory entries

JavaScript

```
const options = {
  method: 'POST',
  headers: {Authorization: 'Bearer <token>', 'Content-Type': 'application/json'},
  body: JSON.stringify({q: 'machine learning concepts'})
};

fetch('https://api.supermemory.ai/v4/search', options)
  .then(res => res.json())
  .then(res => console.log(res))
  .catch(err => console.error(err));
```

200

400

401

402

500

```
{
  "results": [\
    {\
      "id": "mem_abc123",\
      "metadata": {\
        "source": "conversation",\
        "confidence": 0.9\
      },\
      "updatedAt": "<string>",\
      "similarity": 0.89,\
      "memory": "John prefers machine learning over traditional programming",\
      "chunk": "This is a chunk of content from a document...",\
      "version": 3,\
      "context": {\
        "parents": [\
          {\
            "relation": "updates",\
            "memory": "Earlier version: Dhravya is working on a patent at Cloudflare.",\
            "updatedAt": "<string>",\
            "version": -1,\
            "metadata": {}\
          }\
        ],\
        "children": [\
          {\
            "relation": "extends",\
            "memory": "Later version: Dhravya has filed the patent successfully.",\
            "updatedAt": "<string>",\
            "version": 1,\
            "metadata": {}\
          }\
        ]\
      },\
      "documents": [\
        {\
          "id": "doc_xyz789",\
          "createdAt": "<string>",\
          "updatedAt": "<string>",\
          "title": "Introduction to Machine Learning",\
          "type": "web",\
          "metadata": {\
            "category": "technology",\
            "isPublic": true,\
            "readingTime": 5,\
            "source": "web",\
            "tag_1": "ai",\
            "tag_2": "machine-learning"\
          },\
          "summary": "A comprehensive guide to understanding the basics of machine learning and its applications."\
        }\
      ],\
      "chunks": [\
        {\
          "content": "This is a chunk of content from the document...",\
          "score": 0.85,\
          "position": 0,\
          "documentId": "doc_xyz789"\
        }\
      ]\
    }\
  ],
  "timing": 245,
  "total": 5
}
```

#### Authorizations

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#authorization-authorization)

Authorization

string

header

required

Bearer authentication header of the form `Bearer <token>`, where `<token>` is your auth token.

#### Body

application/json

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-q)

q

string

required

Search query string

Minimum string length: `1`

Example:

`"machine learning concepts"`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-container-tag)

containerTag

string

Optional tag this search should be containerized by. This can be an ID for your user, a project ID, or any other identifier you wish to use to filter memories.

Maximum string length: `100`

Pattern: `^[a-zA-Z0-9_:-]+$`

Example:

`"user_123"`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-threshold)

threshold

number

default:0.6

Threshold / sensitivity for memories selection. 0 is least sensitive (returns most memories, more results), 1 is most sensitive (returns lesser memories, accurate results)

Required range: `0 <= x <= 1`

Example:

`0.5`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-filters)

filters

object

Optional filters to apply to the search. Can be a JSON string or Query object.

- Option 1

- Option 2


Showchild attributes

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-include)

include

object

Showchild attributes

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-limit)

limit

integer

default:10

Maximum number of results to return

Required range: `1 < x <= 100`

Example:

`10`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-rerank)

rerank

boolean

default:false

If true, rerank the results based on the query. This is helpful if you want to ensure the most relevant results are returned.

Example:

`false`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-rewrite-query)

rewriteQuery

boolean

default:false

If true, rewrites the query to make it easier to find documents. This increases the latency by about 400ms

Example:

`false`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#body-search-mode)

searchMode

enum<string>

default:memories

Search mode. 'memories' searches only memory entries (default). 'hybrid' searches both memories and document chunks. 'documents' searches only document chunks.

Available options:

`memories`,

`hybrid`,

`documents`

Example:

`"memories"`

#### Response

200

application/json

Memory search results

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#response-results)

results

object\[\]

required

Array of matching memory entries and chunks with similarity scores. Contains memory results when searchMode='memories', both memory and chunk results when searchMode='hybrid', or only chunk results when searchMode='documents'. Memory results have 'memory' field, chunk results have 'chunk' field. BACKWARD COMPATIBILITY: When using deprecated include.chunks=true, only memory results are returned with chunks embedded in them (old format).

Showchild attributes

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#response-timing)

timing

number

required

Search execution time in milliseconds

Example:

`245`

[​](https://supermemory.ai/docs/api-reference/search/search-memory-entries#response-total)

total

number

required

Total number of results returned

Example:

`5`

Was this page helpful?

YesNo

[Search documents](https://supermemory.ai/docs/api-reference/search/search-documents) [Get settings](https://supermemory.ai/docs/api-reference/organization-settings/get-settings)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)