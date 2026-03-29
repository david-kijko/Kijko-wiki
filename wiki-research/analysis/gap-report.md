# Template Validation & Gap Analysis Report

> Generated: 2026-03-28
> Source: 37 scraped SuperMemory docs pages vs. 9-type page template system
> Analyst: Team 1 (Template Validator & Gap Analyst)

---

## 1. Coverage Summary

**Overall coverage: ~89% (33 of 37 pages) cleanly fit existing templates.**

4 pages require either a new page type or significant template adjustment.

| Template Type | Expected Pages | Matched Scraped Pages | Coverage |
|---|---|---|---|
| Landing / Overview | ~5 | 5 (intro, connectors_overview, cookbook_overview, memorybench_overview, memory-router_overview) | 100% |
| Quickstart / Tutorial | ~4 | 3 (quickstart, memorybench_quickstart, vibe-coding) | 75% |
| Concept Explainer | ~9 | 7 (how-it-works, graph-memory, memory-vs-rag, super-rag, content-types, filtering, user-profiles) | 78% |
| Integration Guide | ~20 | 5 scraped (claude-code, mastra, openai, langchain, agent-framework) -- representative sample | 100% structural match |
| Connector Guide | ~8 | 3 (connectors_overview, github, notion) | 100% structural match |
| API Reference | ~38 | 3 (create-memories-directly, search-memory-entries, add-document) | 100% structural match |
| Cookbook / Recipe | ~7 | 2 (personal-assistant, customer-support) | 100% structural match |
| Reference / Spec | ~5 | 1 (memorybench_quickstart follows this partially) | Partial |
| Migration Guide | ~2 | 1 (from-mem0) | 100% structural match |

### Pages That Don't Fit Cleanly

| Page | Closest Template | Gap |
|---|---|---|
| `authentication.md` | **None exact** -- hybrid concept/reference | Needs "Configuration Reference" sub-type or "Operational Guide" type |
| `add-memories.md` | Hybrid quickstart + reference | Too much reference content for quickstart, too procedural for concept |
| `search.md` | Hybrid quickstart + reference | Same issue as add-memories -- "feature guide" pattern |
| `memory-operations.md` | Reference / Spec | Fits but template lacks "SDK Operations" section pattern |
| `document-operations.md` | Reference / Spec | Same as memory-operations |
| `deployment_self-hosting.md` | **None** -- Deployment Guide | Completely new page type not in taxonomy |
| `model-enhancement_getting-started.md` | Quickstart / Tutorial | Close but has unique "proxy setup" pattern |
| `supermemory-mcp_introduction.md` | Landing / Overview | Mostly fits but has unique "platform list" pattern |
| `changelog_overview.md` | **None** -- Changelog | Completely new page type not in taxonomy |

---

## 2. Uncovered Page Types

### 2.1 "Operational Guide" / "Feature Guide" (HIGH PRIORITY)

**Affected pages:** `authentication.md`, `add-memories.md`, `search.md`, `memory-operations.md`, `document-operations.md`

These pages follow a pattern not captured by any of our 9 types. They are:
- Not conceptual (no mental model / analogy section)
- Not quickstart (no numbered steps with time-to-complete)
- Not API reference (not auto-generated from OpenAPI)
- Not integration guides (not framework-specific)

**Pattern observed:**
1. Title + one-line description
2. "Quick Start" code block (TypeScript / Python / cURL tabs)
3. Parameters table (Name, Type, Default, Description)
4. Multiple operational sections (each with code examples)
5. Accordion sections for advanced details (Error Handling, Batch Upload, Delete Content, Response Schema)
6. Next Steps cards

**Recommendation:** Create a 10th page type: **"Feature / Operations Guide"** -- covers SDK feature walkthroughs with parameter tables, code examples, and accordion-wrapped advanced content.

### 2.2 "Deployment Guide" (MEDIUM PRIORITY)

**Affected page:** `deployment_self-hosting.md`

Unique structure:
1. Enterprise callout/warning
2. Prerequisites section (extensive, with sub-sections per service)
3. Numbered accordion steps for each external service setup
4. Environment variables table (large, with Required? column)
5. Deploy command section
6. Update instructions

