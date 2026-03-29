# Kijko WikiAgent — Fumadocs Integration Spec

> Produced by Team 3 (Integration Architect), 2026-03-28.
> Research-only document. No code changes are included.

---

## Architecture Overview

The Kijko WikiAgent workspace currently consists of three runtime surfaces:

1. **apps/web** — Next.js 16 App Router serving `/` (landing), `/docs` (markdown reader), `/chat` (CopilotKit control surface).
2. **apps/agent** — Hono HTTP + WebSocket server backed by Mastra, providing the wiki-generation agent, chat engine, docs automation pipeline, and MkDocs nav sync.
3. **wiki-content/** — Committed markdown files, two MkDocs YAML configs (internal/external), and `style-system.json`.

The new template system (reverse-engineered from SuperMemory/Mintlify, targeting Fumadocs) introduces:

- 9 page-type templates with section-level structure (`page-type-templates.json`)
- A generation system prompt for the WikiAgent (`wiki-generation-prompt.md`)
- NotebookLM MCP-driven infographic generation (`notebooklm-infographic-spec.md`)
- Fumadocs MDX output format with rich component imports (Cards, Callouts, Steps, Tabs, Accordion, TypeTable, ImageZoom)
- `meta.json`-based sidebar navigation replacing MkDocs YAML nav

The integration replaces the custom markdown-to-HTML rendering pipeline in `apps/web` with Fumadocs, while preserving the agent-side generation and chat surfaces. The key architectural change is that **content moves from `.md` with YAML frontmatter to `.mdx` with Fumadocs component imports**, and the web app adopts Fumadocs's built-in layout, sidebar, search, and TOC infrastructure instead of the current hand-rolled implementations.

### System Boundary Diagram

```
Before:
  wiki-content/docs/*.md --> apps/web/lib/docs.ts (custom parser) --> React SSR HTML
  wiki-content/mkdocs.*.yml --> MkDocs static site (parallel output)
  apps/agent/wiki-tools.ts --> writes .md + syncs mkdocs nav YAML

After:
  wiki-content/docs/**/*.mdx --> Fumadocs source loader --> Fumadocs MDX renderer --> React SSR
  wiki-content/docs/**/meta.json --> Fumadocs sidebar nav
  apps/agent/wiki-tools.ts --> writes .mdx + syncs meta.json nav
  MkDocs configs --> retained for backward-compat but no longer primary
