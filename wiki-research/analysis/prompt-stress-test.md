# Wiki Generation Prompt Stress Test Report

> Team 2: Generation Prompt Stress Tester
> Date: 2026-03-28
> Scope: `wiki-generation-prompt.md` applied against the Kijko_Docs codebase itself

---

## 1. Compatibility Assessment (Agent Code vs Prompt)

### 1.1 System Instruction Mismatch

The generation prompt defines the agent identity as **"Chronicler"** with access to CodeGraph, CGC, NotebookLM MCP, and Repomix. The actual `wiki-agent.ts` (line 15-16) has a minimal system instruction:

```
"You are Chronicler, the Kijko WikiAgent. Help maintain a technical wiki. Produce concise,
high-signal markdown. Prefer sections named Overview, Architecture, Key Components, and Sources
when generating documentation."
```

**Gaps:**

| Prompt Expects | Agent Code Provides | Status |
|---|---|---|
| 9 page type templates with section ordering | "Prefer sections named Overview, Architecture, Key Components, and Sources" | CONFLICT -- agent hardcodes 4 section names that do not map to the prompt's 9 type templates |
| Fumadocs MDX output with imports | Plain markdown (wiki-files.ts renders `.md`, not `.mdx`) | CONFLICT -- `pagePath()` at line 29 of wiki-files.ts appends `.md`, not `.mdx` |
| Frontmatter with `icon`, `description` (SEO 120-160 chars), `audience` | Frontmatter includes `title`, `description` (derived from component name), `tags`, `audience`, `repo_url`, `source_notebook`, `auto_generated` | PARTIAL -- no `icon` field in `renderFrontmatter()` (wiki-files.ts:33-43); description is not SEO-length-validated |
| `audience` values: `"internal"`, `"external"`, `"both"` | Matches -- `audienceSchema` in models.ts uses the same three values | OK |
| Component imports (Card, Cards, Callout, etc.) | Agent generates markdown, not MDX with component imports | MISSING |
| `meta.json` navigation | Agent generates MkDocs YAML nav (`syncMkdocsNav`), not Fumadocs `meta.json` | CONFLICT -- prompt says `meta.json` but code generates `mkdocs.internal.yml` / `mkdocs.external.yml` |

### 1.2 Page Generation Flow Mismatch

The prompt defines a 6-phase pipeline (Discovery through Publish). The actual page generation in `chat-engine.ts` (lines 204-262) is a single-pass flow:

1. User sends a message
2. Intent classifier maps it to `page_create` or `page_update`
3. Agent calls `generatePage()` which:
   - Fetches existing page from DB
   - Searches NotebookLM for context
   - Builds a simple text prompt
   - Calls `agent.generate()` once
   - Wraps output in a `WikiPage` object
   - Writes `.md` file and syncs MkDocs nav

There is **no** Discovery phase, **no** IA generation, **no** infographic generation, **no** QA phase, and **no** cross-link validation. The prompt describes an orchestration pipeline; the code implements a single LLM call.

### 1.3 Content Format Mismatch

The prompt targets Fumadocs MDX. The existing wiki-content pages (e.g., `index.md`, `getting-started.md`) are plain Markdown with YAML frontmatter and Mermaid fenced code blocks. They use no Fumadocs components. The `docs-pipeline.ts` corpus loader reads `.md` files (line 881).

**Verdict: The prompt describes a system that does not yet exist. The current agent is a single-page-at-a-time Markdown writer with MkDocs nav sync. Adopting the prompt requires rebuilding the agent's orchestration layer, output format, and tool surface.**

---

## 2. Simulated Information Architecture for Kijko_Docs

Applying the prompt's IA template and page count targets to the Kijko_Docs repo itself. The repo is a pnpm monorepo with ~3 apps (agent, web), 1 shared package, conductor artifacts, and wiki content. Estimated complexity: **Medium** (5K-50K LOC range, targeting 30-60 pages).

