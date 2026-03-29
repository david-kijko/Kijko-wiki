---
url: https://supermemory.ai/docs/quickstart
title: Quickstart - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/quickstart#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Getting Started

Quickstart

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Memory API](https://supermemory.ai/docs/quickstart#memory-api)

**Using Vercel AI SDK?** Check out the [AI SDK integration](https://supermemory.ai/docs/integrations/ai-sdk) for the cleanest implementation with `@supermemory/tools/ai-sdk`.

## [​](https://supermemory.ai/docs/quickstart\#memory-api)  Memory API

**Step 1.** Sign up for [Supermemory’s Developer Platform](http://console.supermemory.ai/) to get the API key. Click on **API Keys -> Create API Key** to generate one.![create api key](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/create-api.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=a3216bf250253e6b33eb44a635a62b9d)**Step 2.** Install the SDK and set your API key:

- Python

- TypeScript


```
pip install supermemory
export SUPERMEMORY_API_KEY="YOUR_API_KEY"
```

```
npm install supermemory
export SUPERMEMORY_API_KEY="YOUR_API_KEY"
```

**Step 3.** Here’s everything you need to add memory to your LLM:

- Python

- TypeScript


```
from supermemory import Supermemory

client = Supermemory()
USER_ID = "dhravya"

conversation = [\
    {"role": "assistant", "content": "Hello, how are you doing?"},\
    {"role": "user", "content": "Hello! I am Dhravya. I am 20 years old. I love to code!"},\
    {"role": "user", "content": "Can I go to the club?"},\
]

# Get user profile + relevant memories for context
profile = client.profile(container_tag=USER_ID, q=conversation[-1]["content"])

static = "\n".join(profile.profile.static)
dynamic = "\n".join(profile.profile.dynamic)
memories = "\n".join(r.get("memory", "") for r in profile.search_results.results)

context = f"""Static profile:
{static}

Dynamic profile:
{dynamic}

Relevant memories:
{memories}"""

# Build messages with memory-enriched context
messages = [{"role": "system", "content": f"User context:\n{context}"}, *conversation]

# response = llm.chat(messages=messages)

# Store conversation for future context
client.add(
    content="\n".join(f"{m['role']}: {m['content']}" for m in conversation),
    container_tag=USER_ID,
)
```

```
import Supermemory from "supermemory";

const client = new Supermemory();
const USER_ID = "dhravya";

const conversation = [\
  { role: "assistant", content: "Hello, how are you doing?" },\
  { role: "user", content: "Hello! I am Dhravya. I am 20 years old. I love to code!" },\
  { role: "user", content: "Can I go to the club?" },\
];

// Get user profile + relevant memories for context
const profile = await client.profile({
  containerTag: USER_ID,
  q: conversation.at(-1)!.content,
});

const context = `Static profile:
${profile.profile.static.join("\n")}

Dynamic profile:
${profile.profile.dynamic.join("\n")}

Relevant memories:
${profile.searchResults.results.map((r) => r.memory).join("\n")}`;

// Build messages with memory-enriched context
const messages = [{ role: "system", content: `User context:\n${context}` }, ...conversation];

// const response = await llm.chat({ messages });

// Store conversation for future context
await client.add({
  content: conversation.map((m) => `${m.role}: ${m.content}`).join("\n"),
  containerTag: USER_ID,
});
```

That’s it! Supermemory automatically:

- Extracts memories from conversations
- Builds and maintains user profiles (static facts + dynamic context)
- Returns relevant context for personalized LLM responses

**Optional:** Use the `threshold` parameter to filter search results by relevance score. For example: `client.profile(container_tag=USER_ID, threshold=0.7, q=query)` will only include results with a score above 0.7.

Learn more about [User Profiles](https://supermemory.ai/docs/user-profiles) and [Search](https://supermemory.ai/docs/search).

Was this page helpful?

YesNo

[Overview](https://supermemory.ai/docs/intro) [Install with AI](https://supermemory.ai/docs/vibe-coding)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)

![create api key](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/create-api.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=d3d106b6b8c608f10ea62d42dce11c9b)