```

---

## Package Dependencies

### apps/web — New Packages to Install

| Package | Purpose | Version Target |
|---------|---------|---------------|
| `fumadocs-ui` | UI components: Card, Cards, Callout, Steps, Tabs, Accordion, TypeTable, ImageZoom | latest stable |
| `fumadocs-core` | Content source loader, MDX processing, search indexing, TOC extraction, breadcrumbs | latest stable |
| `fumadocs-mdx` | MDX file source integration for Next.js App Router, frontmatter parsing, slug generation | latest stable |
| `fumadocs-openapi` | OpenAPI spec to docs page generation (for API reference Type 6 pages) | latest stable |
| `@mdx-js/mdx` | MDX compilation (peer dep of fumadocs-mdx) | ^3.x |
| `@mdx-js/react` | MDX React runtime (peer dep) | ^3.x |
| `shiki` | Syntax highlighting (Fumadocs default, replaces manual code rendering) | ^1.x |
| `rehype-katex` + `remark-math` | Optional: math rendering if concept pages need formulas | latest |

### apps/web — Packages to Remove (After Migration)

| Package | Reason |
|---------|--------|
| None immediately | CopilotKit and existing deps remain; the custom `lib/docs.ts` renderer gets retired but has no standalone package dependency |

### apps/agent — No New Package Deps

The agent writes files and manages nav config. It does not need Fumadocs packages. The only change is output format (MDX instead of MD, meta.json instead of mkdocs YAML).

---

## File Change Matrix

### New Files to Create

| File Path | Purpose |
|-----------|---------|
| `apps/web/source.config.ts` | Fumadocs source configuration: defines content directories, collections, MDX options |
| `apps/web/app/source.ts` | Fumadocs source loader instance (imports from source.config.ts, exports `getPages()`) |
| `apps/web/app/docs/layout.tsx` | Fumadocs `DocsLayout` wrapper with sidebar, search, and theme provider |
| `apps/web/app/docs/[[...slug]]/page.tsx` | Fumadocs catch-all docs page (replaces current `[...slug]/page.tsx`) |
| `apps/web/app/docs/[[...slug]]/layout.tsx` | Optional: per-page layout with TOC positioning |
| `apps/web/app/api-reference/[[...slug]]/page.tsx` | Fumadocs-OpenAPI auto-generated API reference pages |
| `apps/web/components/mdx/index.tsx` | Custom MDX component overrides: maps Fumadocs components + any Kijko-specific wrappers |
| `apps/web/components/mdx/feedback-widget.tsx` | "Was this page helpful?" footer widget (universal pattern from templates) |
| `apps/web/components/mdx/edit-page-link.tsx` | "Edit this page on GitHub" link component |
| `apps/web/lib/fumadocs-config.ts` | Shared Fumadocs configuration: theme tokens, icon mappings, search config |
| `wiki-content/docs/meta.json` | Root-level Fumadocs navigation config (replaces mkdocs nav) |
| `wiki-content/docs/concepts/meta.json` | Section-level nav for concepts |
| `wiki-content/docs/guides/meta.json` | Section-level nav for guides |
| `wiki-content/docs/integrations/meta.json` | Section-level nav for integrations |
| `wiki-content/docs/cookbook/meta.json` | Section-level nav for cookbook |
| `wiki-content/docs/reference/meta.json` | Section-level nav for reference |
| `wiki-content/docs/api-reference/meta.json` | Section-level nav for API reference |
| `wiki-content/docs/migration/meta.json` | Section-level nav for migration guides |
| `apps/agent/src/lib/fumadocs-nav.ts` | New module: generates/syncs `meta.json` files from DB page list (replaces mkdocs YAML sync) |
| `apps/agent/src/lib/mdx-writer.ts` | New module: writes Fumadocs-compatible MDX with component imports and structured frontmatter |
| `config/docs-api.openapi.yaml` | OpenAPI spec file (if not already present) for fumadocs-openapi generation |

### Files to Modify

| File Path | Action | Description |
|-----------|--------|-------------|
| `apps/web/package.json` | modify | Add fumadocs-ui, fumadocs-core, fumadocs-mdx, fumadocs-openapi, shiki, @mdx-js/* |
| `apps/web/next.config.ts` | modify | Add `createMDX()` wrapper from fumadocs-mdx, configure MDX transpilation, add webpack/turbopack MDX support |
| `apps/web/app/layout.tsx` | modify | Wrap with Fumadocs `RootProvider` for theme, search, and i18n; add Inter + JetBrains Mono fonts; import fumadocs-ui CSS |
| `apps/web/app/globals.css` | modify | Retain Kijko brand tokens as CSS custom properties; add Fumadocs CSS import; adapt existing `.docs-*` classes to coexist or be replaced by Fumadocs equivalents |
| `apps/web/app/page.tsx` | modify | Landing page stays custom (DocsLanding) but update links to use new Fumadocs slug structure |
| `apps/web/app/docs/page.tsx` | modify | Redirect or merge into the catch-all `[[...slug]]` route; Fumadocs handles index pages via `docs/index.mdx` |
| `apps/web/app/docs/[...slug]/page.tsx` | delete | Replaced by `[[...slug]]/page.tsx` using Fumadocs page loader |
| `apps/web/app/sitemap.ts` | modify | Use Fumadocs `getPages()` instead of `listDocsPages()` for sitemap generation |
| `apps/web/lib/docs.ts` | modify | Deprecate `renderMarkdownToHtml`, `parseFrontmatter`, `extractHeadingOutline`; retain `loadDocsStyleSystem` and catalog helpers for landing page; add a Fumadocs-backed `listDocsPages()` wrapper |
| `apps/web/components/docs/docs-landing.tsx` | modify | Update page links to use Fumadocs slug format; update `listDocsPages` calls to use Fumadocs source |
| `apps/web/components/docs/docs-sidebar.tsx` | delete | Replaced by Fumadocs `DocsLayout` built-in sidebar with collapsible tree, search, and icons |
| `apps/web/components/docs/markdown-page.tsx` | delete | Replaced by Fumadocs MDX page renderer with built-in TOC, breadcrumbs, and component resolution |
| `apps/agent/src/mastra/agents/wiki-agent.ts` | modify | Update agent instructions to reference Fumadocs MDX output format, page-type templates, and section structure |
| `apps/agent/src/mastra/tools/wiki-tools.ts` | modify | `create-page` tool: write `.mdx` instead of `.md`; call `syncFumadocsNav` instead of `syncMkdocsNav`; add `page_type` field to tool input schema |
| `apps/agent/src/lib/wiki-files.ts` | modify | Add `renderMdxFrontmatter()`, `writeMdxPage()`, and `syncFumadocsNav()` functions; deprecate (but retain) MkDocs sync functions for backward compat |
| `apps/agent/src/lib/chat-engine.ts` | modify | Update `generatePage()` to include page-type classification, structured section generation, and MDX component imports in output; pass template context to agent prompt |
| `apps/agent/src/index.ts` | modify | Initialize Fumadocs nav sync alongside MkDocs nav sync on startup; add API endpoint for triggering infographic generation |
| `packages/shared/src/models.ts` | modify | Add `pageType` field to `wikiPageSchema` (enum of 9 page types); add `sectionTemplate` field to `pageMetadataSchema`; add `infographic` action type |
| `wiki-content/style-system.json` | modify | Extend with Fumadocs component mappings from `page-type-templates.json`; merge design tokens (typography, colors) |
| `wiki-content/docs/index.md` | migrate | Convert to `index.mdx` with Fumadocs frontmatter and Card/Cards components |
| `wiki-content/docs/getting-started.md` | migrate | Convert to `getting-started.mdx` with Steps, Callout, and Cards components |
| `wiki-content/docs/panopticon.md` | migrate | Convert to MDX |
| `wiki-content/docs/panopticon-2-0.md` | migrate | Convert to MDX |
| `wiki-content/docs/hypervisa-3-0.md` | migrate | Convert to MDX |
| `wiki-content/docs/kijko-frontend.md` | migrate | Convert to MDX |
| `wiki-content/docs/baton-exchange.md` | migrate | Convert to MDX |
| `wiki-content/mkdocs.internal.yml` | retain | Keep for backward compatibility; agent continues to sync it but Fumadocs is the primary nav |
| `wiki-content/mkdocs.external.yml` | retain | Same as above |
| `docker-compose.yml` | modify | Update wikiapp build/environment if Fumadocs needs additional env vars or build steps |
| `config/wikiagent.yaml` | modify | Add `fumadocs_nav_root` and `page_type_templates` paths to wiki config section |

### Files to Delete (Deferred — After Full Migration)

| File Path | Reason |
|-----------|--------|
| `apps/web/components/docs/docs-sidebar.tsx` | Replaced by Fumadocs sidebar |
| `apps/web/components/docs/markdown-page.tsx` | Replaced by Fumadocs MDX renderer |

---

## Agent Code Changes

### 1. wiki-agent.ts — System Prompt Update

The current agent instructions are a single paragraph:

```
"You are Chronicler, the Kijko WikiAgent. Help maintain a technical wiki. Produce concise, high-signal markdown..."
```

Replace with the full system prompt from `wiki-generation-prompt.md`, or a summarized version that:

- References the 9 page types and their section templates
- Specifies Fumadocs MDX output format with component imports
- Includes the content generation rules (writing quality standards, cross-linking strategy)
- References the infographic generation workflow
- Instructs the agent to classify each page into a page type before generating

The prompt should be loaded from a file or config rather than hardcoded, so it can evolve independently.

### 2. wiki-tools.ts — Enhanced create-page Tool

Current tool accepts `wikiPageSchema` and writes `.md` files. Changes needed:

```
Input schema additions:
  - pageType: z.enum(["landing_overview", "quickstart_tutorial", "concept_explainer",
      "integration_guide", "connector_guide", "api_reference", "cookbook_recipe",
      "reference_spec", "migration_guide"]).optional()
  - sections: z.array(z.object({
      id: z.string(),
      content: z.string()
    })).optional()  // Structured section content for template-aware generation