### Proposed IA Tree

```
docs/
├── index.mdx                                    # Type 1: Landing Overview
├── quickstart.mdx                               # Type 2: Quickstart (local dev setup)
├── concepts/
│   ├── architecture.mdx                         # Type 3: Monorepo architecture (agent + web + shared)
│   ├── wiki-page-model.mdx                      # Type 3: WikiPage data model, slug conventions
│   ├── intent-classification.mdx                # Type 3: How the agent classifies user messages
│   ├── docs-pipeline.mdx                        # Type 3: The docs automation pipeline
│   ├── superconductor.mdx                       # Type 3: Conductor/superconductor workflow
│   ├── audience-model.mdx                       # Type 3: Internal vs external audience gating
│   ├── living-docs.mdx                          # Type 3: File-watch, diff-driven doc refresh
│   └── style-system.mdx                         # Type 3: Template library, design tokens, IA variants
├── guides/
│   ├── writing-wiki-pages.mdx                   # Type 4: How to create/edit wiki pages via chat
│   ├── running-the-agent.mdx                    # Type 4: Starting apps/agent, env config
│   ├── running-the-web-app.mdx                  # Type 4: Starting apps/web, route structure
│   ├── docs-automation.mdx                      # Type 4: Running the full docs pipeline (rebuild)
│   ├── mkdocs-nav-sync.mdx                      # Type 4: How internal/external MkDocs configs work
│   └── conductor-workflow.mdx                   # Type 4: Using the superconductor tracks
├── integrations/
│   ├── overview.mdx                             # Type 1: Integration map
│   ├── openai-proxy.mdx                         # Type 4: GPTAuthwrapper / LiteLLM proxy integration
│   ├── notebooklm.mdx                           # Type 4: OpenNotebook / NotebookLM MCP integration
│   ├── copilotkit.mdx                           # Type 4: CopilotKit in apps/web
│   ├── mastra.mdx                               # Type 4: Mastra agent framework
│   ├── codegraph.mdx                            # Type 4: CodeGraph / CGC integration
│   └── fumadocs.mdx                             # Type 4: Target Fumadocs framework (aspirational)
├── connectors/
│   ├── github-webhook.mdx                       # Type 5: GitHub webhook connector for repo monitoring
│   └── file-watcher.mdx                         # Type 5: Local file watch connector
├── api-reference/                               # Type 6: Auto-generated
│   └── [[...slug]].tsx                          # From config/docs-api.openapi.yaml
├── cookbook/
│   ├── overview.mdx                             # Type 1: Recipe index
│   ├── generate-wiki-for-repo.mdx               # Type 7: End-to-end wiki generation walkthrough
│   ├── add-page-type.mdx                        # Type 7: Adding a new page type template
│   └── custom-infographic.mdx                   # Type 7: Generating a NotebookLM infographic
├── reference/
│   ├── cli-commands.mdx                         # Type 8: pnpm filter commands reference
│   ├── configuration.mdx                        # Type 8: wikiagent.yaml spec
│   ├── environment-variables.mdx                # Type 8: .env reference
│   ├── wiki-page-schema.mdx                     # Type 8: WikiPage zod schema fields
│   ├── intent-actions.mdx                       # Type 8: Action types and their triggers
│   └── docs-quality-report.mdx                  # Type 8: Quality report fields and scoring
├── deployment/
│   ├── docker-compose.mdx                       # Type 4: Docker compose deployment
│   └── hetzner.mdx                              # Type 4: Hetzner-specific deployment
├── migration/
│   └── from-mkdocs-to-fumadocs.mdx              # Type 9: MkDocs to Fumadocs migration
└── changelog/
    └── overview.mdx                             # Changelog
```

**Page count: 39 pages** (within the 30-60 target for Medium complexity).

### Issues Found During IA Simulation

