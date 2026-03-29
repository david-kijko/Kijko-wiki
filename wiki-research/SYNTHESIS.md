# Wiki Tab Build-Out — Consolidated Synthesis

> Date: 2026-03-28
> Pipeline: uncommon-sense selective-parallel (4 agent teams)
> Source: SuperMemory docs (supermemory.ai/docs) — 136 pages, 13 sections, built with Mintlify
> Target: Kijko WikiAgent with Fumadocs + NotebookLM infographics

---

## Executive Summary

We reverse-engineered the SuperMemory documentation site to extract a complete wiki template system for the Kijko WikiAgent. The deliverables are:

1. **37 full-page screenshots** + markdown captures spanning all page types
2. **Complete site tree** (136 URLs, 13 sections)
3. **9-type page template system** with Mintlify-to-Fumadocs component mapping
4. **Multi-section generation prompt** for autonomous wiki creation
5. **NotebookLM infographic generation spec** (5 infographic types per wiki)
6. **4 team analysis reports** (gap analysis, prompt stress-test, integration spec, visual fidelity audit)

### Key Findings

| Area | Score | Critical Issue |
|------|-------|----------------|
| Template Coverage | 89% | 3 missing page types needed (Feature Guide, Deployment Guide, Changelog) |
| Prompt/Code Compatibility | LOW | Prompt describes a 6-phase pipeline; current agent is a single-pass `.md` writer |
| Visual Fidelity | 7.5/10 | Accent color is blue (#2563eb), not purple (#7c3aed); header/nav entirely undocumented |
| Integration Complexity | HIGH | 20 new files, 18 file modifications, 7 file migrations, 2 deletions |

---

## Artifact Index

```
docs/wiki-research/
├── SYNTHESIS.md                          ← THIS FILE (consolidated synthesis)
├── sitemap.json                          ← Full 136-URL site tree
├── crawl_manifest.json                   ← Metadata for all 37 crawled pages
├── screenshots/                          ← 37 full-page PNG screenshots
│   ├── intro.png                         (Landing/Overview)
│   ├── quickstart.png                    (Quickstart)
│   ├── concepts_*.png                    (7 concept pages)
│   ├── integrations_*.png               (5 integration pages)
│   ├── connectors_*.png                  (3 connector pages)
│   ├── cookbook_*.png                     (2 cookbook pages)
│   ├── api-reference_*.png              (3 API reference pages)
│   ├── memorybench_*.png                 (2 MemoryBench pages)
│   └── [10 more pages...]
├── pages/                                ← 37 markdown content captures
│   └── [slug].md                         (one per crawled page)
└── analysis/
    ├── site-structure.md                 ← Complete site tree with section taxonomy
    ├── page-type-templates.json          ← 9-type template system + design tokens
    ├── wiki-generation-prompt.md         ← Multi-section generation prompt
    ├── notebooklm-infographic-spec.md    ← Infographic generation spec
    ├── gap-report.md                     ← Team 1: Template gap analysis (346 lines)
    ├── prompt-stress-test.md             ← Team 2: Prompt validation (458 lines)
    ├── integration-spec.md               ← Team 3: File-by-file integration plan (831 lines)
    └── visual-fidelity-report.md         ← Team 4: Design token audit (860 lines)
```

---

## Priority Action Items (Synthesized from all 4 teams)

### P0 — Blockers (Must fix before wiki generation can work)

1. **Create 10th page type: "Feature / Operations Guide"** (Team 1)
   - 5+ root-level SuperMemory pages (authentication, add-memories, search, etc.) don't fit existing templates
   - Pattern: Quick Start code → Parameters table → Operational sections with code → Accordion advanced details

2. **Resolve MkDocs → Fumadocs transition** (Teams 2 & 3)
   - Current agent writes `.md` + syncs MkDocs YAML; prompt requires `.mdx` + `meta.json`
   - Create `apps/agent/src/lib/mdx-writer.ts` and `apps/agent/src/lib/fumadocs-nav.ts`
   - Keep MkDocs sync for backward compatibility during transition

3. **Update agent system instructions** (Team 2)
   - Current: 4 hardcoded section names ("Overview, Architecture, Key Components, Sources")
   - Target: Load from prompt file, reference 9+ page types with per-type section templates
   - Fix C2 contradiction: section names in agent vs prompt

4. **Fix accent color in design tokens** (Team 4)
   - Links are **blue** (#2563eb), NOT purple (#7c3aed)
   - Add separate `link_color` and `brand_accent` tokens

5. **Expose docs-pipeline QA tools to agent** (Team 2)
   - `runDocsQualityChecks()` and `getDocsDiscoveryReport()` exist in docs-pipeline.ts
   - None are callable from wiki-tools.ts — the agent has 3 tools but the pipeline has 10+ capabilities

### P1 — High Priority (Incorrect output without these)

6. **Fix template section patterns** (Team 1)
   - `landing_overview.at_a_glance`: Allow bullet lists AND CardGroup (not just cards)
   - `quickstart_tutorial.steps`: Allow bold-inline numbering as alternative to Steps component
   - `concept_explainer.mental_model`: Change from `required: true` to `required: false`
   - `concept_explainer.comparison`: Support 3-tab scenario comparisons, not just 2-column

7. **Add API Reference two-column layout token** (Teams 1 & 4)
   - Left panel (60%): parameter docs + descriptions
   - Right panel (40%): dark code example block
   - Must be handled by `fumadocs-openapi` extension, not hand-built

8. **Add header/nav bar design tokens** (Team 4)
   - 60px sticky header with logo, search (Cmd+K), "Ask AI" button, CTA button
   - Section tab bar below header (7 tabs with icons, active underline indicator)
   - Both are entirely undocumented in current template system

9. **Add 3 new agent tools** (Team 3)
   - `classify-page-type`: Determines which template to apply
   - `generate-infographic`: Calls NotebookLM MCP with prompt patterns
   - `validate-mdx`: Checks MDX syntax and component imports

### P2 — Medium Priority (Polish & completeness)

10. **Resolve style-system.json conflicts** (Team 2)
    - Journey-led IA (style-system) vs taxonomy-led IA (new prompt) — fundamental conflict
    - Typography: Georgia (style-system) vs Inter (new prompt)
    - Palette: Teal (style-system) vs purple/blue (new prompt)
    - Decision needed: new templates supersede style-system for Fumadocs output

11. **Add missing Mintlify→Fumadocs component mappings** (Team 1)
    - Mermaid diagrams, HTTP method badges, "Show child attributes" toggle
    - "Coming Soon" disabled cards, pricing tables, platform/OS tabs
    - Plan-gated callouts across all templates (not just connectors)

12. **Add cross-link backfill strategy to prompt** (Team 2)
    - Pages generated early can't link to not-yet-created pages
    - Need a two-pass approach: generate all → backfill cross-links

13. **Add degradation strategies to prompt** (Team 2)
    - What happens when CodeGraph/NotebookLM/Repomix is unavailable?
    - Fallback rules for each tool in the pipeline

14. **Document footer structure** (Team 4)
    - Previous/Next navigation, social icons, "Powered by" branding, feedback widget

### P3 — Low Priority

15. Add Changelog and Deployment Guide page types
16. Add content length limits and SEO description validation to prompt
17. Define Lucide icon mapping table for frontmatter `icon` field
18. Handle single-language repos (skip Python tabs for TS-only codebases)

---

## Integration Implementation Order (from Team 3)

```
Phase 1: Foundation (no content changes)
  1. Install Fumadocs packages in apps/web
  2. Create source.config.ts and app/source.ts
  3. Create Fumadocs docs layout (app/docs/layout.tsx)
  4. Create catch-all docs page (app/docs/[[...slug]]/page.tsx)
  5. Create MDX component overrides (components/mdx/index.tsx)
  6. Verify existing .md pages render through Fumadocs (with minimal formatting)

Phase 2: Agent Output Migration
  7. Create mdx-writer.ts in apps/agent
  8. Create fumadocs-nav.ts in apps/agent
  9. Update wiki-tools.ts create-page tool for .mdx output
  10. Add page_type field to WikiPage schema
  11. Update agent system instructions with generation prompt
  12. Add new tools (classify-page-type, validate-mdx)

Phase 3: Content Migration
  13. Convert existing wiki-content/docs/*.md → .mdx
  14. Create meta.json navigation configs per section
  15. Delete deprecated components (docs-sidebar, markdown-page)
  16. Retire custom markdown rendering pipeline

Phase 4: Infographics & Polish
  17. Integrate NotebookLM MCP for infographic generation
  18. Add generate-infographic agent tool
  19. Add feedback widget, edit-page link, header/nav components
  20. Configure fumadocs-openapi for API reference pages

Phase 5: QA & Deploy
  21. Expose docs-pipeline QA tools to agent
  22. Run full quality checks on generated content
  23. Update docker-compose.yml and CI/CD
  24. Deploy updated system
```

---

## Open Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Fumadocs MDX requires different build config than current Next.js setup | HIGH | Test incrementally; keep MkDocs fallback |
| NotebookLM MCP infographic generation may not produce production-quality output | MEDIUM | Use Mermaid diagrams as fallback; manual review |
| Full wiki generation (40+ pages) requires 100+ LLM calls with no rate limit guidance | HIGH | Add rate limiting and idempotency rules to prompt |
| Style-system.json conflicts may surface during migration | LOW | New templates supersede style-system for Fumadocs; retain style-system for legacy MkDocs |
| Cross-link resolution requires two-pass generation | MEDIUM | Implement backfill phase in agent orchestration |

---

## Quality Gate Summary

| Criterion | Score | Notes |
|-----------|-------|-------|
| Template coverage of all page types | 2/3 | 89% — needs Feature Guide type |
| Prompt alignment with agent code | 1/3 | Major rebuild needed |
| Visual fidelity of design tokens | 2/3 | 7.5/10 — color and header gaps |
| Integration spec completeness | 3/3 | 831-line spec with file matrix |
| Infographic generation plan | 2/3 | Spec complete; NotebookLM capability unverified |
| Actionable priority list | 3/3 | 18 items ranked P0-P3 |

**Intent Fidelity Score: ~72%** — Above partial threshold (60%), below pass (85%).
Gaps are in tool availability (CodeGraph, Repomix, NotebookLM infographics not yet integrated)
and the fundamental MkDocs→Fumadocs transition that must happen before generation can work.

---

*Generated by /uncommon-sense pipeline, run ID: 20260328T152438Z*