Output changes:
  - Write .mdx instead of .md
  - Include Fumadocs component imports in frontmatter area
  - Call syncFumadocsNav() in addition to syncMkdocsNav()
```

New tools to add:

```
generate-infographic:
  - Input: repoName, infographicType (architecture|dependency|dataflow|concept|api-surface), sourceData
  - Calls NotebookLM MCP with the prompt patterns from notebooklm-infographic-spec.md
  - Saves output to wiki-content/docs/[repo]/infographics/
  - Returns the embed MDX snippet

classify-page-type:
  - Input: slug, content (markdown body), context (optional)
  - Output: pageType classification + recommended sections
  - Uses the page-type templates to classify existing content

validate-mdx:
  - Input: mdxContent
  - Output: { valid: boolean, errors: string[] }
  - Checks MDX syntax, component imports, frontmatter completeness

sync-navigation:
  - Input: none (reads from DB)
  - Output: updated meta.json file paths
  - Generates all meta.json files for Fumadocs sidebar
```

### 3. chat-engine.ts — Enhanced Page Generation

The `generatePage()` method currently builds a simple prompt and writes plain markdown. Changes:

**Before prompt construction:**
- Classify the target page into one of 9 page types (use heuristics on slug path: `concepts/*` -> concept_explainer, `cookbook/*` -> cookbook_recipe, etc.)
- Load the corresponding section template from `page-type-templates.json`
- Include template sections in the prompt so the agent structures output accordingly

**In prompt construction:**
- Add: page type, required sections, optional sections, Fumadocs component mapping
- Add: cross-linking context (list of existing pages for Next Steps cards)
- Add: infographic context if NotebookLM data is available

**After generation:**
- Post-process the generated MDX to inject component imports at the top
- Validate that required sections (hero, next_steps) are present
- Write as `.mdx` via the updated wiki-files module
- Trigger infographic generation if the page type requires it

### 4. wiki-files.ts — MDX and Fumadocs Nav Support

New functions:

```typescript
// Render Fumadocs-compatible MDX frontmatter + component imports
function renderMdxPage(page: WikiPage): string {
  // Frontmatter: title, description, icon, full_width
  // Component imports: based on page type from templates
  // Content body
}

// Generate meta.json sidebar navigation from page list
function syncFumadocsNav(paths: WikiPaths, pages: WikiPage[]): void {
  // Group pages by directory (concepts/, guides/, etc.)
  // Write root meta.json with section separators
  // Write per-section meta.json files
}

// Determine file extension based on content type
function pageFilePath(paths: WikiPaths, slug: string): string {
  // Returns .mdx path (with fallback check for .md during migration)
}
```

### 5. New Module: apps/agent/src/lib/page-type-classifier.ts

```typescript
// Classifies a page into one of 9 types based on:
// - Slug path (concepts/* -> concept_explainer)
// - Content analysis (has Steps -> quickstart_tutorial)
// - Explicit metadata (page.metadata.custom.pageType)
// Returns: { pageType: string, confidence: number, suggestedSections: Section[] }
```

### 6. New Module: apps/agent/src/lib/infographic-generator.ts

```typescript
// Wraps NotebookLM MCP calls for infographic generation
// - Assembles source data from CodeGraph/CGC outputs
// - Fills prompt patterns from notebooklm-infographic-spec.md
// - Calls NotebookLM with detail_level: "Detailed"
// - Saves output to wiki-content/docs/[repo]/infographics/
// - Returns MDX embed snippet
```

---

## Web App Changes

### 1. next.config.ts — MDX Support

```typescript
import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX();

const nextConfig: NextConfig = {
  typedRoutes: true,
  // Any other existing config
};

export default withMDX(nextConfig);
```

### 2. source.config.ts — Content Source Definition

```typescript
import { defineDocs, defineConfig } from 'fumadocs-mdx/config';

export const { docs, meta } = defineDocs({
  dir: '../../wiki-content/docs',  // Relative from apps/web
});

export default defineConfig();
```

### 3. app/source.ts — Source Loader

```typescript
import { docs, meta } from '@/../source.config';
import { loader } from 'fumadocs-core/source';

export const source = loader({
  baseUrl: '/docs',
  source: { ...docs, ...meta },
});
```

### 4. app/layout.tsx — Root Provider

```typescript
import { RootProvider } from 'fumadocs-ui/provider';
import 'fumadocs-ui/style.css';
import './globals.css';  // Kijko brand overrides AFTER fumadocs base

export default function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <RootProvider>{children}</RootProvider>
      </body>
    </html>
  );
}
```

### 5. app/docs/layout.tsx — Docs Layout with Sidebar

```typescript
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { source } from '../source';

export default function Layout({ children }) {
  return (
    <DocsLayout
      tree={source.pageTree}
      nav={{ title: 'Kijko Docs' }}
      sidebar={{ defaultOpen: true }}
    >
      {children}
    </DocsLayout>
  );
}
```

### 6. app/docs/[[...slug]]/page.tsx — Docs Page

```typescript
import { source } from '../../source';
import defaultMdxComponents from 'fumadocs-ui/mdx';
import { DocsPage, DocsBody, DocsDescription, DocsTitle } from 'fumadocs-ui/page';
import { notFound } from 'next/navigation';
// Custom components
import { FeedbackWidget } from '@/components/mdx/feedback-widget';
import { EditPageLink } from '@/components/mdx/edit-page-link';

export default async function Page({ params }) {
  const page = source.getPage(params.slug);
  if (!page) notFound();

  const MDX = page.data.body;

  return (
    <DocsPage toc={page.data.toc}>
      <DocsTitle>{page.data.title}</DocsTitle>
      <DocsDescription>{page.data.description}</DocsDescription>
      <DocsBody>
        <MDX components={{ ...defaultMdxComponents }} />
      </DocsBody>
      <EditPageLink slug={page.slugs} />
      <FeedbackWidget />
    </DocsPage>
  );
}

export function generateStaticParams() {
  return source.generateParams();
}

export function generateMetadata({ params }) {
  const page = source.getPage(params.slug);
  if (!page) return {};
  return { title: page.data.title, description: page.data.description };
}
```

### 7. globals.css — Style Integration Strategy

The existing CSS uses a parchment/editorial design with Georgia serif typography. The new template system specifies Inter sans-serif + JetBrains Mono. Strategy:

**Phase 1 (Coexistence):**
- Import `fumadocs-ui/style.css` in layout.tsx
- Keep existing globals.css for the landing page (`/`) and chat page (`/chat`)
- Fumadocs provides its own dark/light mode via `RootProvider`
- Override Fumadocs CSS variables to match Kijko brand where needed:

```css
:root {
  --fd-primary: #0d5c63;         /* Map Kijko accent to Fumadocs primary */
  --fd-background: #ece4d7;      /* Kijko parchment */
  --fd-foreground: #1d1b16;      /* Kijko ink */
  /* ... other overrides */
}
```

**Phase 2 (Full Migration):**
- Adopt Fumadocs Inter/JetBrains Mono typography for docs pages
- Keep Georgia serif for landing page only (brand differentiation)
- Remove all `.docs-body`, `.docs-sidebar`, `.docs-article`, `.docs-toc` classes (replaced by Fumadocs)
- Retain `.docs-landing`, `.docs-hero`, `.docs-card`, `.docs-grid` for the landing page

### 8. Component Mapping

| Template Component | Fumadocs Import | Custom Wrapper Needed? |
|-------------------|-----------------|----------------------|
| Card / CardGroup | `Card, Cards` from `fumadocs-ui/components/card` | No |
| Callout / Note / Warning / Tip | `Callout` from `fumadocs-ui/components/callout` | No |
| Steps / Step | `Step, Steps` from `fumadocs-ui/components/steps` | No |
| Tabs / Tab (code groups) | `Tab, Tabs` from `fumadocs-ui/components/tabs` | No |
| Accordion / Accordions | `Accordion, Accordions` from `fumadocs-ui/components/accordion` | No |
| TypeTable (params/fields) | `TypeTable` from `fumadocs-ui/components/type-table` | No |
| ImageZoom (screenshots) | `ImageZoom` from `fumadocs-ui/components/image-zoom` | No |
| API Playground | `APIPage` from `fumadocs-openapi` | Config needed |
| Feedback Widget | N/A | **Yes** — custom `FeedbackWidget` component |
| Edit Page Link | N/A | **Yes** — custom `EditPageLink` component |
| Mermaid Diagrams | N/A | **Yes** — custom `MermaidDiagram` component or rehype plugin |
| Infographic Embed | `ImageZoom` wrapper | **Yes** — custom `InfographicEmbed` with caption + dark-mode handling |

---

## Content Migration Plan

### Migration Strategy

Convert existing 7 `.md` files to `.mdx` format. This is a one-time migration with a clear process.

### Per-File Migration Steps

For each file in `wiki-content/docs/`:

1. **Rename**: `.md` -> `.mdx`
2. **Frontmatter**: Add `icon` field; ensure `title` and `description` are present; add `pageType` field
3. **Component imports**: Add Fumadocs component imports at the top of the file (after frontmatter)
4. **Content conversion**:
   - Bullet lists with bold leads -> stay as markdown (Fumadocs renders these natively)
   - Code blocks -> wrap in `<Tabs>` where multiple languages apply
   - Blockquotes used as callouts -> convert to `<Callout type="info">`
   - Mermaid fenced blocks -> convert to inline Mermaid component or keep as fenced (with rehype-mermaid plugin)
   - Cross-page links -> update hrefs to use Fumadocs slug format
   - Add `<Cards>` at bottom for Next Steps section
5. **Navigation**: Create `meta.json` in each directory

### Migration Example: index.md -> index.mdx

**Before** (current index.md frontmatter):
```yaml
---
title: Kijko Docs
description: Source-controlled documentation for the Kijko WikiAgent workspace
tags:
  - wikiagent
  - docs
