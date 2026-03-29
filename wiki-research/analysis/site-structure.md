# SuperMemory Docs — Complete Site Structure Analysis

> Source: https://supermemory.ai/docs | Built with: Mintlify | ~136 pages | 13 sections
> Crawled: 2026-03-28 via Firecrawl API + WebFetch analysis

## Site Tree (13 Sections)

### 1. Root / Getting Started (9 pages)
Top-level pages forming the onboarding funnel:
- `/intro` — Landing/overview (What is Supermemory?)
- `/quickstart` — First API call tutorial
- `/authentication` — API keys, scoped keys, branding
- `/add-memories` — Ingesting context (text, files, URLs)
- `/search` — Semantic search across memories
- `/memory-operations` — Advanced memory ops (v4 API)
- `/document-operations` — List, get, update, delete documents
- `/user-profiles` — Auto-maintained user context
- `/vibe-coding` — AI coding agent integration setup

### 2. Concepts (9 pages)
Deep conceptual explainers:
- `/concepts/how-it-works` — Knowledge graph architecture
- `/concepts/graph-memory` — Memory evolution, updates, forgetting
- `/concepts/memory-vs-rag` — Memory vs RAG comparison
- `/concepts/super-rag` — Managed RAG as a service
- `/concepts/content-types` — Supported content formats
- `/concepts/filtering` — Container tags, metadata organization
- `/concepts/customization` — Application-specific configuration
- `/concepts/user-profiles` — User context management

### 3. Integrations (20 pages)
Framework/platform integration guides:
- `/integrations/agent-framework` — Microsoft Agent Framework
- `/integrations/agno` — Agno agents
- `/integrations/ai-sdk` — Vercel AI SDK
- `/integrations/claude-code` — Claude Code plugin
- `/integrations/claude-memory` — Claude native memory tool
- `/integrations/crewai` — CrewAI agents
- `/integrations/langchain` — LangChain integration
- `/integrations/langgraph` — LangGraph agents
- `/integrations/mastra` — Mastra AI agents
- `/integrations/memory-graph` — Interactive visualization
- `/integrations/n8n` — n8n workflow automation
- `/integrations/openai` — OpenAI function calling
- `/integrations/openai-agents-sdk` — OpenAI Agents SDK
- `/integrations/openclaw` — Multi-platform messaging
- `/integrations/opencode` — OpenCode plugin
- `/integrations/pipecat` — Voice AI agents
- `/integrations/supermemory-sdk` — Official SDKs
- `/integrations/viasocket` — viaSocket automation
- `/integrations/zapier` — Zapier workflows

### 4. Connectors (9 pages)
Data source connectors:
- `/connectors/overview` — All connectors summary
- `/connectors/github` — GitHub repos
- `/connectors/gmail` — Gmail with Pub/Sub
- `/connectors/google-drive` — Google Drive
- `/connectors/notion` — Notion pages/databases
- `/connectors/onedrive` — OneDrive/Office
- `/connectors/s3` — S3/S3-compatible storage
- `/connectors/web-crawler` — Website crawling
- `/connectors/troubleshooting` — Common issues

### 5. Cookbook (7 pages)
Complete implementation recipes:
- `/cookbook/overview` — Recipe index
- `/cookbook/ai-sdk-integration` — Vercel AI SDK examples
- `/cookbook/customer-support` — Support bot build
- `/cookbook/document-qa` — Document Q&A with citations
- `/cookbook/personal-assistant` — Personal AI assistant
- `/cookbook/perplexity-supermemory` — Perplexity + memory
- `/cookbook/chat-with-gdrive` — Google Drive chat

### 6. API Reference (~38 pages)
OpenAPI-generated endpoint docs:
- `/api-reference/connections/*` (10 endpoints)
- `/api-reference/container-tags/*` (4 endpoints)
- `/api-reference/conversations/*` (1 endpoint)
- `/api-reference/graph/*` (3 endpoints)
- `/api-reference/manage-documents/*` (9 endpoints)
- `/api-reference/memories/*` (3 endpoints)
- `/api-reference/memories-v4/*` (1 endpoint)
- `/api-reference/organization-settings/*` (3 endpoints)
- `/api-reference/profile/*` (1 endpoint)
- `/api-reference/search/*` (2 endpoints)

### 7. MemoryBench (11 pages)
Benchmarking framework docs:
- `/memorybench/overview` — Framework intro
- `/memorybench/quickstart` — 3-step setup
- `/memorybench/installation` — Environment setup
- `/memorybench/architecture` — Design & implementation
- `/memorybench/cli` — CLI reference
- `/memorybench/memscore` — Composite metric
- `/memorybench/integrations` — Supported providers
- `/memorybench/extend-benchmark` — Custom benchmarks
- `/memorybench/extend-provider` — Custom providers
- `/memorybench/contributing` — Contribution guide
- `/memorybench/github` — GitHub link

