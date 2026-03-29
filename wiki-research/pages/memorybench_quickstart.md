---
url: https://supermemory.ai/docs/memorybench/quickstart
title: Quick Start - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/memorybench/quickstart#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Getting Started

Quick Start

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [1\. Run Your First Benchmark](https://supermemory.ai/docs/memorybench/quickstart#1-run-your-first-benchmark)
- [2\. View Results](https://supermemory.ai/docs/memorybench/quickstart#2-view-results)
- [Option A: Web UI](https://supermemory.ai/docs/memorybench/quickstart#option-a-web-ui)
- [Option B: CLI](https://supermemory.ai/docs/memorybench/quickstart#option-b-cli)
- [3\. Compare Providers](https://supermemory.ai/docs/memorybench/quickstart#3-compare-providers)
- [Sample Output](https://supermemory.ai/docs/memorybench/quickstart#sample-output)
- [What’s Next](https://supermemory.ai/docs/memorybench/quickstart#what%E2%80%99s-next)

## [​](https://supermemory.ai/docs/memorybench/quickstart\#1-run-your-first-benchmark)  1\. Run Your First Benchmark

```
bun run src/index.ts run -p supermemory -b longmemeval -j gpt-4o -r my-first-run
```

## [​](https://supermemory.ai/docs/memorybench/quickstart\#2-view-results)  2\. View Results

### [​](https://supermemory.ai/docs/memorybench/quickstart\#option-a-web-ui)  Option A: Web UI

```
bun run src/index.ts serve
```

Open [http://localhost:3000](http://localhost:3000/) to see results visually.

### [​](https://supermemory.ai/docs/memorybench/quickstart\#option-b-cli)  Option B: CLI

```
# Check run status
bun run src/index.ts status -r my-first-run

# View failed questions for debugging
bun run src/index.ts show-failures -r my-first-run
```

## [​](https://supermemory.ai/docs/memorybench/quickstart\#3-compare-providers)  3\. Compare Providers

Run the same benchmark across multiple providers:

```
bun run src/index.ts compare -p supermemory,mem0,zep -b locomo -j gpt-4o
```

## [​](https://supermemory.ai/docs/memorybench/quickstart\#sample-output)  Sample Output

Each run produces a [MemScore](https://supermemory.ai/docs/memorybench/memscore) — a composite metric capturing quality, latency, and token efficiency:

```
SUMMARY:
  Total Questions: 50
  Correct: 36
  Accuracy: 72.00%

  Quality:  72%
  Latency:  1250ms (avg)
  Tokens:   1,823 (avg context sent to answering model)

  MemScore: 72% / 1250ms / 1823tok
```

Full results are saved to `data/runs/{runId}/report.json` with detailed breakdowns by question type, latency percentiles, and per-question token counts.

## [​](https://supermemory.ai/docs/memorybench/quickstart\#what%E2%80%99s-next)  What’s Next

- [MemScore](https://supermemory.ai/docs/memorybench/memscore) — understand the composite metric and how to compare providers
- [CLI Reference](https://supermemory.ai/docs/memorybench/cli) — all available commands
- [Architecture](https://supermemory.ai/docs/memorybench/architecture) — how MemoryBench works under the hood

Was this page helpful?

YesNo

[Installation](https://supermemory.ai/docs/memorybench/installation) [Architecture](https://supermemory.ai/docs/memorybench/architecture)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)