audience: both
---
```

**After** (index.mdx):
```mdx
---
title: Kijko Docs
description: Source-controlled documentation for the Kijko WikiAgent workspace
icon: Book
---

import { Card, Cards } from 'fumadocs-ui/components/card'
import { Callout } from 'fumadocs-ui/components/callout'

# Kijko Docs

Kijko Docs is the committed markdown surface for the brownfield WikiAgent workspace...

## At a Glance

<Cards>
  <Card title="Getting Started" icon="Rocket" href="/docs/getting-started">
    Routes, local commands, and the verification loop
  </Card>
  <Card title="Frontend Surface" icon="Monitor" href="/docs/kijko-frontend">
    Next.js routes and the browser boundary
  </Card>
  {/* ... more cards ... */}
</Cards>

{/* ... rest of content ... */}

## Next Steps

<Cards>
  <Card title="Getting Started" icon="Rocket" href="/docs/getting-started">
    Open the docs surface and run local checks
  </Card>
  <Card title="Architecture" icon="Layers" href="/docs/concepts/architecture">
    Understand the system architecture
  </Card>
</Cards>
```

### Root meta.json Structure

```json
{
  "title": "Kijko Docs",
  "pages": [
    "index",
    "getting-started",
    "---Concepts---",
    "concepts/...",
    "---Guides---",
    "kijko-frontend",
    "---Vocabulary---",
    "panopticon",
    "panopticon-2-0",
    "hypervisa-3-0",
    "baton-exchange"
  ]
}
```

### Directory Structure After Migration

```
wiki-content/
  docs/
    meta.json                     # Root nav
    index.mdx                     # Landing (Type 1)
    getting-started.mdx           # Quickstart (Type 2)
    kijko-frontend.mdx            # Surface boundary (Type 3/4)
    panopticon.mdx                # Concept (Type 3)
    panopticon-2-0.mdx            # Concept (Type 3)
    hypervisa-3-0.mdx             # Concept (Type 3)
    baton-exchange.mdx            # Protocol reference (Type 8)
    concepts/
      meta.json
      architecture.mdx            # NEW — generated by agent
    guides/
      meta.json
    integrations/
      meta.json
    cookbook/
      meta.json
    reference/
      meta.json
    api-reference/
      meta.json
    migration/
      meta.json
    [repo-name]/                  # Per-repo wiki content (generated)
      infographics/
        architecture-overview.png
        dependency-graph.png
      index.mdx
      concepts/
      ...
  style-system.json               # Retained and extended
  mkdocs.internal.yml             # Retained for backward compat
  mkdocs.external.yml             # Retained for backward compat