1. **The prompt's IA template assumes a product with external users and integrations.** Kijko_Docs is an internal tool; the "Connector Guide" (Type 5) feels forced for GitHub webhooks/file watchers that are really just config options.
2. **The "API Reference" section assumes a public API.** Kijko_Docs has an internal Hono-based API (chat, pages), not a public product API. The auto-generation via `fumadocs-openapi` does not match -- the OpenAPI spec at `config/docs-api.openapi.yaml` is more of an internal docs surface spec.
3. **Missing page type for "Protocol/Workflow" pages.** The existing style-system.json defines a "protocol" template (id: `protocol`) used for pages like `baton-exchange`. The prompt's 9 types have no equivalent.
4. **No page type for diagram-focused pages.** The style-system.json defines `architecture-diagram` and `sequence-diagram` templates. The prompt subsumes these into Concept Explainer (Type 3) but loses the specialized section structure.

---

## 3. Tool Gap Matrix

| Pipeline Phase | Sub-step | Existing Tool/Code | Gap |
|---|---|---|---|
| **Phase 1: Discovery** | CodeGraph analysis | `inspectCodegraphState()` in docs-pipeline.ts (checks if DB exists) | Tool only checks presence, cannot run queries, extract callers/callees, or get symbol graphs |
| | CGC analysis | None | No tool. The prompt references complexity scores, dead code, dependency graphs -- none are extractable |
| | Repomix | None | No tool. No Repomix integration exists in the codebase |
| | NotebookLM research | `OpenNotebookClient.search()` in notebook-client.ts | Partial -- search only, no infographic generation, no "zero-hallucination knowledge synthesis" |
| **Phase 2: IA** | Classify repo complexity | None | No tool. Would need LOC counting, dependency analysis |
| | Generate section taxonomy | None | No tool. The IA is defined statically in style-system.json, not generated dynamically |
| | Map concepts to page types | None | No tool. No concept extraction or classification |
| | Define page dependency graph | None | No tool |
| | Set page count targets | None | No tool. The table is in the prompt but nothing reads it |
| **Phase 3: Content** | Generate pages by type | `createPage` tool in wiki-tools.ts | Partial -- creates a page with slug/title/content but has no awareness of page types, section templates, or generation ordering |
| | Page ordering (Landing first, then Concepts, etc.) | None | No orchestration. `generatePage()` in chat-engine.ts generates one page per user message |
| | Fumadocs MDX generation | None | Output is `.md` not `.mdx`. No component imports generated |
| **Phase 4: Infographics** | Architecture Overview infographic | None | No NotebookLM infographic generation tool |
| | Dependency Graph visualization | None | No tool |
| | Per-concept diagrams | `architectureDiagramSchema` in models.ts (d2/mermaid) | Schema exists but no tool generates or embeds them into pages |
| | Embed into pages | None | No embedding tool |
| **Phase 5: QA** | Verify cross-links | `DocsQualityReport.internalBrokenLinks` in docs-pipeline.ts | Available via `runDocsQualityChecks()` but not exposed as an agent tool |
| | Check Next Steps on every page | None | No validation tool |
| | Validate MDX syntax | None | No MDX validator. Current pages are not MDX. |
| | Run content against style rules | `DocsQualityReport.styleGuideIssues` in docs-pipeline.ts | Available in pipeline but not exposed as agent tool |
| | Generate meta.json | None | `syncMkdocsNav()` generates MkDocs YAML, not Fumadocs `meta.json` |
| **Phase 6: Publish** | Write .mdx files | `writePage()` in wiki-files.ts | Writes `.md` files, not `.mdx` |
| | Generate meta.json | None (see above) | |
| | Update root docs index | None | No tool |
| | Trigger Fumadocs build | None | No build trigger. System uses MkDocs, not Fumadocs |

### Summary