Not in our taxonomy at all. Could be folded into "Reference / Spec" but the structure is fundamentally different.

### 2.3 "Changelog" (LOW PRIORITY)

**Affected page:** `changelog_overview.md`

Timeline-based content with dated entries. Completely different layout from all other types. Low priority since it's a single page but should be noted.

---

## 3. Missing Components

### 3.1 Mintlify Components NOT Mapped to Fumadocs

| Mintlify Component | Found In | Status in `fumadocs_component_mapping` |
|---|---|---|
| **Mermaid/Sequence Diagrams** | `integrations_mastra.md` (SupermemoryOutputProcessor sequence diagram) | MISSING -- no mapping |
| **"Try it" / API Playground** | All API reference pages | Listed as `fumadocs-openapi APIPage` but NOT in component list |
| **Horizontal Rule / Divider** (`---` / `* * *`) | Nearly every page | MISSING -- used as section separator in most pages |
| **HTTP Method Badge** (POST, GET, DELETE colored badges) | API reference pages | MISSING -- needs custom component or fumadocs-openapi |
| **Status Code Tabs** (200, 400, 401, 500) | API reference pages | MISSING -- these are response-variant tabs, different from language tabs |
| **"Show child attributes" toggle** | API reference pages (nested schema) | MISSING -- expandable nested type documentation |
| **External Link Card** | `integrations_mastra.md`, `integrations_openai.md` (NPM/PyPI links) | MISSING -- Card with external URL badge, different from nav cards |
| **Logo/Banner Image** (hero position) | `integrations_claude-code.md` | Not specifically mapped -- ImageZoom is mapped but hero-position image is a pattern, not a component |
| **Plan Requirement Badge/Callout** | `integrations_claude-code.md`, `connectors_github.md` | Partially covered by Callout `warning` but is actually a distinct visual pattern (colored banner) |
| **Platform/OS Tabs** (macOS/Linux/Windows) | `integrations_claude-code.md` | Covered by Tabs component but pattern NOT documented in templates |
| **Mermaid flow diagrams** (text-based: `External Document -> Webhook -> ...`) | `connectors_overview.md` pipeline | MISSING -- rendered as arrow-connected flow in Mintlify |
| **"Coming Soon" grayed-out cards** | `cookbook_overview.md` | MISSING -- cards with disabled/muted state |
| **"Live Demo" inline link badge** | `memory-router_overview.md` | MISSING -- styled inline call-to-action |
| **Response Headers table** | `memory-router_overview.md` | Covered by TypeTable but pattern not documented |
| **Pricing table** | `memory-router_overview.md` | MISSING -- distinct from standard parameter tables |

### 3.2 Components in Templates But Not Observed in Scraped Pages

| Template Component | Status |
|---|---|
| `ImageZoom` | Images are present but zoom behavior cannot be verified from markdown scrape |
| `Accordion` / `Accordions` | CONFIRMED present in `add-memories.md`, `search.md` (expandable sections like "Parameter Details", "Batch Upload") |

---

## 4. Missing Section Patterns

These patterns repeat across multiple pages but are NOT captured in our template sections:

### 4.1 Universal Patterns Found But Not Fully Documented

| Pattern | Pages Where Found | In `universal_patterns`? | In Page Type Templates? |
|---|---|---|---|
| **"Was this page helpful?" Yes/No widget** | ALL 37 pages | Listed in `every_page_has` | But NOT in any page type section list |
| **Previous / Next page navigation** | ALL 37 pages | Listed in `navigation.footer` | But NOT in any page type section list |
| **AI Assistant widget** ("Ctrl+I", "Responses are generated using AI") | ALL 37 pages | NOT documented anywhere | MISSING |
| **Suggestion prompts** ("User profiles and tool use...") | ALL 37 pages | NOT documented anywhere | MISSING |
| **Contact support link** | ALL 37 pages | NOT documented anywhere | MISSING |
| **"Skip to main content" link** | ALL 37 pages (accessibility) | NOT documented anywhere | MISSING |
| **Top-bar horizontal tab navigation** | ALL 37 pages (Developer Platform, API Integrations, etc.) | In `navigation.top_bar` | But specific tab labels not documented |
| **Search bar with "Ask AI"** | ALL 37 pages | In `navigation.search` | But "Ask AI" feature not noted |
| **Logo (light/dark variants)** | ALL 37 pages | NOT documented | MISSING |