```

---

## NotebookLM Workflow Integration

### Where It Hooks In

The NotebookLM infographic workflow integrates at two points:

**1. Agent Pipeline — Phase 4 (Infographics)**

After the WikiAgent generates content pages (Phase 3), it triggers infographic generation:

```
chat-engine.ts handleTurn()
  -> classifies intent as "page_create" or "rebuild"
  -> calls generatePage() for content
  -> NEW: calls generateInfographics() for visual assets
     -> infographic-generator.ts
        -> Assembles source data (CodeGraph, CGC outputs)
        -> Fills prompt patterns from notebooklm-infographic-spec.md
        -> Calls NotebookLM MCP via notebook-client.ts
        -> Saves PNG/SVG to wiki-content/docs/[repo]/infographics/
        -> Returns ImageZoom MDX embed snippets
  -> Injects infographic embeds into generated MDX pages
```

**2. Agent Tool — generate-infographic**

Exposed as a Mastra tool so the agent can be instructed to generate infographics via chat:

```
User: "Generate an architecture diagram for the auth service"
Agent: -> calls generate-infographic tool
       -> NotebookLM MCP produces the image
       -> Agent embeds it in the target page
```

### Integration with Existing notebook-client.ts

The existing `OpenNotebookClient` in `apps/agent/src/lib/notebook-client.ts` already handles health checks and search. Extend it with:

```typescript
async generateInfographic(params: {
  repoName: string;
  type: 'architecture' | 'dependency' | 'dataflow' | 'concept' | 'api-surface';
  sourceData: string;
  detailLevel?: 'Overview' | 'Detailed';
  outputFormat?: 'png' | 'svg';
  dimensions?: { width: number; height: number };
}): Promise<{ imagePath: string; embedMdx: string }>
```

### Infographic File Organization

Per the spec, infographics are stored at:
```
wiki-content/docs/[repo-name]/infographics/
  architecture-overview.png
  dependency-graph.png
  data-flow.png
  api-surface-map.png
  concept-[name].png