- **Phases with some tool support:** Phase 3 (partial -- single page creation), Phase 5 (partial -- quality checks exist in pipeline but not as agent tools)
- **Phases with no tool support:** Phase 1, Phase 2, Phase 4, Phase 6
- **Critical tool gap:** The docs-pipeline.ts contains substantial QA and discovery logic but none of it is exposed through wiki-tools.ts as agent-callable tools.

---

## 4. Ambiguity / Contradiction List

### Contradictions

**C1. MkDocs vs Fumadocs (multiple locations)**
- Prompt line 26: "All generated pages MUST be valid Fumadocs MDX"
- Prompt line 576-579: "Write all .mdx files... Generate meta.json navigation tree... Trigger Fumadocs build"
- Code reality: wiki-files.ts generates `.md` files, syncs `mkdocs.internal.yml` / `mkdocs.external.yml`, and uses Material theme
- The style-system.json (line 198-208) includes both MkDocs and Fumadocs component mappings, acknowledging the migration gap
- **Impact:** An agent following the prompt would generate `.mdx` files that the current system cannot serve

**C2. Section naming conflict between agent instructions and prompt**
- Agent system instruction (wiki-agent.ts:16): "Prefer sections named Overview, Architecture, Key Components, and Sources"
- Prompt Type 1 sections: HERO, AT A GLANCE, PRODUCT VISUALIZATION, HOW IT WORKS, USE CASES, NEXT STEPS
- Prompt Type 3 sections: HERO + FRAMING, MENTAL MODEL, ARCHITECTURE VISUALIZATION, HOW IT WORKS (DEEP), COMPARISON, EXAMPLES, THE BOTTOM LINE, NEXT STEPS
- **Impact:** The agent's hardcoded section names will fight the prompt's per-type templates

**C3. Callout type mismatch**
- Prompt line 287: `<Callout type="warn">` (Type 5, Connector Guide)
- Prompt line 112: `<Callout type="info">` (Type 2, Quickstart)
- page-type-templates.json line 85: callout variants are `["info", "warning", "tip", "note", "danger"]`
- **Impact:** The prompt uses `type="warn"` but the template system defines `type="warning"`. Fumadocs uses `type="warn"` per its docs, so the template JSON is wrong, not the prompt. However this inconsistency will confuse implementors.

**C4. Audience frontmatter format**
- Prompt line 527-529: `audience: "internal"` / `audience: "external"` / `audience: "both"` (plain string)
- Existing pages (e.g., index.md): `audience: both` (unquoted YAML)
- models.ts: `audienceSchema = z.enum(["internal", "external", "both"])` (matches both)
- **Impact:** Minor -- YAML parses both forms identically. Not a functional conflict.

### Ambiguities

**A1. "Every section has a PURPOSE -- don't include sections that have no content to fill" (line 52)**
- But several sections are marked `required: true` in page-type-templates.json. Does the "skip empty sections" rule override required status? Or does required mean the agent must find content to fill it?
- **Impact:** Agent could skip required sections or generate filler content. No clear resolution.

**A2. "NotebookLM-generated infographic" is used as both a tool call and a content reference**
- Prompt line 77: "generated via NotebookLM infographic" (architectural diagram)
- Prompt line 171-172: "NotebookLM-generated infographic showing the architecture / OR Mermaid diagram rendered via Fumadocs"
- Prompt lines 496-515: Detailed NotebookLM infographic prompt pattern
- **Impact:** Is NotebookLM infographic generation a real-time tool call during wiki generation, or a reference to pre-existing artifacts? The notebook-client.ts only has a `search()` method, no infographic generation.

**A3. "Breadcrumb-compatible paths" (line 522)**
- The prompt says paths should be like `/docs/concepts/architecture`. But the existing page slugs are flat (e.g., `panopticon`, `getting-started`). The `wikiPageSchema` uses a single `slug` field with no hierarchy delimiter convention.
- **Impact:** Agent would need to generate hierarchical slugs (`concepts/architecture`) but the DB and file system currently use flat slugs.

