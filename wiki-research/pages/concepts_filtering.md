---
url: https://supermemory.ai/docs/concepts/filtering
title: Organizing & Filtering Memories - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/concepts/filtering#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Concepts

Organizing & Filtering Memories

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Container Tags](https://supermemory.ai/docs/concepts/filtering#container-tags)
- [Adding Memories with Tags](https://supermemory.ai/docs/concepts/filtering#adding-memories-with-tags)
- [Searching with Tags](https://supermemory.ai/docs/concepts/filtering#searching-with-tags)
- [Recommended Patterns](https://supermemory.ai/docs/concepts/filtering#recommended-patterns)
- [Metadata](https://supermemory.ai/docs/concepts/filtering#metadata)
- [Adding Memories with Metadata](https://supermemory.ai/docs/concepts/filtering#adding-memories-with-metadata)
- [Searching with Metadata Filters](https://supermemory.ai/docs/concepts/filtering#searching-with-metadata-filters)
- [Filter Types](https://supermemory.ai/docs/concepts/filtering#filter-types)
- [Combining Filters](https://supermemory.ai/docs/concepts/filtering#combining-filters)
- [Excluding Results](https://supermemory.ai/docs/concepts/filtering#excluding-results)
- [Quick Reference](https://supermemory.ai/docs/concepts/filtering#quick-reference)
- [When Adding Memories](https://supermemory.ai/docs/concepts/filtering#when-adding-memories)
- [When Searching](https://supermemory.ai/docs/concepts/filtering#when-searching)
- [Metadata Key Rules](https://supermemory.ai/docs/concepts/filtering#metadata-key-rules)
- [Next Steps](https://supermemory.ai/docs/concepts/filtering#next-steps)

Supermemory provides two ways to organize your memories:

## Container Tags

**Organize memories** into isolated spaces by user, project, or workspace

## Metadata Filtering

**Query memories** by custom properties like category, status, or date

Both can be used independently or together for precise filtering.

* * *

## [​](https://supermemory.ai/docs/concepts/filtering\#container-tags)  Container Tags

Container tags create isolated memory spaces. Use them to separate memories by user, project, or any logical boundary.

### [​](https://supermemory.ai/docs/concepts/filtering\#adding-memories-with-tags)  Adding Memories with Tags

```
await client.add({
  content: "Meeting notes from Q1 planning",
  containerTags: ["user_123"]
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#searching-with-tags)  Searching with Tags

```
const results = await client.search.documents({
  q: "planning notes",
  containerTags: ["user_123"]
});
```

Container tags use **exact array matching**. A memory tagged `["user_123", "project_a"]` won’t match a search for just `["user_123"]`.

### [​](https://supermemory.ai/docs/concepts/filtering\#recommended-patterns)  Recommended Patterns

| Pattern | Example | Use Case |
| --- | --- | --- |
| User isolation | `user_{userId}` | Per-user memories |
| Project grouping | `project_{projectId}` | Project-specific content |
| Hierarchical | `org_{orgId}_team_{teamId}` | Multi-level organization |

More Container Tag Examples

```
// Multi-tenant SaaS - isolate by organization and user
await client.add({
  content: "Company policy document",
  containerTags: ["org_acme_user_john"]
});

// Search only within that user's org context
const results = await client.search.documents({
  q: "vacation policy",
  containerTags: ["org_acme_user_john"]
});

// Project-based isolation
await client.add({
  content: "Sprint 5 retrospective notes",
  containerTags: ["project_mobile_app"]
});

// Time-based segmentation
await client.add({
  content: "Q1 2024 financial report",
  containerTags: ["user_cfo_2024_q1"]
});
```

**API field differences:**

| Endpoint | Field | Type |
| --- | --- | --- |
| `/v3/search` | `containerTags` | Array |
| `/v4/search` | `containerTag` | String |
| `/v3/documents/list` | `containerTags` | Array |

* * *

## [​](https://supermemory.ai/docs/concepts/filtering\#metadata)  Metadata

Metadata lets you attach custom properties to memories and filter by them later.

### [​](https://supermemory.ai/docs/concepts/filtering\#adding-memories-with-metadata)  Adding Memories with Metadata

```
await client.add({
  content: "Technical design document for auth system",
  containerTags: ["user_123"],
  metadata: {
    category: "engineering",
    priority: "high",
    year: 2024
  }
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#searching-with-metadata-filters)  Searching with Metadata Filters

Filters must be wrapped in `AND` or `OR` arrays:

```
const results = await client.search.documents({
  q: "design document",
  containerTags: ["user_123"],
  filters: {
    AND: [\
      { key: "category", value: "engineering" },\
      { key: "priority", value: "high" }\
    ]
  }
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#filter-types)  Filter Types

| Type | Example | Description |
| --- | --- | --- |
| String equality | `{ key: "status", value: "published" }` | Exact match |
| String contains | `{ filterType: "string_contains", key: "title", value: "react" }` | Substring match |
| Numeric | `{ filterType: "numeric", key: "priority", value: "5", numericOperator: ">=" }` | Number comparison |
| Array contains | `{ filterType: "array_contains", key: "tags", value: "important" }` | Check array membership |

### [​](https://supermemory.ai/docs/concepts/filtering\#combining-filters)  Combining Filters

Use `AND` and `OR` for complex queries:

```
const results = await client.search.documents({
  q: "meeting notes",
  filters: {
    AND: [\
      { key: "type", value: "meeting" },\
      {\
        OR: [\
          { key: "team", value: "engineering" },\
          { key: "team", value: "product" }\
        ]\
      }\
    ]
  }
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#excluding-results)  Excluding Results

Use `negate: true` to exclude matches:

```
const results = await client.search.documents({
  q: "documentation",
  filters: {
    AND: [\
      { key: "status", value: "draft", negate: true }\
    ]
  }
});
```

More Metadata Filter Examples

**String contains (substring search):**

```
// Find documents with "machine learning" in the description
const results = await client.search.documents({
  q: "AI research",
  filters: {
    AND: [\
      {\
        filterType: "string_contains",\
        key: "description",\
        value: "machine learning",\
        ignoreCase: true\
      }\
    ]
  }
});
```

**Numeric comparisons:**

```
// Find high-priority items created after a specific date
const results = await client.search.documents({
  q: "tasks",
  filters: {
    AND: [\
      {\
        filterType: "numeric",\
        key: "priority",\
        value: "7",\
        numericOperator: ">="\
      },\
      {\
        filterType: "numeric",\
        key: "created_timestamp",\
        value: "1704067200",  // Unix timestamp\
        numericOperator: ">="\
      }\
    ]
  }
});
```

**Array contains (check array membership):**

```
// Find documents where a specific user is a participant
const results = await client.search.documents({
  q: "meeting notes",
  filters: {
    AND: [\
      {\
        filterType: "array_contains",\
        key: "participants",\
        value: "alice@company.com"\
      }\
    ]
  }
});
```

**Complex nested filters:**

```
// (category = "tech" OR category = "science") AND status != "archived"
const results = await client.search.documents({
  q: "research papers",
  filters: {
    AND: [\
      {\
        OR: [\
          { key: "category", value: "tech" },\
          { key: "category", value: "science" }\
        ]\
      },\
      { key: "status", value: "archived", negate: true }\
    ]
  }
});
```

**Numeric operator negation mapping:**
When using `negate: true`, operators flip:

- `<` becomes `>=`
- `<=` becomes `>`
- `>` becomes `<=`
- `>=` becomes `<`
- `=` becomes `!=`

Real-World Patterns

**User’s work documents from 2024:**

```
const results = await client.search.documents({
  q: "quarterly report",
  containerTags: ["user_123"],
  filters: {
    AND: [\
      { key: "category", value: "work" },\
      { key: "type", value: "report" },\
      { filterType: "numeric", key: "year", value: "2024", numericOperator: "=" }\
    ]
  }
});
```

**Team meeting notes with specific participants:**

```
const results = await client.search.documents({
  q: "sprint planning",
  containerTags: ["project_alpha"],
  filters: {
    AND: [\
      { key: "type", value: "meeting" },\
      {\
        OR: [\
          { filterType: "array_contains", key: "participants", value: "alice" },\
          { filterType: "array_contains", key: "participants", value: "bob" }\
        ]\
      }\
    ]
  }
});
```

**Exclude drafts and deprecated content:**

```
const results = await client.search.documents({
  q: "documentation",
  filters: {
    AND: [\
      { key: "status", value: "draft", negate: true },\
      { filterType: "string_contains", key: "content", value: "deprecated", negate: true },\
      { filterType: "array_contains", key: "tags", value: "archived", negate: true }\
    ]
  }
});
```

* * *

## [​](https://supermemory.ai/docs/concepts/filtering\#quick-reference)  Quick Reference

### [​](https://supermemory.ai/docs/concepts/filtering\#when-adding-memories)  When Adding Memories

```
await client.add({
  content: "Your content here",
  containerTags: ["user_123"],        // Isolation
  metadata: { key: "value" }          // Custom properties
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#when-searching)  When Searching

```
const results = await client.search.documents({
  q: "search query",
  containerTags: ["user_123"],        // Must match exactly
  filters: {                          // Optional metadata filters
    AND: [{ key: "status", value: "published" }]
  }
});
```

### [​](https://supermemory.ai/docs/concepts/filtering\#metadata-key-rules)  Metadata Key Rules

- Allowed characters: `a-z`, `A-Z`, `0-9`, `_`, `-`, `.`
- Max length: 64 characters
- No spaces or special characters

* * *

## [​](https://supermemory.ai/docs/concepts/filtering\#next-steps)  Next Steps

[**Search** \\
\\
Apply filters in search queries](https://supermemory.ai/docs/search)

[**Add Memories** \\
\\
Add content with container tags and metadata](https://supermemory.ai/docs/add-memories)

Was this page helpful?

YesNo

[Memory vs RAG](https://supermemory.ai/docs/concepts/memory-vs-rag) [User Profiles](https://supermemory.ai/docs/concepts/user-profiles)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)