### 8. Memory Router (3 pages)
- `/memory-router/overview`
- `/memory-router/usage`
- `/memory-router/with-memory-api`

### 9. Model Enhancement (3 pages)
- `/model-enhancement/getting-started`
- `/model-enhancement/context-extender`
- `/model-enhancement/identifying-users`

### 10. Supermemory MCP (4 pages)
- `/supermemory-mcp/introduction`
- `/supermemory-mcp/mcp` — MCP overview
- `/supermemory-mcp/setup` — Setup guide
- `/supermemory-mcp/technology` — Technical details

### 11. Memory API (legacy?) (7 pages)
- `/memory-api/introduction`
- `/memory-api/connectors/overview`
- `/memory-api/connectors/creating-connection`
- `/memory-api/connectors/google-drive`
- `/memory-api/connectors/managing-resources`
- `/memory-api/features/filtering`
- `/memory-api/features/query-rewriting`
- `/memory-api/sdks/python`
- `/memory-api/sdks/typescript`
- `/memory-api/sdks/anthropic-claude-memory`
- `/memory-api/searching/searching-memories`

### 12. Migration (2 pages)
- `/migration/from-mem0`
- `/migration/from-zep`

### 13. Changelog (1 page)
- `/changelog/overview`

---

## Page Type Taxonomy (9 Types Identified)

| Type | Count | Sections | Key Patterns |
|------|-------|----------|--------------|
| **Landing/Overview** | ~5 | Root, MemoryBench, Connectors | Hero + feature cards + CTA cards |
| **Quickstart/Tutorial** | ~4 | Root, MemoryBench | Numbered steps + code blocks + env setup |
| **Concept Explainer** | ~9 | Concepts | Mental model → definitions → mechanisms → next steps |
| **Integration Guide** | ~20 | Integrations | Install → configure → code example → verify |
| **Connector Guide** | ~8 | Connectors | Overview → setup → config → sync → troubleshoot |
| **API Reference** | ~38 | API Reference | Endpoint → params → request → response → errors |
| **Cookbook/Recipe** | ~7 | Cookbook | Prerequisites → dual-track build → test → troubleshoot |
| **Reference/Spec** | ~5 | MemoryBench, CLI | Formal spec format, tables, flags |
| **Migration Guide** | ~2 | Migration | Before/after comparison, step-by-step migration |

---

## Design System Patterns

### Layout
- **Single-column content** with sidebar navigation
- **Max-width container** (~780px content, ~280px sidebar)
- **Sticky sidebar** with collapsible section groups
- **Breadcrumb navigation** at top
- **On-page ToC** (right rail on wider screens)

### Components (Mintlify-native)
1. **CardGroup** — 2-column card grids for navigation/comparison
2. **Card** — Icon + title + description + link
3. **Callout** — Note, Warning, Tip, Info variants
4. **CodeGroup** — Tabbed code blocks (language switching)
5. **Accordion** — Collapsible content sections
6. **Tabs** — Content switching (e.g., Python/TypeScript)
7. **Steps** — Numbered step progression
8. **ResponseField** — API response field documentation
9. **ParamField** — API parameter documentation

### Typography
- **H1**: 32px bold, page title only
- **H2**: 24px semibold, major sections
- **H3**: 20px medium, subsections
- **Body**: 16px, 1.7 line-height, neutral gray
- **Code**: 14px monospace, dark background
- **Font**: Inter (body), JetBrains Mono (code)

### Color Scheme (Mintlify default + custom)
- **Background**: White (#fff) / Dark mode: Near-black (#0f1117)
- **Text**: Dark gray (#1a1a2e) / Dark mode: Light gray (#e0e0e0)
- **Primary accent**: Purple (#7c3aed) for links, hover states
- **Code background**: #1e1e2e (dark) / #f5f5f5 (light)
- **Callout colors**: Blue (info), Yellow (warning), Green (tip), Gray (note)
- **Card borders**: Subtle gray with hover elevation

### Content Patterns
1. **Progressive disclosure**: Overview → detail → code → action
2. **Dual-track tutorials**: Python AND TypeScript paths side-by-side
3. **Evidence-driven**: Diagrams and architecture visuals before code
4. **CTA closing**: Every page ends with 2 navigation cards
5. **Cross-linking**: Dense internal link network within prose