### 4.2 Repeated Content Patterns Not in Templates

| Pattern | Description | Frequency | Missing From |
|---|---|---|---|
| **Accordion for advanced content** | "Parameter Details & Examples", "Batch Upload", "Error Handling", "Filter Types", "Response Schema" -- expandable sections at the end of feature guides | 5+ pages | Not in quickstart, concept, or any non-cookbook template |
| **"Quick Reference" summary section** | Brief recap table at end before Next Steps | `concepts_filtering.md`, `search.md` | Not in any template |
| **Horizontal rule section separators** | `* * *` or `---` between major H2 sections | ~25 pages | Not documented as a pattern |
| **Inline callout-link** ("Using Vercel AI SDK? Check out...") | Promotional cross-link at the very top, before any H2 | `quickstart.md`, `memory-router_overview.md` | Not in any template section list |
| **Side-by-side comparison blocks** | Two `## Traditional Systems` / `## Supermemory` blocks used as a visual comparison | `concepts_how-it-works.md`, `concepts_super-rag.md` | Template mentions "CardGroup comparing concepts" but actual implementation is dual-heading blocks, not cards |
| **Before/After tabbed code** | Tabs labeled "Mem0" / "Supermemory" or "The Scenario" / "RAG Approach" / "Memory Approach" | `migration_from-mem0.md`, `concepts_memory-vs-rag.md` | Migration template mentions "Before/after code blocks" but the multi-tab pattern (3+ tabs for scenarios) is not captured |
| **TypeScript interface blocks** | Interface/type definitions in code blocks (not just usage examples) | `search.md` (SearchResult interface), `integrations_mastra.md` (SupermemoryMastraOptions) | Not mentioned as a distinct pattern |
| **API reference inline within integration pages** | Integration pages include their own mini "API Reference" section with function signatures and TypeScript types | `integrations_mastra.md`, `integrations_openai.md`, `integrations_agent-framework.md` | Integration template has "Commands / API" but doesn't describe the function-signature-with-types pattern |
| **"Enterprise only" / plan-gated callouts** | Warning callouts noting plan requirements | `connectors_github.md`, `integrations_claude-code.md`, `deployment_self-hosting.md` | Connector template has "plan_callout" but other templates don't |
| **Nested numbered steps with headers** | Steps like "1. Create Connection" rendered as H3 with numbering | `connectors_overview.md`, `connectors_github.md`, `connectors_notion.md`, `migration_from-mem0.md` | Steps component described differently in templates (vertical connector + step title) |
| **Multi-screenshot walkthrough** | Sequential screenshots showing UI steps (login -> API keys -> create -> copy) | `model-enhancement_getting-started.md` | Only quickstart template mentions "Dashboard Screenshot" (singular) |

---

## 5. Template Corrections Needed

### 5.1 `landing_overview` Template

**Issue:** The `at_a_glance` section describes "2-3 column CardGroup with icons" but actual intro.md uses a **bullet list with inline links**, not cards. Cards only appear in the "Next Steps" section.

**Fix:** Change `at_a_glance` to allow both CardGroup and bullet-list-with-links as valid patterns. The actual intro page uses `H4` subsections (Ingestion, Memory API, User Profiles, RAG) with prose + images, not cards.

**Issue:** Landing pages like `memorybench_overview.md` and `memory-router_overview.md` use **different card layouts** -- memorybench uses 5 cards in a single group, memory-router uses a tabbed "Perfect For" / "Consider API Instead" pattern.

**Fix:** Add variant: `at_a_glance` can be "card grid", "bullet list", or "tabbed comparison".

### 5.2 `quickstart_tutorial` Template

