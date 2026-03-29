---
url: https://supermemory.ai/docs/migration/from-mem0
title: Migrating from Mem0 to Supermemory - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/migration/from-mem0#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

From another provider

Migrating from Mem0 to Supermemory

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Why Migrate to Supermemory?](https://supermemory.ai/docs/migration/from-mem0#why-migrate-to-supermemory)
- [Quick Migration (All-in-One)](https://supermemory.ai/docs/migration/from-mem0#quick-migration-all-in-one)
- [Step-by-Step Migration](https://supermemory.ai/docs/migration/from-mem0#step-by-step-migration)
- [Option 1: Export via Dashboard (Recommended)](https://supermemory.ai/docs/migration/from-mem0#option-1-export-via-dashboard-recommended)
- [Option 2: Export via API](https://supermemory.ai/docs/migration/from-mem0#option-2-export-via-api)
- [API Migration Reference](https://supermemory.ai/docs/migration/from-mem0#api-migration-reference)
- [Adding Memories](https://supermemory.ai/docs/migration/from-mem0#adding-memories)
- [Searching Memories](https://supermemory.ai/docs/migration/from-mem0#searching-memories)
- [Getting All Memories](https://supermemory.ai/docs/migration/from-mem0#getting-all-memories)
- [Deleting Memories](https://supermemory.ai/docs/migration/from-mem0#deleting-memories)
- [Next Steps](https://supermemory.ai/docs/migration/from-mem0#next-steps)

Migrating from Mem0 to Supermemory is straightforward. This guide walks you through exporting your memories from Mem0 and importing them into Supermemory.

## [​](https://supermemory.ai/docs/migration/from-mem0\#why-migrate-to-supermemory)  Why Migrate to Supermemory?

Supermemory offers enhanced capabilities over Mem0:

- **Knowledge graph** architecture for better context relationships
- **Multiple content types** (URLs, PDFs, images, videos)
- **Generous free tier** (100k tokens) with affordable pricing
- **Multiple integration options** (API, MCP, SDKs)

## [​](https://supermemory.ai/docs/migration/from-mem0\#quick-migration-all-in-one)  Quick Migration (All-in-One)

Complete migration in one script:

```
from mem0 import MemoryClient
from supermemory import Supermemory
import json, time

# Export from Mem0
mem0 = MemoryClient(api_key="your_mem0_api_key")
export = mem0.create_memory_export(
    schema={"type": "object", "properties": {"memories": {"type": "array", "items": {"type": "object"}}}},
    filters={}
)
time.sleep(5)
data = mem0.get_memory_export(memory_export_id=export["id"])

# Import to Supermemory
supermemory = Supermemory(api_key="your_supermemory_api_key")
for memory in data["memories"]:
    if memory.get("content"):
        supermemory.memories.add(
            content=memory["content"],
            container_tags=["imported_from_mem0"]
        )
        print(f"✅ {memory['content'][:50]}...")

print("Migration complete!")
```

## [​](https://supermemory.ai/docs/migration/from-mem0\#step-by-step-migration)  Step-by-Step Migration

1

[Navigate to header](https://supermemory.ai/docs/migration/from-mem0#)

Export from Mem0

Mem0 provides two ways to export your memories:

### [​](https://supermemory.ai/docs/migration/from-mem0\#option-1-export-via-dashboard-recommended)  Option 1: Export via Dashboard (Recommended)

1. Log into your [Mem0 dashboard](https://app.mem0.ai/)
2. Navigate to the export section
3. Download your memories as JSON

### [​](https://supermemory.ai/docs/migration/from-mem0\#option-2-export-via-api)  Option 2: Export via API

Simple script to export all your memories from Mem0:

```
from mem0 import MemoryClient
import json
import time

# Connect to Mem0
client = MemoryClient(api_key="your_mem0_api_key")

# Create export job
schema = {
    "type": "object",
    "properties": {
        "memories": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "id": {"type": "string"},
                    "content": {"type": "string"},
                    "metadata": {"type": "object"},
                    "created_at": {"type": "string"}
                }
            }
        }
    }
}

response = client.create_memory_export(schema=schema, filters={})
export_id = response["id"]

# Wait and retrieve
print("Exporting memories...")
time.sleep(5)
export_data = client.get_memory_export(memory_export_id=export_id)

# Save to file
with open("mem0_export.json", "w") as f:
    json.dump(export_data, f, indent=2)

print(f"Exported {len(export_data['memories'])} memories")
```

2

[Navigate to header](https://supermemory.ai/docs/migration/from-mem0#)

Set Up Supermemory

Create your Supermemory account and get your API key:

1. Sign up at [console.supermemory.ai](https://console.supermemory.ai/)
2. Create a new project
3. Generate an API key from the dashboard

```
# Set your environment variable
export SUPERMEMORY_API_KEY="your_supermemory_api_key"
```

3

[Navigate to header](https://supermemory.ai/docs/migration/from-mem0#)

Import to Supermemory

Simple script to import your Mem0 memories into Supermemory:

```
import json
from supermemory import Supermemory

# Load your Mem0 export
with open("mem0_export.json", "r") as f:
    mem0_data = json.load(f)

# Connect to Supermemory
client = Supermemory(api_key="your_supermemory_api_key")

# Import memories
for memory in mem0_data["memories"]:
    content = memory.get("content", "")

    # Skip empty memories
    if not content:
        continue

    # Import to Supermemory
    try:
        result = client.add(
            content=content,
            container_tags=["imported_from_mem0"],
            metadata={
                "source": "mem0",
                "created_at": memory.get("created_at"),
                **(memory.get("metadata") or {})
            }
        )
        print(f"Imported: {content[:50]}...")
    except Exception as e:
        print(f"Failed: {e}")

print("Migration complete!")
```

## [​](https://supermemory.ai/docs/migration/from-mem0\#api-migration-reference)  API Migration Reference

Here’s how common Mem0 operations map to Supermemory:

### [​](https://supermemory.ai/docs/migration/from-mem0\#adding-memories)  Adding Memories

mem0

Supermemory

```
from mem0 import MemoryClient

client = MemoryClient(api_key="...")
client.add(
    messages="User prefers dark mode",
    user_id="alice"
)
```

### [​](https://supermemory.ai/docs/migration/from-mem0\#searching-memories)  Searching Memories

Mem0

Supermemory

```
results = client.search(
    query="user preferences",
    user_id="alice"
)
```

### [​](https://supermemory.ai/docs/migration/from-mem0\#getting-all-memories)  Getting All Memories

Mem0

Supermemory

```
memories = client.get_all(
    user_id="alice"
)
```

### [​](https://supermemory.ai/docs/migration/from-mem0\#deleting-memories)  Deleting Memories

Mem0

Supermemory

```
client.delete(memory_id="mem_123")
```

For enterprise migrations, [contact us](mailto:support@supermemory.ai) for assistance.

## [​](https://supermemory.ai/docs/migration/from-mem0\#next-steps)  Next Steps

1. [Explore](https://supermemory.ai/docs/how-it-works) how Supermemory works
2. Read the [quickstart](https://supermemory.ai/docs/quickstart) and add and retrieve your first memories
3. [Connect](https://supermemory.ai/docs/connectors/overview) to Google Drive, Notion, and OneDrive with automatic syncing

Was this page helpful?

YesNo

[Managing Resources](https://supermemory.ai/docs/memory-api/connectors/managing-resources) [From Zep](https://supermemory.ai/docs/migration/from-zep)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)