```

---

## Template Merge Strategy: page-type-templates.json vs style-system.json

### Recommendation: Extend, Don't Replace

The two files serve different purposes and should coexist:

| Aspect | style-system.json (Existing) | page-type-templates.json (New) |
|--------|------------------------------|-------------------------------|
| Scope | Information architecture, personas, journey stages, design system tokens, template library, marketplace | Page-type definitions, section templates, Fumadocs component mapping, design tokens |
| Used by | `apps/web/lib/docs.ts`, `docs-landing.tsx` | WikiAgent generation prompt, MDX writer |
| Authority | IA decisions, journey-led navigation | Content structure, component selection |

**Merge plan:**

1. **Design tokens**: Import the new `design_tokens` from `page-type-templates.json` into `style-system.json` under a new `fumadocsDesignTokens` key. The existing `designSystem` section stays for the landing page; the new tokens drive Fumadocs CSS variables.

2. **Template library**: Replace the existing `templateLibrary` array in `style-system.json` with a reference to the 9 page types. The old templates (overview, getting-started, concept, protocol, etc.) map to the new system:
   - `overview` -> `landing_overview`
   - `getting-started` -> `quickstart_tutorial`
   - `concept` -> `concept_explainer`
   - `protocol` -> `reference_spec`
   - `frontend-boundary` -> `concept_explainer` (with custom sections)
   - `architecture-diagram`, `sequence-diagram` -> embedded in `concept_explainer` via infographics
   - `screenshot-walkthrough`, `video-walkthrough` -> embedded in `cookbook_recipe`

3. **Component mappings**: The existing `componentMappings.platforms` section gets a `fumadocs` entry pulled from `fumadocs_component_mapping` in the new templates.

4. **No breaking change**: The landing page still reads `style-system.json` for IA variant, personas, journey stages. Those are untouched.

---

## Build and Deploy Changes

### docker-compose.yml

Minimal changes needed:

```yaml
wikiapp:
  environment:
    # NEW: Fumadocs needs to know where content lives at build time
    DOCS_CONTENT_DIR: /app/wiki-content/docs
    # Existing vars unchanged