**Issue:** The actual `quickstart.md` does NOT use a Steps component. It uses **bold inline step numbers** ("**Step 1.**", "**Step 2.**", "**Step 3.**") within prose, not a formal Steps component.

**Fix:** Allow informal numbered steps (bold text) as an alternative to the Steps component.

**Issue:** `quickstart.md` has NO "prerequisites" callout section. It jumps straight into the SDK setup after a single-line promotional callout.

**Fix:** Mark `prerequisites` as `required: false` or note that some quickstarts embed prerequisites inline.

**Issue:** The `next_steps` section at the bottom of `quickstart.md` uses a text link list ("Learn more about User Profiles and Search"), not a CardGroup.

**Fix:** Allow text link lists as a valid Next Steps format.

### 5.3 `concept_explainer` Template

**Issue:** The `mental_model` section describes "CardGroup comparing two concepts with icons and bullet traits." Actual implementation in `concepts_how-it-works.md` uses **two adjacent H2 headings** ("## Traditional Systems" / "## Supermemory") with bullet lists under each -- this renders as a side-by-side comparison in Mintlify but is NOT a CardGroup.

**Fix:** Document this as a "dual-column comparison block" pattern. Map it to a custom Fumadocs component or a two-column grid layout.

**Issue:** Several concept pages (`content-types`, `filtering`) lack a `mental_model` section entirely. They jump from hero to mechanism directly.

**Fix:** Change `mental_model` from `required: true` to `required: false`.

**Issue:** `concepts_memory-vs-rag.md` uses **3-tab comparison blocks** (The Scenario / RAG Approach / Memory Approach) which is a more complex pattern than "Side-by-side comparison blocks."

**Fix:** Document tabbed-scenario-comparison as a valid `comparison` section variant.

### 5.4 `integration_guide` Template

**Issue:** Several integration pages (mastra, openai, agent-framework) include a substantial **"API Reference" section** with function signatures, TypeScript types, and parameter documentation. This is much more than "Commands / API" suggests.

**Fix:** Rename `commands` section to `api_reference` and describe: "Function signatures with TypeScript/Python type annotations, parameter tables, and return type documentation."

**Issue:** `integrations_openai.md` uses a **two-approach structure** (withSupermemory wrapper vs. Function calling tools) that splits the page into two parallel tracks. This is similar to the cookbook's `choice_point` pattern.

**Fix:** Add optional `choice_point` section to integration_guide template.

**Issue:** Some integrations (agent-framework) include a **"Memory Modes" comparison table** that doesn't fit any current section.

**Fix:** Add optional `modes_comparison` section.

**Issue:** `integrations_claude-code.md` opens with a **hero image/banner** (product screenshot) followed by a **plan requirement warning callout** before any prose. Template puts `hero` as "Title + Logo/Badge" but actual pattern is full-width image.

**Fix:** Clarify that `hero` can include a full-width banner image, not just an inline logo.

### 5.5 `connector_guide` Template

**Issue:** The actual connector pages (`github`, `notion`) have a much more detailed structure than the template suggests. GitHub has: Quick Setup, Supported Document Types, Incremental Sync with Webhooks (including "How It Works" and "Webhook Security" sub-sections), Connection Management (List, Update, Delete, Manual Sync sub-sections), and Advanced Configuration.

**Fix:** Expand `management` section to explicitly include: List, Update/Configure, Delete, and Manual Sync as sub-patterns. Add `webhook_details` as optional section.

**Issue:** `connectors_overview.md` does NOT have a "Next Steps" CardGroup -- it just ends with Connection Management. But it does have a rich **pipeline flow diagram** (text-arrow format) not mentioned in template.

**Fix:** Add optional `pipeline_diagram` section to connector overview pages.

### 5.6 `api_reference` Template

**Issue:** The actual API reference pages have a **two-panel layout**: left panel shows request/response with code examples, right panel shows parameter documentation with type annotations and "Show child attributes" toggles. Our template describes this as sections but doesn't capture the two-column layout.

**Fix:** Add `layout: "two-column"` to api_reference template. Document the left-panel (code) / right-panel (params) split.

