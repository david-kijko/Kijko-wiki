---
url: https://supermemory.ai/docs/integrations/mastra
title: Mastra - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/integrations/mastra#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Mastra

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Installation](https://supermemory.ai/docs/integrations/mastra#installation)
- [Quick Start](https://supermemory.ai/docs/integrations/mastra#quick-start)
- [How It Works](https://supermemory.ai/docs/integrations/mastra#how-it-works)
- [Configuration Options](https://supermemory.ai/docs/integrations/mastra#configuration-options)
- [Memory Search Modes](https://supermemory.ai/docs/integrations/mastra#memory-search-modes)
- [Custom Prompt Templates](https://supermemory.ai/docs/integrations/mastra#custom-prompt-templates)
- [Direct Processor Usage](https://supermemory.ai/docs/integrations/mastra#direct-processor-usage)
- [Input Processor Only](https://supermemory.ai/docs/integrations/mastra#input-processor-only)
- [Output Processor Only](https://supermemory.ai/docs/integrations/mastra#output-processor-only)
- [Both Processors](https://supermemory.ai/docs/integrations/mastra#both-processors)
- [Using RequestContext](https://supermemory.ai/docs/integrations/mastra#using-requestcontext)
- [Verbose Logging](https://supermemory.ai/docs/integrations/mastra#verbose-logging)
- [Working with Existing Processors](https://supermemory.ai/docs/integrations/mastra#working-with-existing-processors)
- [API Reference](https://supermemory.ai/docs/integrations/mastra#api-reference)
- [withSupermemory](https://supermemory.ai/docs/integrations/mastra#withsupermemory)
- [createSupermemoryProcessor](https://supermemory.ai/docs/integrations/mastra#createsupermemoryprocessor)
- [createSupermemoryOutputProcessor](https://supermemory.ai/docs/integrations/mastra#createsupermemoryoutputprocessor)
- [createSupermemoryProcessors](https://supermemory.ai/docs/integrations/mastra#createsupermemoryprocessors)
- [SupermemoryMastraOptions](https://supermemory.ai/docs/integrations/mastra#supermemorymastraoptions)
- [Environment Variables](https://supermemory.ai/docs/integrations/mastra#environment-variables)
- [Error Handling](https://supermemory.ai/docs/integrations/mastra#error-handling)
- [Next Steps](https://supermemory.ai/docs/integrations/mastra#next-steps)

Integrate Supermemory with [Mastra](https://mastra.ai/) to give your AI agents persistent memory. Use the `withSupermemory` wrapper for zero-config setup or processors for fine-grained control.

[**@supermemory/tools on npm** \\
\\
Check out the NPM page for more details](https://www.npmjs.com/package/@supermemory/tools)

## [​](https://supermemory.ai/docs/integrations/mastra\#installation)  Installation

```
npm install @supermemory/tools @mastra/core
```

## [​](https://supermemory.ai/docs/integrations/mastra\#quick-start)  Quick Start

Wrap your agent config with `withSupermemory` to add memory capabilities:

```
import { Agent } from "@mastra/core/agent"
import { withSupermemory } from "@supermemory/tools/mastra"
import { openai } from "@ai-sdk/openai"

// Create agent with memory-enhanced config
const agent = new Agent(withSupermemory(
  {
    id: "my-assistant",
    name: "My Assistant",
    model: openai("gpt-4o"),
    instructions: "You are a helpful assistant.",
  },
  "user-123",  // containerTag - scopes memories to this user
  {
    mode: "full",
    addMemory: "always",
    threadId: "conv-456",
  }
))

const response = await agent.generate("What do you know about me?")
```

**Memory saving is disabled by default.** The wrapper only retrieves existing memories. To automatically save conversations:

```
const agent = new Agent(withSupermemory(
  { id: "my-assistant", model: openai("gpt-4o"), ... },
  "user-123",
  {
    addMemory: "always",
    threadId: "conv-456"  // Required for conversation grouping
  }
))
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#how-it-works)  How It Works

The Mastra integration uses Mastra’s native [Processor](https://mastra.ai/docs/agents/processors) interface:

1. **Input Processor** \- Fetches relevant memories from Supermemory and injects them into the system prompt before the LLM call
2. **Output Processor** \- Optionally saves the conversation to Supermemory after generation completes

SupermemoryOutputProcessorLLMInputProcessorAgentUserSupermemoryOutputProcessorLLMInputProcessorAgentUserSend messageProcess inputFetch memoriesReturn memoriesInject into system promptGenerate responseReturn responseProcess outputSave conversation (if enabled)Return response

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#configuration-options)  Configuration Options

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `apiKey` | `string` | `SUPERMEMORY_API_KEY` env | Your Supermemory API key |
| `baseUrl` | `string` | `https://api.supermemory.ai` | Custom API endpoint |
| `mode` | `"profile" | "query" | "full"` | `"profile"` | Memory search mode |
| `addMemory` | `"always" | "never"` | `"never"` | Auto-save conversations |
| `threadId` | `string` | - | Conversation ID for grouping messages |
| `verbose` | `boolean` | `false` | Enable debug logging |
| `promptTemplate` | `function` | - | Custom memory formatting |

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#memory-search-modes)  Memory Search Modes

**Profile Mode (Default)** \- Retrieves the user’s complete profile without query-based filtering:

```
const agent = new Agent(withSupermemory(config, "user-123", { mode: "profile" }))
```

**Query Mode** \- Searches memories based on the user’s message:

```
const agent = new Agent(withSupermemory(config, "user-123", { mode: "query" }))
```

**Full Mode** \- Combines profile AND query-based search for maximum context:

````
const agent = new Agent(withSupermemory(config, "user-123", { mode: "full" }))

### Mode Comparison

| Mode | Description | Use Case |
|------|-------------|----------|
| `profile` | Static + dynamic user facts | General personalization |
| `query` | Semantic search on user message | Specific Q&A |
| `full` | Both profile and search | Chatbots, assistants |

---

## Saving Conversations

Enable automatic conversation saving with `addMemory: "always"`. A `threadId` is required to group messages:

```typescript
const agent = new Agent(withSupermemory(
{ id: "my-assistant", model: openai("gpt-4o"), instructions: "..." },
"user-123",
{
    addMemory: "always",
    threadId: "conv-456",
}
))

// All messages in this conversation are saved
await agent.generate("I prefer TypeScript over JavaScript")
await agent.generate("My favorite framework is Next.js")
````

Without a `threadId`, the output processor will log a warning and skip saving. Always provide a `threadId` when using `addMemory: "always"`.

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#custom-prompt-templates)  Custom Prompt Templates

Customize how memories are formatted and injected. The template receives `userMemories`, `generalSearchMemories`, and `searchResults` (raw array for filtering by metadata):

```
import { Agent } from "@mastra/core/agent"
import { withSupermemory } from "@supermemory/tools/mastra"
import type { MemoryPromptData } from "@supermemory/tools/mastra"

const claudePrompt = (data: MemoryPromptData) => `
<context>
<user_profile>
    ${data.userMemories}
</user_profile>
<relevant_memories>
    ${data.generalSearchMemories}
</relevant_memories>
</context>
`.trim()

const agent = new Agent(withSupermemory(
{ id: "my-assistant", model: openai("gpt-4o"), instructions: "..." },
"user-123",
{
    mode: "full",
    promptTemplate: claudePrompt,
}
))
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#direct-processor-usage)  Direct Processor Usage

For advanced use cases, use processors directly instead of the wrapper:

### [​](https://supermemory.ai/docs/integrations/mastra\#input-processor-only)  Input Processor Only

Inject memories without saving conversations:

```
import { Agent } from "@mastra/core/agent"
import { createSupermemoryProcessor } from "@supermemory/tools/mastra"
import { openai } from "@ai-sdk/openai"

const agent = new Agent({
id: "my-assistant",
name: "My Assistant",
model: openai("gpt-4o"),
inputProcessors: [\
    createSupermemoryProcessor("user-123", {\
      mode: "full",\
      verbose: true,\
    }),\
],
})
```

### [​](https://supermemory.ai/docs/integrations/mastra\#output-processor-only)  Output Processor Only

Save conversations without memory injection:

```
import { Agent } from "@mastra/core/agent"
import { createSupermemoryOutputProcessor } from "@supermemory/tools/mastra"
import { openai } from "@ai-sdk/openai"

const agent = new Agent({
id: "my-assistant",
name: "My Assistant",
model: openai("gpt-4o"),
outputProcessors: [\
    createSupermemoryOutputProcessor("user-123", {\
      addMemory: "always",\
      threadId: "conv-456",\
    }),\
],
})
```

### [​](https://supermemory.ai/docs/integrations/mastra\#both-processors)  Both Processors

Use the factory function for shared configuration:

```
import { Agent } from "@mastra/core/agent"
import { createSupermemoryProcessors } from "@supermemory/tools/mastra"
import { openai } from "@ai-sdk/openai"

const { input, output } = createSupermemoryProcessors("user-123", {
mode: "full",
addMemory: "always",
threadId: "conv-456",
verbose: true,
})

const agent = new Agent({
id: "my-assistant",
name: "My Assistant",
model: openai("gpt-4o"),
inputProcessors: [input],
outputProcessors: [output],
})
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#using-requestcontext)  Using RequestContext

Mastra’s `RequestContext` can provide `threadId` dynamically:

```
import { Agent } from "@mastra/core/agent"
import { RequestContext, MASTRA_THREAD_ID_KEY } from "@mastra/core/request-context"
import { withSupermemory } from "@supermemory/tools/mastra"
import { openai } from "@ai-sdk/openai"

const agent = new Agent(withSupermemory(
{ id: "my-assistant", model: openai("gpt-4o"), instructions: "..." },
"user-123",
{
    mode: "full",
    addMemory: "always",
    // threadId not set - will use RequestContext
}
))

// Set threadId dynamically via RequestContext
const ctx = new RequestContext()
ctx.set(MASTRA_THREAD_ID_KEY, "dynamic-thread-id")

await agent.generate("Hello!", { requestContext: ctx })
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#verbose-logging)  Verbose Logging

Enable detailed logging for debugging:

```
const agent = new Agent(withSupermemory(
{ id: "my-assistant", model: openai("gpt-4o"), instructions: "..." },
"user-123",
{ verbose: true }
))

// Console output:
// [supermemory] Starting memory search { containerTag: "user-123", mode: "profile" }
// [supermemory] Found 5 memories
// [supermemory] Injected memories into system prompt { length: 1523 }
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#working-with-existing-processors)  Working with Existing Processors

The wrapper correctly merges with existing processors in the config:

```
// Supermemory processors are merged correctly:
// - Input: [supermemory, myLogging] (supermemory runs first)
// - Output: [myAnalytics, supermemory] (supermemory runs last)
const agent = new Agent(withSupermemory(
{
    id: "my-assistant",
    model: openai("gpt-4o"),
    inputProcessors: [myLoggingProcessor],
    outputProcessors: [myAnalyticsProcessor],
},
"user-123"
))
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#api-reference)  API Reference

### [​](https://supermemory.ai/docs/integrations/mastra\#withsupermemory)  `withSupermemory`

Enhances a Mastra agent config with memory capabilities.

```
function withSupermemory<T extends AgentConfig>(
config: T,
containerTag: string,
options?: SupermemoryMastraOptions
): T
```

**Parameters:**

- `config` \- The Mastra agent configuration object
- `containerTag` \- User/container ID for scoping memories
- `options` \- Configuration options

**Returns:** Enhanced config with Supermemory processors injected

### [​](https://supermemory.ai/docs/integrations/mastra\#createsupermemoryprocessor)  `createSupermemoryProcessor`

Creates an input processor for memory injection.

```
function createSupermemoryProcessor(
containerTag: string,
options?: SupermemoryMastraOptions
): SupermemoryInputProcessor
```

### [​](https://supermemory.ai/docs/integrations/mastra\#createsupermemoryoutputprocessor)  `createSupermemoryOutputProcessor`

Creates an output processor for conversation saving.

```
function createSupermemoryOutputProcessor(
containerTag: string,
options?: SupermemoryMastraOptions
): SupermemoryOutputProcessor
```

### [​](https://supermemory.ai/docs/integrations/mastra\#createsupermemoryprocessors)  `createSupermemoryProcessors`

Creates both processors with shared configuration.

```
function createSupermemoryProcessors(
containerTag: string,
options?: SupermemoryMastraOptions
): {
input: SupermemoryInputProcessor
output: SupermemoryOutputProcessor
}
```

### [​](https://supermemory.ai/docs/integrations/mastra\#supermemorymastraoptions)  `SupermemoryMastraOptions`

```
interface SupermemoryMastraOptions {
apiKey?: string
baseUrl?: string
mode?: "profile" | "query" | "full"
addMemory?: "always" | "never"
threadId?: string
verbose?: boolean
promptTemplate?: (data: MemoryPromptData) => string
}
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#environment-variables)  Environment Variables

```
SUPERMEMORY_API_KEY=your_supermemory_key
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#error-handling)  Error Handling

Processors gracefully handle errors without breaking the agent:

- **API errors** \- Logged and skipped; agent continues without memories
- **Missing API key** \- Throws immediately with helpful error message
- **Missing threadId** \- Warns in console; skips saving

```
// Missing API key throws immediately
const agent = new Agent(withSupermemory(
{ id: "my-assistant", model: openai("gpt-4o"), instructions: "..." },
"user-123",
{ apiKey: undefined } // Will check SUPERMEMORY_API_KEY env
))
// Error: SUPERMEMORY_API_KEY is not set
```

* * *

## [​](https://supermemory.ai/docs/integrations/mastra\#next-steps)  Next Steps

[**Vercel AI SDK** \\
\\
Use with Vercel AI SDK for streamlined development](https://supermemory.ai/docs/integrations/ai-sdk)

[**User Profiles** \\
\\
Learn about user profile management](https://supermemory.ai/docs/user-profiles)

Was this page helpful?

YesNo

[MS Agent Framework](https://supermemory.ai/docs/integrations/agent-framework) [LangChain](https://supermemory.ai/docs/integrations/langchain)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)