**A4. Page count targets "by repo complexity" (lines 473-477)**
- The prompt provides LOC thresholds (< 5K, 5K-50K, 50K+) but does not define how to measure LOC. Does it count all files? Only source code? Do tests count? Do node_modules count?
- **Impact:** The complexity classification is ambiguous for a monorepo.

**A5. "Generate Changelog (if applicable)" (line 561)**
- What makes a changelog "applicable"? There is no guidance on when to generate it, what source data to use, or what format it should follow.
- **Impact:** The agent has no criteria for this decision.

### Incomplete References

**I1. "Design tokens: As defined in `page-type-templates.json`" (line 619)**
- The prompt references design tokens for content generation but never explains how an LLM should apply CSS-level tokens (`content_max_width: 780px`, `card_grid_gap: 1rem`) to MDX output. These tokens are for a rendering framework, not for a content generator.
- **Impact:** The agent cannot meaningfully use design tokens in text generation.

**I2. "Kijko brand palette (primary, secondary, accent)" (line 620)**
- The `primary` color is defined in page-type-templates.json as `#7c3aed` (accent). No `secondary` color is defined anywhere.
- **Impact:** Reference to undefined `secondary` color.

**I3. "Lucide icons (Fumadocs default)" (line 622)**
- The prompt's page types reference `icon` in frontmatter and Card components but never provide a mapping of which Lucide icons to use for which concepts. The existing frontmatter in wiki pages has no `icon` field.
- **Impact:** Agent must guess icon names or the prompt should provide a lookup table.

**I4. `"CodeGraphContext (CGC)"` referenced on line 18**
- The prompt claims access to "Dead code detection, complexity analysis, dependency graphs" via CGC. The codebase has `inspectCodegraphState()` which only checks if the CodeGraph DB file exists. No CGC tool or integration is implemented.
- **Impact:** Unreachable capability. The prompt promises analysis the agent cannot perform.

**I5. `"Repomix"` referenced on line 19**
- Described as "Full-file context packing with token-efficient summaries." No Repomix integration exists anywhere in the codebase.
- **Impact:** Unreachable capability.

---

## 5. Style System Conflicts

### Template Name / ID Conflicts

| Prompt Page Type | Prompt Name | style-system.json Template ID | style-system.json Name | Conflict |
|---|---|---|---|---|
| Type 1 | Landing / Overview | `overview` | Overview page | Name mismatch; section lists differ (prompt: HERO, AT A GLANCE, etc.; style-system: Overview, What Lives Here, Reading Order, Sources) |
| Type 2 | Quickstart / Tutorial | `getting-started` | Getting started | Section mismatch (prompt: HERO, PREREQUISITES, STEPS, VERIFICATION, NEXT STEPS; style-system: Overview, Open The Surface, Local Commands, Next Steps) |
| Type 3 | Concept Explainer | `concept` | Concept explainer | Section mismatch (prompt: 8 sections starting with HERO + FRAMING; style-system: Overview, Why It Matters, Practical Reading, Sources) |
| Type 4 | Integration Guide | (none) | (none) | No conflict -- not in style-system |
| Type 5 | Connector Guide | (none) | (none) | No conflict -- not in style-system |
| Type 7 | Cookbook / Recipe | (none) | (none) | No conflict -- not in style-system |
| Type 8 | Reference / Specification | (none) | (none) | No conflict -- not in style-system |
| Type 9 | Migration Guide | (none) | (none) | No conflict -- not in style-system |
| N/A | N/A | `protocol` | Protocol reference | Exists in style-system but NOT in prompt -- would be orphaned |
| N/A | N/A | `frontend-boundary` | Surface boundary page | Exists in style-system but NOT in prompt -- would be orphaned |
| N/A | N/A | `architecture-diagram` | Architecture diagram page | Exists in style-system but NOT in prompt -- subsumed by Type 3 |
| N/A | N/A | `sequence-diagram` | Sequence diagram page | Exists in style-system but NOT in prompt -- would be orphaned |
| N/A | N/A | `screenshot-walkthrough` | Screenshot walkthrough | Exists in style-system but NOT in prompt -- would be orphaned |
| N/A | N/A | `video-walkthrough` | Video walkthrough | Exists in style-system but NOT in prompt -- would be orphaned |