**Issue:** API pages show code examples in **JavaScript only** (using `fetch`), not in TypeScript SDK / Python SDK / cURL tabs as the template claims.

**Fix:** Correct the `code_examples` section: actual pattern is a single JavaScript `fetch` example on the left panel, not tabbed SDK examples. The tabbed SDK pattern is only in non-API-reference pages.

**Issue:** The "Try it" interactive playground is present as a **button**, not an embedded widget. It redirects to an API playground.

**Fix:** Update `try_it` section description from "Fumadocs OpenAPI playground widget" to "Try It button that opens interactive playground."

### 5.7 `cookbook_recipe` Template

**Issue:** The actual cookbook pages use **H2 headings for implementation steps** (Step 1: Project Setup, Step 2: Backend, Step 3: Frontend, Step 4: Run It) with **H3 sub-steps** within each. The template says "H2 per major step" but doesn't mention the **sub-step breakdown pattern** (Import Dependencies -> Initialize -> Define -> Create -> etc.).

**Fix:** Document the H2-step / H3-substep hierarchy explicitly.

### 5.8 `migration_guide` Template

**Issue:** The actual `migration_from-mem0.md` uses a **numbered Steps component** (1, 2, 3 with headers: "Export from Mem0", "Set Up Supermemory", "Import to Supermemory") but also starts with a "Quick Migration (All-in-One)" script before the step-by-step. Template doesn't mention this "quick path" pattern.

**Fix:** Add optional `quick_migration` section before `steps` -- a single all-in-one script for users who want to skip the detailed walkthrough.

**Issue:** The `comparison` section in the template says "Table comparing old vs new capabilities" but actual page uses **before/after tabbed code blocks** ("Mem0" / "Supermemory" tabs showing equivalent code), not a feature comparison table.

**Fix:** Change `comparison` to `api_mapping` and describe: "Side-by-side tabbed code blocks showing equivalent operations in old vs new SDK."

---

## 6. Priority Fixes (Ranked by Impact)

### P0 -- Critical (Blocks Page Generation)

1. **Create "Feature / Operations Guide" page type** -- 5+ root-level pages (authentication, add-memories, search, memory-operations, document-operations) cannot be generated with current templates. This is the biggest gap.

2. **Fix API Reference two-column layout** -- All ~38 API reference pages need the two-panel layout. Current template describes it as linear sections but actual layout is fundamentally different (code left, docs right).

3. **Add Accordion sections to non-cookbook templates** -- Expandable content sections (Parameter Details, Error Handling, Batch Upload, Response Schema) appear across feature guides, connector pages, and integration pages. Only cookbook_recipe template includes Accordions.

### P1 -- High Priority (Incorrect Generation Output)

4. **Fix `quickstart_tutorial` step format** -- Template specifies formal Steps component but actual page uses bold-inline numbering. Generated pages will look wrong.

5. **Fix `concept_explainer` comparison pattern** -- Template says CardGroup but actual pages use dual-heading side-by-side blocks. Wrong component will be generated.

6. **Fix `landing_overview` at-a-glance pattern** -- Template says CardGroup but intro.md uses H4 subsections with prose. Mismatch will produce incorrect layout.

7. **Add inline API reference sections to integration_guide** -- Long integration pages (mastra, openai, agent-framework) include TypeScript type definitions and function signatures. Without this, generated integration pages will be incomplete.

8. **Map Mintlify sequence/flow diagrams to Fumadocs** -- Mermaid diagrams in mastra integration page and text-arrow flow diagrams in connectors overview have no Fumadocs mapping.

### P2 -- Medium Priority (Missing Features)

9. **Add "Deployment Guide" page type** -- Only 1 page (self-hosting) but has unique requirements (environment variable tables, service-by-service setup).

10. **Document horizontal rule pattern** -- `* * *` / `---` separators used in ~25 pages between H2 sections. Not mentioned anywhere but critical for visual spacing.

11. **Add platform/OS tab pattern** -- macOS/Linux/Windows tabs (seen in claude-code) are a distinct pattern from language tabs (TS/Python/cURL).

12. **Add "Coming Soon" disabled card pattern** -- Cookbook overview uses grayed-out cards for upcoming recipes.