```

The Fumadocs MDX compilation happens at **build time** (via `createMDX()` in next.config), so the Docker build step for `wikiapp` must have access to `wiki-content/docs/`. This is already the case since the monorepo is built as a single image.

### Build Script Changes

The `apps/web/package.json` scripts are unchanged (`next dev`, `next build`). The `createMDX()` wrapper handles MDX compilation automatically.

However, if the content directory is outside the Next.js app root (which it is -- `wiki-content/` is at the monorepo root), the `source.config.ts` must use a relative path that resolves correctly both in dev and in the Docker build context.

**Verification needed**: Confirm that `fumadocs-mdx` supports content directories outside the Next.js app root. If not, a symlink or content copy step will be needed in the build.

### CI/CD Additions

```
1. MDX validation step: Run `fumadocs-mdx` compilation check before deploy
2. Link check: Verify all cross-page links in MDX files resolve to valid slugs
3. Infographic asset check: Verify all ImageZoom src paths reference existing files
```

### MkDocs Backward Compatibility

During migration, both MkDocs YAML configs and Fumadocs meta.json are synced. The MkDocs static site can be built from the same content directory if needed, but the `.mdx` extension will require MkDocs to be configured with an MDX plugin or the files to be pre-processed. **Recommendation**: Keep MkDocs as a degraded fallback (it renders the markdown content without JSX components) and plan to retire it once Fumadocs is the sole production surface.

---

## Risk Assessment

### High Risk

| Risk | Impact | Mitigation |
|------|--------|------------|
| **Content directory outside Next.js root** | fumadocs-mdx may fail to resolve `../../wiki-content/docs` | Test early; prepare symlink fallback or monorepo workspace alias |
| **MDX compilation errors** | Existing markdown with JSX-like syntax (angle brackets in prose, curly braces in code) will break MDX parser | Pre-scan all .md files for MDX-unsafe characters; escape or wrap in code blocks |
| **Fumadocs version pinning** | Fumadocs is actively developed; breaking changes between versions | Pin exact versions in package.json; test upgrade path before adopting |
| **Agent output quality** | Agent may generate invalid MDX (unclosed tags, wrong component names) | Add `validate-mdx` tool; post-process all agent output before writing |

### Medium Risk

| Risk | Impact | Mitigation |
|------|--------|------------|
| **Landing page regression** | DocsLanding component depends on `lib/docs.ts` which is being modified | Keep `loadDocsStyleSystem()` and catalog helpers intact; test landing page independently |
| **CopilotKit compatibility** | CopilotKit wraps the root layout; Fumadocs RootProvider also wraps root | Test nesting order; CopilotKit should wrap outside Fumadocs or vice versa |
| **Dark mode conflicts** | Existing CSS uses `data-theme="dark"`; Fumadocs uses its own theme system | Ensure Fumadocs theme provider is the single source of truth; migrate existing dark mode CSS to Fumadocs variables |
| **Search migration** | Existing sidebar search is client-side text match; Fumadocs has built-in search | Fumadocs search is better but needs configuration; test with existing content volume |

### Low Risk

| Risk | Impact | Mitigation |
|------|--------|------------|
| **MkDocs nav desync** | MkDocs configs may drift from Fumadocs meta.json | Agent syncs both; acceptable during transition |
| **Font loading** | Adding Inter + JetBrains Mono increases page weight | Use Next.js `next/font` for optimized loading; already a solved pattern |
| **Infographic storage** | PNG files increase repo size | Use `.gitattributes` LFS for `*.png` in infographics directories; or serve from external storage |

### Rollback Strategy

1. **Content is reversible**: `.mdx` files can be renamed back to `.md` (strip component imports manually or via script)
2. **Git-backed**: All changes are committed; `git revert` restores previous state
3. **Feature flag approach**: The new `[[...slug]]` route can coexist with the old `[...slug]` route during transition. Use a `FUMADOCS_ENABLED` env var to toggle between old and new rendering paths.
4. **Parallel surfaces**: Keep MkDocs configs synced so MkDocs can serve as fallback if Fumadocs has issues in production.

---

## Implementation Order

The following sequence respects dependency chains. Steps within a phase can be parallelized.

### Phase 0: Foundation (No User-Visible Changes)

1. **Install Fumadocs packages** in `apps/web/package.json`
2. **Create `source.config.ts`** and **`app/source.ts`** with content directory pointing at `wiki-content/docs`
3. **Update `next.config.ts`** with `createMDX()` wrapper
4. **Verify build** — confirm Fumadocs can find and compile existing `.md` files (fumadocs-mdx may handle plain `.md` as well)
5. **Add `pageType` field** to `wikiPageSchema` in `packages/shared/src/models.ts`

### Phase 1: Web App Shell (Fumadocs Layout Active)

6. **Create `app/docs/layout.tsx`** with `DocsLayout`
7. **Create `app/docs/[[...slug]]/page.tsx`** with Fumadocs page renderer
8. **Update `app/layout.tsx`** with `RootProvider` and Fumadocs CSS import
9. **Create `components/mdx/index.tsx`** with component overrides
10. **Update `globals.css`** — add Fumadocs CSS variable overrides for Kijko brand
11. **Test**: Existing `.md` content renders through Fumadocs (even without MDX components)

### Phase 2: Content Migration (7 Files)

12. **Create `wiki-content/docs/meta.json`** — root navigation
13. **Convert each `.md` to `.mdx`** one file at a time, starting with `index.md`
14. **Add Fumadocs components** to converted pages (Cards for Next Steps, Callouts for tips)
15. **Delete old route**: Remove `app/docs/[...slug]/page.tsx`
16. **Update `app/docs/page.tsx`** to redirect to catch-all or remove (Fumadocs handles index)
17. **Test**: All 7 pages render correctly with sidebar nav, TOC, breadcrumbs, and search

### Phase 3: Agent Integration

18. **Create `apps/agent/src/lib/fumadocs-nav.ts`** — meta.json sync module
19. **Create `apps/agent/src/lib/mdx-writer.ts`** — MDX output writer
20. **Update `wiki-tools.ts`** — write `.mdx`, sync meta.json
21. **Update `wiki-files.ts`** — add MDX rendering functions alongside existing MD functions
22. **Update `wiki-agent.ts`** — load enhanced system prompt with page-type templates
23. **Update `chat-engine.ts`** — add page-type classification and template-aware generation
24. **Test**: Chat command "Create a page for authentication" produces valid Fumadocs MDX

### Phase 4: NotebookLM Infographics

25. **Create `apps/agent/src/lib/infographic-generator.ts`**
26. **Extend `notebook-client.ts`** with `generateInfographic()` method
27. **Add `generate-infographic` tool** to wiki-tools.ts
28. **Test**: Infographic generation via chat command produces PNG and embeds in MDX page

### Phase 5: Style System Merge and Custom Components

29. **Merge design tokens** from `page-type-templates.json` into `style-system.json`
30. **Create custom MDX components**: FeedbackWidget, EditPageLink, MermaidDiagram, InfographicEmbed
31. **Update `components/mdx/index.tsx`** to register custom components
32. **Update landing page** (`docs-landing.tsx`) to reference Fumadocs page list instead of hardcoded catalog
33. **Retire `lib/docs.ts`** rendering functions (keep style system and catalog helpers)
34. **Update `sitemap.ts`** to use Fumadocs source

### Phase 6: API Reference and OpenAPI

35. **Create `config/docs-api.openapi.yaml`** if not present
36. **Create `app/api-reference/[[...slug]]/page.tsx`** with fumadocs-openapi
37. **Configure fumadocs-openapi** to generate from the OpenAPI spec
38. **Test**: API reference pages render with interactive playground

### Phase 7: Cleanup and Production Hardening

39. **Delete deprecated files**: `docs-sidebar.tsx`, `markdown-page.tsx`
40. **Remove dead code** from `lib/docs.ts` (keep only what landing page needs)
41. **Update `docker-compose.yml`** if any env var changes are needed
42. **Update `config/wikiagent.yaml`** with Fumadocs-specific paths
43. **CI/CD**: Add MDX validation, link checking, and infographic asset verification steps
44. **Documentation**: Update `getting-started.mdx` to reflect the new Fumadocs-based workflow
45. **Performance test**: Verify build times, bundle size, and page load with Fumadocs

---

## Phase 8: Wiki Knowledge API (knowledge-mcp Integration)

> Added 2026-03-28. See full spec: `conductor/tracks/wiki_knowledge_api_20260328/spec.md`

46. **Clone knowledge-mcp** into `deploy/knowledge-mcp/` (pin to v0.4.2+)
47. **Create Kijko config.yaml** for knowledge-mcp (proxy to :4141, text-embedding-3-large, base_dir)
48. **Add Docker Compose service** `knowledge-mcp` with persistent KB volume and health check
49. **Create `apps/agent/src/lib/knowledge-client.ts`** — TypeScript client (createKB, ingestPage, query, answer)
50. **Add 3 agent tools**: `query-wiki`, `search-wiki`, `list-wikis` in wiki-tools.ts
51. **Wire ingestion pipeline**: after Phase 6 (Publish), auto-create KB + ingest all pages
52. **Add REST API endpoints**: `/api/wiki-knowledge/answer`, `/api/wiki-knowledge/retrieve`, `/api/wiki-knowledge/kbs`
53. **Add MCP server config** for Claude Code and IDE agents
54. **Integrate self-query**: WikiAgent queries existing KB during content generation for consistency
55. **Test**: Full cycle — generate wiki → ingest → query → verify accurate answers with citations

### Docker Compose Addition

```yaml
knowledge-mcp:
  build:
    context: ./deploy/knowledge-mcp
    dockerfile: Dockerfile
  container_name: knowledge-mcp
  restart: unless-stopped
  volumes:
    - knowledge_data:/app/kbs
    - ./wiki-content/docs:/app/wiki-source:ro
  environment:
    - OPENAI_API_KEY=dummy
    - OPENAI_API_BASE=http://host.docker.internal:4141/v1
  healthcheck:
    test: ["CMD", "python", "-c", "import knowledge_mcp; print('ok')"]
    interval: 30s
    timeout: 10s
    retries: 3
  depends_on:
    - wikiapp