### Design Token Conflicts

| Token | Prompt Value | style-system.json Value | Conflict |
|---|---|---|---|
| Typography body font | "Inter for body" (line 621) | Georgia-based editorial stack (style-system.json line 130) | YES -- different font families |
| Typography code font | "JetBrains Mono for code" (line 621) | "Monospace code blocks" (generic, style-system.json line 132) | Partial -- prompt is more specific |
| Palette | "#7c3aed accent" (page-type-templates.json) | "Teal action color" (style-system.json line 137) | YES -- purple (#7c3aed) vs teal |
| Background | page-type-templates.json dark: `#0f1117` | "Parchment background" (style-system.json line 136) | YES -- dark tech vs warm parchment |
| Motion | page-type-templates.json has animated transitions | "Keep interactions minimal" (style-system.json line 142) | Directional conflict |

### Component Mapping Conflicts

- style-system.json `componentMappings.platforms.fumadocs` = `"docs.page, callout, steps"` (vague, 3 components)
- page-type-templates.json `fumadocs_component_mapping` = full mapping with 11 Mintlify-to-Fumadocs equivalences
- **Impact:** The two files define Fumadocs components at different levels of specificity. The style-system.json mapping is too coarse to be useful alongside the detailed template mapping.

### IA Variant Conflict

- style-system.json `informationArchitecture.chosenVariant` = `"journey-led"` with 4 stages (Add, Check, Query, Iterate)
- Prompt IA template (lines 433-468) = taxonomy-led with 10 section groups (concepts, guides, integrations, api-reference, cookbook, reference, deployment, migration, changelog)
- **Impact:** The two systems propose fundamentally different IA strategies. The journey-led approach is organized around reader tasks; the prompt's taxonomy approach is organized around page type categories. Adopting the prompt means abandoning the style-system's chosen variant.

---

## 6. Missing Instructions List (Priority-Ranked)

### P0 -- Blockers (agent cannot function correctly without these)

1. **MDX validation rules**: The prompt says "valid Fumadocs MDX" but provides no validation criteria. Which JSX components are allowed? What happens if a component import is missing? What about nested MDX? The agent needs concrete validation rules or a validator tool.

2. **Error handling for generation failures**: `chat-engine.ts` has a catch block (line 219) that falls back to a skeleton page. The prompt has zero guidance on what to do when CodeGraph is unavailable, NotebookLM is down, or the LLM produces invalid output. Every phase needs a degradation strategy.

3. **Content length limits**: The `wikiPageSchema` has no content length constraint. The prompt has no per-page word count target or max. Without this, the agent may generate pages that are too short (100 words) or too long (10K words) for the reading experience.

4. **Hierarchical slug convention**: The IA tree uses paths like `concepts/architecture` but the existing system uses flat slugs. The `pagePath()` function resolves to `docsRoot/${slug}.md` -- this would create `docs/concepts/architecture.md` correctly, but the DB, nav sync, and cross-linking all assume flat slugs. The slug hierarchy convention must be defined.

### P1 -- Important (agent produces degraded output without these)

5. **Rate limits for external tool calls**: The `docs-pipeline.ts` QA system has a `rateLimit` field in `DocsQualityReport` (lines 69-76). The prompt provides no guidance on rate limiting LLM calls, NotebookLM calls, or CodeGraph queries during a full wiki generation. A 40-page wiki could require 100+ LLM calls.

6. **Idempotency rules**: Can the agent regenerate a page that already exists? The `createPage` tool overwrites via `db.savePage()`. But the prompt says "Generate Landing Overview first (sets the tone)" -- what if it already exists? Must it be regenerated? Skipped? Diffed?

7. **Cross-link resolution at generation time**: The prompt says "Every page links to at least 2 other pages via Next Steps cards" (line 488) and "Verify all cross-links resolve" (line 568). But during Phase 3, pages are generated sequentially. A page generated early cannot link to pages that do not yet exist. The prompt needs a backfill or two-pass linking strategy.

8. **MDX import deduplication**: The prompt template (lines 35-42) shows 6 component imports. If a page only uses `Card` and `Cards`, should the agent include all 6 imports or only the used ones? No guidance.

9. **Frontmatter field `icon` mapping**: The prompt requires `icon: "IconName"` in frontmatter (line 33) but provides no mapping table. The agent needs to know valid Lucide icon names for each page type.

### P2 -- Nice-to-have (polish issues)

10. **Language tab requirements**: `page-type-templates.json` says `"always_tabbed": true` and `"default_languages": ["TypeScript", "Python"]`. But many Kijko_Docs pages only make sense in TypeScript (it is a TypeScript monorepo). Should the agent generate Python examples for concepts that only exist in TypeScript? The prompt needs a "single-language repo" exception.

11. **When to use tables vs TypeTable**: The prompt uses both Markdown tables (line 188-191) and `<TypeTable>` components (lines 241-247). No guidance on which to use when.

12. **Diagram format preference**: The prompt references both "NotebookLM infographics" and "Mermaid diagrams rendered via Fumadocs" as alternatives (line 172). The style-system.json supports d2 and mermaid. The existing pages use mermaid. No clear priority order.

13. **Changelog format**: The prompt says "Generate Changelog (if applicable)" but provides no template for Type "Changelog" -- it is listed as "(special)" with no section definition.

14. **SEO description length enforcement**: Prompt line 31 says "SEO-optimized description (120-160 chars)" but nothing in the system validates this. The current `renderFrontmatter()` derives description from `page.metadata.component` or `page.title`, which are typically much shorter.

15. **Tone enforcement per page type**: Each type has a "Tone" directive (e.g., "Confident, welcoming" for Type 1, "Direct, encouraging" for Type 2). The agent system prompt does not include these tone directives. How does the agent switch tone between page types?

---

## 7. Recommended Prompt Improvements

### 7.1 Resolve the MkDocs / Fumadocs Split

Add a section acknowledging the transition state:

```markdown
## Framework Target

The **current** wiki system outputs plain Markdown (`.md`) with MkDocs Material navigation.
The **target** system outputs Fumadocs MDX (`.mdx`) with `meta.json` navigation.

During the transition:
- Generate `.mdx` files but validate they also parse as valid Markdown
- Generate both `meta.json` (Fumadocs) and `mkdocs.yml` (legacy) navigation
- Do NOT use Fumadocs components that have no Markdown fallback until the framework switch is complete
```

### 7.2 Add Degradation Strategies

Add after the pipeline definition:

```markdown
## Degradation Rules

If a tool is unavailable during generation:
- **CodeGraph unavailable**: Skip Phase 1 CodeGraph analysis. Use file-tree scanning and Repomix as fallback. Note in page frontmatter: `codegraph_available: false`
- **NotebookLM unavailable**: Skip infographic generation entirely. Use Mermaid code blocks as diagram fallback. Note in page frontmatter: `infographics: "mermaid-only"`
- **Repomix unavailable**: Use raw file reads with token counting. Cap context at 50K tokens.
- **LLM generation fails**: Use the skeleton fallback template. Mark page as `draft: true`.
```

### 7.3 Define Content Length Targets

Add to the Content Generation Rules section:

```markdown
### Content Length Targets

| Page Type | Word Count Target | Min | Max |
|-----------|------------------|-----|-----|
| Landing / Overview | 400-800 | 200 | 1200 |
| Quickstart | 600-1200 | 400 | 1500 |
| Concept Explainer | 1000-2000 | 600 | 3000 |
| Integration Guide | 800-1500 | 500 | 2000 |
| Cookbook Recipe | 1500-3000 | 800 | 5000 |
| Reference / Spec | 500-1500 | 300 | 3000 |
| Migration Guide | 800-1500 | 500 | 2000 |
```

### 7.4 Add Cross-Link Resolution Strategy

Add to the pipeline definition:

```markdown
### Cross-Link Strategy (Two-Pass)

**Pass 1 (Generation)**: Generate all pages with placeholder cross-links using `[LINK:slug]` syntax.
**Pass 2 (Resolution)**: After all pages exist, resolve placeholders to actual paths and validate all links. Add any missing Next Steps cards.
```

### 7.5 Reconcile Agent Instructions

Replace the wiki-agent.ts system instruction with a reference to the prompt, or add this bridging note to the prompt:

```markdown
## Agent System Instruction Override

When this prompt is loaded, it REPLACES the default agent system instruction. The agent
should NOT fall back to "Prefer sections named Overview, Architecture, Key Components,
and Sources" -- it should use the page type templates defined in this document.
```

### 7.6 Add Protocol / Workflow Page Type

Add a Type 10 to cover the existing `protocol` template in style-system.json:

```markdown
### Type 10: Protocol / Workflow

**When to use**: Inter-system handoff, context relay, or data exchange protocol.
**Tone**: Formal, precise. Focuses on participants, sequence, and failure modes.

Sections: Role, Participants, Sequence, Failure Modes, Related Pages
```

### 7.7 Specify Slug Hierarchy Convention

Add to the Output Format section:

```markdown
### Slug Convention

- Top-level pages: `quickstart`, `authentication`
- Nested pages: `concepts/architecture`, `guides/writing-pages`
- Separator: forward slash `/`
- Characters: lowercase alphanumeric and hyphens only
- The directory structure in `wiki-content/docs/` must mirror the slug hierarchy
```

### 7.8 Remove Unreachable Capabilities

Either implement tools for CodeGraph queries, CGC analysis, and Repomix, or change the prompt's "You have access to" section (lines 16-20) to accurately reflect current capabilities:

```markdown
You have access to:
- **NotebookLM**: Documentation search (via OpenNotebook API)
- **Wiki Tools**: Page CRUD operations with MkDocs nav sync
- **Docs Pipeline**: Quality checks, discovery reports, API surface analysis
- **File System**: Read/write to wiki-content directory

The following are PLANNED but not yet available:
- CodeGraph semantic search and impact analysis
- CGC dead code detection and complexity analysis
- Repomix full-file context packing
- NotebookLM infographic generation
```

---

## Summary of Findings

| Category | Count | Severity |
|---|---|---|
| Contradictions | 4 | 2 high (C1, C2), 2 low (C3, C4) |
| Ambiguities | 5 | 2 high (A2, A3), 3 medium |
| Incomplete References | 5 | 2 high (I4, I5), 3 medium |
| Style System Conflicts | 5 token conflicts, 6 orphaned templates, 1 IA variant conflict | High -- the two systems are not aligned |
| Missing Instructions | 15 | 4 P0 blockers, 5 P1 important, 6 P2 polish |
| Tool Gaps | 4 of 6 phases have no tool support | High -- the prompt describes a system that mostly does not exist yet |

**Bottom line:** The generation prompt is a well-structured aspirational specification for a Fumadocs-based wiki generator. It does not describe the system that currently exists. The current system is a single-page Markdown generator with MkDocs nav sync and basic intent classification. Adopting the prompt requires: (1) new tools for 4 of 6 pipeline phases, (2) switching from `.md` to `.mdx` output, (3) switching from MkDocs to Fumadocs navigation, (4) reconciling the style-system.json design tokens and template library, and (5) building an orchestration layer that can execute the 6-phase pipeline rather than the current single-pass generation.