13. **Add plan-gated callout pattern to all templates** -- Currently only connector_guide has `plan_callout`. Integrations and deployment pages also use it.

14. **Document AI Assistant widget** -- "Ctrl+I" AI chat assistant appears on every page. Needs to be in universal_patterns as a footer element.

15. **Fix `mental_model` required status** -- Several concept pages skip this section. Should be optional.

### P3 -- Low Priority (Polish)

16. **Add Changelog page type** -- Single page, low generation frequency.

17. **Document "Suggestions" prompts in footer** -- Pre-filled AI prompt suggestions appear on every page.

18. **Add "Contact support" footer link** -- Universal but not documented.

19. **Map light/dark logo variants** -- Every page has dual logo references. Should be in design tokens.

20. **Document "Ask AI" search feature** -- Search bar includes AI-powered search, extending beyond basic full-text noted in templates.

---

## Appendix: Complete Page Classification

| Scraped Page | Classified Type | Fit Quality |
|---|---|---|
| `intro.md` | Landing / Overview | Good (minor at-a-glance mismatch) |
| `quickstart.md` | Quickstart / Tutorial | Fair (step format mismatch) |
| `authentication.md` | **UNCLASSIFIED** -- Feature/Operations Guide | Poor fit to any template |
| `add-memories.md` | **UNCLASSIFIED** -- Feature/Operations Guide | Poor fit to any template |
| `search.md` | **UNCLASSIFIED** -- Feature/Operations Guide | Poor fit to any template |
| `memory-operations.md` | Reference / Spec (partial) | Fair |
| `document-operations.md` | Reference / Spec (partial) | Fair |
| `vibe-coding.md` | Quickstart / Tutorial | Good |
| `concepts_how-it-works.md` | Concept Explainer | Good |
| `concepts_graph-memory.md` | Concept Explainer | Good |
| `concepts_memory-vs-rag.md` | Concept Explainer | Good (comparison tab mismatch) |
| `concepts_super-rag.md` | Concept Explainer | Good |
| `concepts_content-types.md` | Concept Explainer | Good (no mental_model) |
| `concepts_filtering.md` | Concept Explainer | Good (no mental_model) |
| `concepts_user-profiles.md` | Concept Explainer | Good |
| `integrations_claude-code.md` | Integration Guide | Good (hero image pattern different) |
| `integrations_mastra.md` | Integration Guide | Good (has inline API reference) |
| `integrations_openai.md` | Integration Guide | Fair (dual-track structure) |
| `integrations_langchain.md` | Integration Guide | Good |
| `integrations_agent-framework.md` | Integration Guide | Good (has inline API reference) |
| `connectors_overview.md` | Landing / Overview | Good (has pipeline diagram) |
| `connectors_github.md` | Connector Guide | Good |
| `connectors_notion.md` | Connector Guide | Good |
| `cookbook_overview.md` | Landing / Overview | Good (has "Coming Soon" cards) |
| `cookbook_personal-assistant.md` | Cookbook / Recipe | Good |
| `cookbook_customer-support.md` | Cookbook / Recipe | Good |
| `api-reference_manage-documents_add-document.md` | API Reference | Good (layout mismatch) |
| `api-reference_memories_create-memories-directly.md` | API Reference | Good (layout mismatch) |
| `api-reference_search_search-memory-entries.md` | API Reference | Good (layout mismatch) |
| `memorybench_overview.md` | Landing / Overview | Good |
| `memorybench_quickstart.md` | Quickstart / Tutorial | Good |
| `migration_from-mem0.md` | Migration Guide | Good (missing quick-path) |
| `memory-router_overview.md` | Landing / Overview | Good (has pricing table) |
| `model-enhancement_getting-started.md` | Quickstart / Tutorial | Good (multi-screenshot) |
| `supermemory-mcp_introduction.md` | Landing / Overview | Good |
| `deployment_self-hosting.md` | **UNCLASSIFIED** -- Deployment Guide | No matching template |
| `changelog_overview.md` | **UNCLASSIFIED** -- Changelog | No matching template |