```

### Architecture Impact

```
                    Before                              After
                    ======                              =====
Wiki pages → static MDX files          Wiki pages → static MDX + Knowledge Graph
Agents → read files only               Agents → query via MCP (answer/retrieve/query_*)
No cross-page intelligence             Entity/relationship graph across all pages
No citation-backed answers             LLM-synthesized answers with page citations
```

---

## Summary of Key Decisions

1. **Extend, don't replace** `style-system.json` — merge new design tokens alongside existing IA config
2. **Parallel nav sync** — agent writes both `meta.json` (Fumadocs) and `mkdocs.*.yml` (backward compat) during transition
3. **Page type classification** — add as a first-class field in the shared schema, not just agent-side metadata
4. **MDX validation** — add as an agent tool to catch generation errors before they reach the web surface
5. **Phased rollout** — web shell first (Phase 1), then content migration (Phase 2), then agent integration (Phase 3), so each layer can be tested independently
6. **Feature flag** — use `FUMADOCS_ENABLED` env var during transition to toggle between old and new rendering
7. **Infographic storage** — PNG files in the repo during development; evaluate LFS or external storage for production scale
8. **knowledge-mcp as KB layer** — each wiki gets its own LightRAG knowledge base; agents query via MCP tools or REST API; LLM/embedding calls route through local proxy (:4141)
