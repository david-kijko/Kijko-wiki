---
url: https://supermemory.ai/docs/changelog/overview
title: Changelog - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/changelog/overview#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Changelog

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

FiltersClear

APIConsoleSDKMCPIntegrationsCLI

[​](https://supermemory.ai/docs/changelog/overview#march-18-2026)

March 18, 2026

APISDKConsoleCLI

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-cli)  Supermemory CLI

New command-line tool for managing memories, documents, profiles, tags, connectors, and API keys directly from the terminal.

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-v1-4-1)  `@supermemory/tools` v1.4.1

Now exposes raw `searchResults` in `MemoryPromptData`, giving full control over how retrieved memories are formatted in prompts.

### [​](https://supermemory.ai/docs/changelog/overview\#pptx-&-audio-ingestion)  PPTX & Audio Ingestion

PowerPoint files (`.pptx`) are now a supported content type. Audio files are automatically transcribed via Gemini 2.5 Flash, chunked, and indexed.

### [​](https://supermemory.ai/docs/changelog/overview\#multi-containertag-scoped-api-keys)  Multi-containerTag Scoped API Keys

Scoped API keys can now be assigned to multiple container tags — one key, multiple spaces.

### [​](https://supermemory.ai/docs/changelog/overview\#console-documents-page)  Console: Documents Page

New dedicated documents browser in the console for viewing, filtering, and managing all ingested content.

[​](https://supermemory.ai/docs/changelog/overview#march-9-2026)

March 9, 2026

APISDKMCPIntegrations

### [​](https://supermemory.ai/docs/changelog/overview\#delete-scoped-api-keys)  Delete Scoped API Keys

New `DELETE` endpoint to disable scoped API keys programmatically.

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-agent-framework-python-package)  `supermemory-agent-framework` Python Package

Official Python package for using Supermemory with Microsoft’s Agent Framework — memory tools and middleware out of the box.

### [​](https://supermemory.ai/docs/changelog/overview\#interactive-memory-graph-in-mcp)  Interactive Memory Graph in MCP

The MCP server now includes an interactive graph visualization app for exploring memory connections from any MCP-compatible client.

### [​](https://supermemory.ai/docs/changelog/overview\#more-integrations)  More Integrations

- **ViaSocket** — new integration guide for automation workflows.
- **Plugin Auth Connect Page** — OAuth-style connect page for Claude Code, OpenCode, and OpenClaw.
- **OpenAI SDK Backfill** — improved compatibility across TypeScript and Python SDKs.

### [​](https://supermemory.ai/docs/changelog/overview\#other)  Other

- **Retry failed documents** by re-submitting with the same `customId`.
- **Delete connection without documents** — disconnect a source without deleting synced content.
- **Org-level overage toggle** in billing settings.
- **Copyable team invite link** on the team management page.
- **`extends` relation type** in memory graph for richer knowledge graph connections.
- **Bulk delete** in the Nova app interface.

[​](https://supermemory.ai/docs/changelog/overview#march-2-2026)

March 2, 2026

API

### [​](https://supermemory.ai/docs/changelog/overview\#configurable-vector-stores)  Configurable Vector Stores

Bring your own vector store — Supermemory now supports pluggable vector backends beyond the default.

### [​](https://supermemory.ai/docs/changelog/overview\#list-memories-endpoint)  List Memories Endpoint

New `GET /v3/documents` endpoint with pagination, filtering by container tag, status, and metadata.

[​](https://supermemory.ai/docs/changelog/overview#february-26-2026)

February 26, 2026

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#self-hostable-supermemory)  Self-Hostable Supermemory

Run the full Supermemory stack on your own infrastructure with Docker.

### [​](https://supermemory.ai/docs/changelog/overview\#console-v2)  Console v2

Complete redesign of the developer console with new navigation, improved billing, and a unified project view that merges consumer and developer organizations.

### [​](https://supermemory.ai/docs/changelog/overview\#no-more-120-memory-limit)  No More 120 Memory Limit

The previous cap of 120 memories per container tag has been removed. Store unlimited memories.

[​](https://supermemory.ai/docs/changelog/overview#february-22-2026)

February 22, 2026

APISDKCLI

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-skill-for-claude-code)  Supermemory Skill for Claude Code

Install with `npx skills add supermemoryai/skills` — teaches Claude to proactively recommend and implement Supermemory when building AI apps. Includes TypeScript and Python examples.

### [​](https://supermemory.ai/docs/changelog/overview\#api-improvements)  API Improvements

- **Metadata filtering for profiles** — target profile queries by metadata fields.
- **List documents with multiple container tags** — new `operator` parameter.
- **Deprecate `include: chunks`** in `/v4/search` in favor of the `hybrid` search mode.
- **Content deduplication** in search results to reduce token usage.

[​](https://supermemory.ai/docs/changelog/overview#february-9-2026)

February 9, 2026

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#unified-organizations)  Unified Organizations

Consumer and developer organizations merged into a single org type. All orgs can now access both Nova and the developer API.

### [​](https://supermemory.ai/docs/changelog/overview\#credits-based-usage-display)  Credits-Based Usage Display

Billing now shows token usage in a credits-based format.

### [​](https://supermemory.ai/docs/changelog/overview\#nova-spaces-with-multi-select)  Nova Spaces with Multi-Select

Spaces in Nova support multi-select, replacing “All Spaces” with scoped “Nova Spaces.”

[​](https://supermemory.ai/docs/changelog/overview#february-6-2026)

February 6, 2026

API

### [​](https://supermemory.ai/docs/changelog/overview\#scoped-api-keys-for-container-tags)  Scoped API Keys for Container Tags

Create API keys scoped to specific container tags for fine-grained access control per space.

### [​](https://supermemory.ai/docs/changelog/overview\#delete-endpoint-for-container-tags)  DELETE Endpoint for Container Tags

New endpoint to delete container tags and their associated document relationships.

### [​](https://supermemory.ai/docs/changelog/overview\#container-tag-level-context-prompts)  Container Tag-Level Context Prompts

Set custom context prompts per container tag to control how memories are extracted and summarized within each space.

[​](https://supermemory.ai/docs/changelog/overview#february-3-2026)

February 3, 2026

IntegrationsSDK

### [​](https://supermemory.ai/docs/changelog/overview\#new-framework-integration-docs)  New Framework Integration Docs

Added guides for LangGraph, OpenAI Agents SDK, CrewAI, Agno, Mastra, LangChain, and Claude Code — covering all major AI agent frameworks.

### [​](https://supermemory.ai/docs/changelog/overview\#entity-context-&-authentication-docs)  Entity Context & Authentication Docs

New docs on entity extraction, context enrichment, and comprehensive authentication examples (API key, OAuth, scoped keys).

[​](https://supermemory.ai/docs/changelog/overview#january-25-2026)

January 25, 2026

APIConsoleSDK

### [​](https://supermemory.ai/docs/changelog/overview\#plugin-authentication-system)  Plugin Authentication System

New auth system for external tool integrations, enabling secure plugin-to-API connections. Dedicated plugin page with auth flows for Claude Code, OpenCode, and OpenClaw.

### [​](https://supermemory.ai/docs/changelog/overview\#enterprise-plan-support)  Enterprise Plan Support

Enterprise tier now available in the console.

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-%E2%80%94-strict-mode)  `@supermemory/tools` — Strict Mode

Strict mode support for OpenAI function calling, ensuring schema-validated tool calls.

[​](https://supermemory.ai/docs/changelog/overview#january-14-2026)

January 14, 2026

API

### [​](https://supermemory.ai/docs/changelog/overview\#hybrid-pdf-pipeline)  Hybrid PDF Pipeline

PDF extraction now uses Mistral OCR 3 with Gemini fallback for significantly improved accuracy on scanned documents and complex layouts.

### [​](https://supermemory.ai/docs/changelog/overview\#halfvec-embeddings)  Halfvec Embeddings

Embedding storage optimized with half-precision vectors, reducing storage costs while maintaining search quality.

### [​](https://supermemory.ai/docs/changelog/overview\#spaces-creation-with-emoji)  Spaces Creation with Emoji

Create and customize spaces with emoji identifiers in Nova.

[​](https://supermemory.ai/docs/changelog/overview#january-8-2026)

January 8, 2026

APISDKIntegrations

### [​](https://supermemory.ai/docs/changelog/overview\#gmail-connector)  Gmail Connector

New connector to sync Gmail threads into Supermemory. Threads are stored in R2 for reliable processing of large mailboxes.

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-pipecat-python-package)  `supermemory-pipecat` Python Package

New SDK for Pipecat voice AI pipelines, including Gemini Live speech-to-speech support.

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-%E2%80%94-prompt-templates)  `@supermemory/tools` — Prompt Templates

Customize how memory context is formatted in AI SDK integrations with the new `promptTemplate` option.

### [​](https://supermemory.ai/docs/changelog/overview\#other-2)  Other

- **Container tag filters** in list and search endpoints.
- **Pagination improvements** across the console.

[​](https://supermemory.ai/docs/changelog/overview#december-30-2025)

December 30, 2025

MCPSDKAPI

### [​](https://supermemory.ai/docs/changelog/overview\#mcp-4-0)  MCP 4.0

Major MCP server update with session configuration, project-aware tools on every init, and backward-compatible 3.0 support. New `context` prompt for automatic user profile injection into AI conversations.

### [​](https://supermemory.ai/docs/changelog/overview\#s3-connector)  S3 Connector

New connector to sync documents from Amazon S3 buckets, with console UI for bucket configuration.

### [​](https://supermemory.ai/docs/changelog/overview\#memory-graph-revamp)  Memory Graph Revamp

Complete rewrite of `@supermemory/memory-graph` with improved visualization and performance.

[​](https://supermemory.ai/docs/changelog/overview#december-24-2025)

December 24, 2025

SDK

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-%E2%80%94-ai-sdk-v5/v6)  `@supermemory/tools` — AI SDK v5/v6

Now supports both Vercel AI SDK v5 and v6 with automatic version detection.

### [​](https://supermemory.ai/docs/changelog/overview\#conversation-support-in-sdks)  Conversation Support in SDKs

`supermemory` (TypeScript) and `supermemory-openai-sdk` (Python) now support the conversations API for multi-turn chat with memory.

### [​](https://supermemory.ai/docs/changelog/overview\#memorybench)  MemoryBench

New open-source benchmark suite for evaluating memory systems, with documentation and CLI.

[​](https://supermemory.ai/docs/changelog/overview#december-17-2025)

December 17, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#hybrid-search-mode)  Hybrid Search Mode

New `hybrid` search mode in `/v4/search` combining semantic and keyword search for better recall on technical queries.

[​](https://supermemory.ai/docs/changelog/overview#december-9-2025)

December 9, 2025

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#firecrawl-integration)  Firecrawl Integration

Web crawling powered by Firecrawl for more reliable extraction of website content, with fallback support.

### [​](https://supermemory.ai/docs/changelog/overview\#custom-github-credentials)  Custom GitHub Credentials

Bring your own GitHub OAuth app credentials for the GitHub connector, enabling private repo access.

### [​](https://supermemory.ai/docs/changelog/overview\#api-key-expiration-emails)  API Key Expiration Emails

API keys now trigger email notifications before expiration.

### [​](https://supermemory.ai/docs/changelog/overview\#connector-sync-logs)  Connector Sync Logs

Connection syncs now produce detailed logs visible in the console.

[​](https://supermemory.ai/docs/changelog/overview#december-5-2025)

December 5, 2025

SDK

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-%E2%80%94-browser-api-key-support)  `@supermemory/tools` — Browser API Key Support

`apiKey` can now be passed via options instead of relying on `process.env`, enabling browser-based usage.

[​](https://supermemory.ai/docs/changelog/overview#december-2-2025)

December 2, 2025

Console

### [​](https://supermemory.ai/docs/changelog/overview\#organization-deletion)  Organization Deletion

Organizations can now be fully deleted from the console, including all associated data.

### [​](https://supermemory.ai/docs/changelog/overview\#billing-page-redesign)  Billing Page Redesign

New billing layout with invoicing support and improved usage visibility.

### [​](https://supermemory.ai/docs/changelog/overview\#console-onboarding-improvements)  Console Onboarding Improvements

Streamlined onboarding flow for new users.

[​](https://supermemory.ai/docs/changelog/overview#november-17-2025)

November 17, 2025

APISDK

### [​](https://supermemory.ai/docs/changelog/overview\#web-crawler-connector)  Web Crawler Connector

New connector to crawl and index entire websites with configurable depth and URL patterns.

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/memory-graph-package)  `@supermemory/memory-graph` Package

New package for building interactive graph visualizations of memory connections, with a standalone playground.

### [​](https://supermemory.ai/docs/changelog/overview\#openai-responses-api-support)  OpenAI Responses API Support

`@supermemory/tools` OpenAI integration now supports the Responses API.

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-openai-sdk-%E2%80%94-python-middleware)  `supermemory-openai-sdk` — Python Middleware

New `withSupermemory` middleware for the Python OpenAI SDK, enabling transparent memory injection into OpenAI API calls.

### [​](https://supermemory.ai/docs/changelog/overview\#browser-extension-webpage-capture)  Browser Extension Webpage Capture

Chrome extension can now capture full webpage content with markdown conversion.

### [​](https://supermemory.ai/docs/changelog/overview\#bulk-memory-optimization)  Bulk Memory Optimization

Memory creation now uses bulk inserts for significantly faster batch ingestion.

[​](https://supermemory.ai/docs/changelog/overview#october-27-2025)

October 27, 2025

APISDK

### [​](https://supermemory.ai/docs/changelog/overview\#enhanced-filtering)  Enhanced Filtering

New `string_contains` filter type for partial string matching, `ignoreCase` option for case-insensitive operations, and improved negation support. Enhanced SQL injection protection.

### [​](https://supermemory.ai/docs/changelog/overview\#withsupermemory-for-openai-sdk)  `withSupermemory` for OpenAI SDK

New `withSupermemory` wrapper for the OpenAI TypeScript SDK — transparent memory injection with automatic assistant response capture.

### [​](https://supermemory.ai/docs/changelog/overview\#zapier-&-n8n-integration-pages)  Zapier & n8n Integration Pages

New integration guides for connecting Supermemory with Zapier and n8n automation workflows.

[​](https://supermemory.ai/docs/changelog/overview#october-10-2025)

October 10, 2025

SDKAPIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-%E2%80%94-ai-sdk-withsupermemory)  `@supermemory/tools` — AI SDK `withSupermemory`

New `withSupermemory` language model wrapper for Vercel AI SDK that automatically injects memory context and captures assistant responses.

### [​](https://supermemory.ai/docs/changelog/overview\#raycast-extension)  Raycast Extension

New Raycast extension for quick memory access and addition from the macOS launcher.

### [​](https://supermemory.ai/docs/changelog/overview\#user-profiles-api)  User Profiles API

New `/v4/profile` endpoint for retrieving AI-generated user profiles derived from memory interactions, with container tag scoping.

### [​](https://supermemory.ai/docs/changelog/overview\#other-3)  Other

- **DOCX support** — Word documents can now be ingested.
- **Project selection for connectors** — assign Google Drive, Notion, and OneDrive connections to specific projects.
- **Multiple models in consumer chat** — model switcher with system prompt improvements.
- **Organization settings** — configure Supermemory behavior (chunking, extraction, memory limits) per org.

[​](https://supermemory.ai/docs/changelog/overview#september-17-2025)

September 17, 2025

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#forgotten-memories-search)  Forgotten Memories Search

New `include.forgottenMemories` parameter in v4 search API to search through memories that have been explicitly forgotten or expired.

### [​](https://supermemory.ai/docs/changelog/overview\#enhanced-delete-api)  Enhanced Delete API

`DELETE /v3/documents/:id` now supports both internal document ID and `customId`.

### [​](https://supermemory.ai/docs/changelog/overview\#api-terminology-update)  API Terminology Update

Renamed “memories” to “documents” for developer clarity. New `/v3/documents/*` endpoints with full backward compatibility via automatic redirects from `/v3/memories/*`.

### [​](https://supermemory.ai/docs/changelog/overview\#console-revamp)  Console Revamp

New console design with dark/light mode, org switcher, billing invoices, space selector with search, and memory list with multi-delete.

### [​](https://supermemory.ai/docs/changelog/overview\#other-4)  Other

- **New filters** — revamped filtering UI in the console.
- **Onboarding redesign** — new step-based onboarding with code samples.
- **Configurable chunking** — set chunk size and algorithm per org.

[​](https://supermemory.ai/docs/changelog/overview#september-12-2025)

September 12, 2025

APISDK

### [​](https://supermemory.ai/docs/changelog/overview\#documentation-v2-0)  Documentation v2.0

Complete rewrite with comprehensive API references, cookbook recipes, and production-ready examples for TypeScript, Python, and cURL.

### [​](https://supermemory.ai/docs/changelog/overview\#@supermemory/tools-package)  `@supermemory/tools` Package

New tools package for native Vercel AI SDK and OpenAI integration with memory tools and infinite chat. Plus `openai-python-sdk` for Python middleware.

### [​](https://supermemory.ai/docs/changelog/overview\#batch-add-&-bulk-delete)  Batch Add & Bulk Delete

New `POST /v3/documents/batch` for batch ingestion and `DELETE /v3/documents/bulk` for bulk deletion.

### [​](https://supermemory.ai/docs/changelog/overview\#memory-forgetfulness-system)  Memory Forgetfulness System

Full lifecycle management with `forgetAfter` dates and forgotten memory filtering.

### [​](https://supermemory.ai/docs/changelog/overview\#video-uploads)  Video Uploads

Video files can now be ingested with automatic content extraction.

[​](https://supermemory.ai/docs/changelog/overview#september-1-2025)

September 1, 2025

MCPConsole

### [​](https://supermemory.ai/docs/changelog/overview\#mcp-connection-flow-redesign)  MCP Connection Flow Redesign

Step-based UI for connecting MCP clients with v1 migration support. One-click install for Cursor.

### [​](https://supermemory.ai/docs/changelog/overview\#claude-ai-&-t3-chat-extension-support)  Claude.ai & t3.chat Extension Support

Browser extension now integrates directly with Claude.ai and t3.chat for automatic memory search during conversations.

### [​](https://supermemory.ai/docs/changelog/overview\#waitlist-removed)  Waitlist Removed

Supermemory is now open to all users — no more waitlist.

[​](https://supermemory.ai/docs/changelog/overview#august-24-2025)

August 24, 2025

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#new-landing-page-&-developer-page)  New Landing Page & Developer Page

Redesigned marketing pages with developer-focused content, SEO improvements, and mobile responsiveness.

### [​](https://supermemory.ai/docs/changelog/overview\#direct-webpage-ingestion)  Direct Webpage Ingestion

Ingest web content with `<sm-highlight>` tags for targeted extraction.

### [​](https://supermemory.ai/docs/changelog/overview\#usage-limits-dashboard)  Usage Limits Dashboard

Billing usage and limits now visible directly in the console dashboard.

### [​](https://supermemory.ai/docs/changelog/overview\#other-5)  Other

- **Allow all CORS origins** for easier API integration.
- **Single `containerTag` in add memory** — simpler API for basic use cases.
- **Improved MCP project handling** — better project scoping in the MCP server.

[​](https://supermemory.ai/docs/changelog/overview#august-16-2025)

August 16, 2025

Console

### [​](https://supermemory.ai/docs/changelog/overview\#new-consumer-app)  New Consumer App

Complete rewrite of the consumer-facing app — new chat experience with slide-out window, masonry memory grid with infinite scroll, PWA support, and mobile-responsive menu bar.

### [​](https://supermemory.ai/docs/changelog/overview\#memory-graph-with-webgl)  Memory Graph with WebGL

Graph rendering now uses WebGL for smooth visualization of thousands of memory connections. Search highlights relevant nodes with zoom.

### [​](https://supermemory.ai/docs/changelog/overview\#chat-rewrite)  Chat Rewrite

New chat system with memory-aware conversations, regeneration, copy buttons, and the ability to add memories through chat.

### [​](https://supermemory.ai/docs/changelog/overview\#dynamic-node-relations)  Dynamic Node Relations

Memory graph now supports `update`, `extend`, and `derive` relation types. Memories can be inferred from multiple parent documents.

[​](https://supermemory.ai/docs/changelog/overview#august-12-2025)

August 12, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#pdf-support-for-google-drive)  PDF Support for Google Drive

Google Drive connector now processes PDF files alongside Docs, Sheets, and Slides.

### [​](https://supermemory.ai/docs/changelog/overview\#encrypted-connector-credentials)  Encrypted Connector Credentials

Google Drive, OneDrive, and Notion client secrets are now encrypted at rest.

### [​](https://supermemory.ai/docs/changelog/overview\#bulk-memory-delete)  Bulk Memory Delete

New endpoint for deleting multiple memories at once.

### [​](https://supermemory.ai/docs/changelog/overview\#self-host-support)  Self-Host Support

Initial self-hosting support — run Supermemory on your own infrastructure.

[​](https://supermemory.ai/docs/changelog/overview#august-1-2025)

August 1, 2025

ConsoleAPI

### [​](https://supermemory.ai/docs/changelog/overview\#console-migrated-to-cloudflare)  Console Migrated to Cloudflare

Console app moved from Vercel to Cloudflare Workers for improved performance and lower latency.

### [​](https://supermemory.ai/docs/changelog/overview\#autumn-payments-integration)  Autumn Payments Integration

Billing system integrated with Autumn for subscription management, waitlist early access, and usage tracking.

### [​](https://supermemory.ai/docs/changelog/overview\#new-developer-dashboard)  New Developer Dashboard

Redesigned developer dashboard with API key display in code snippets, limits visualization, and MCP installation instructions.

[​](https://supermemory.ai/docs/changelog/overview#july-25-2025)

July 25, 2025

ConsoleMCP

### [​](https://supermemory.ai/docs/changelog/overview\#consumer-app-v0)  Consumer App v0

First version of the consumer app with chat, memory browsing, project management, and profile view. New consumer-oriented landing page.

### [​](https://supermemory.ai/docs/changelog/overview\#mcp-%E2%86%92-agents-sdk)  MCP → Agents SDK

MCP server migrated to the Agents SDK architecture for better reliability and project support.

### [​](https://supermemory.ai/docs/changelog/overview\#new-billing)  New Billing

Revamped billing page with upgrade buttons and plan management.

[​](https://supermemory.ai/docs/changelog/overview#july-16-2025)

July 16, 2025

ConsoleAPI

### [​](https://supermemory.ai/docs/changelog/overview\#memory-graph-rewrite)  Memory Graph Rewrite

Complete rewrite of the graph visualization — faster rendering, better layout, and interactive exploration.

### [​](https://supermemory.ai/docs/changelog/overview\#onboarding)  Onboarding

New guided onboarding flow for first-time console users.

### [​](https://supermemory.ai/docs/changelog/overview\#notion-webhooks)  Notion Webhooks

Real-time sync for Notion connections via webhook integration.

[​](https://supermemory.ai/docs/changelog/overview#july-5-2025)

July 5, 2025

Console

### [​](https://supermemory.ai/docs/changelog/overview\#landing-page-rewrite)  Landing Page Rewrite

New marketing site with glass UI design, rewritten pricing page, and dedicated MCP page.

### [​](https://supermemory.ai/docs/changelog/overview\#billing-page)  Billing Page

New billing page with upgrade buttons and plan comparison.

### [​](https://supermemory.ai/docs/changelog/overview\#posthog-analytics)  PostHog Analytics

Analytics tracking added across the console and landing page.

[​](https://supermemory.ai/docs/changelog/overview#june-21-2025)

June 21, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#onedrive-connector)  OneDrive Connector

New connector for syncing OneDrive files with webhook-based real-time updates.

### [​](https://supermemory.ai/docs/changelog/overview\#connectors-byok)  Connectors BYOK

Bring your own API keys for connector integrations (Google Drive, OneDrive, Notion).

### [​](https://supermemory.ai/docs/changelog/overview\#google-sheets-&-slides)  Google Sheets & Slides

Google Drive connector now supports Sheets and Slides alongside Docs.

[​](https://supermemory.ai/docs/changelog/overview#june-12-2025)

June 12, 2025

ConsoleAPI

### [​](https://supermemory.ai/docs/changelog/overview\#console-dashboard)  Console Dashboard

First version of the dashboard overview page with memory analytics, container tag distribution charts, and usage metrics.

### [​](https://supermemory.ai/docs/changelog/overview\#google-drive-webhooks)  Google Drive Webhooks

Real-time sync — Google Drive changes are automatically detected and processed.

### [​](https://supermemory.ai/docs/changelog/overview\#sentry-integration)  Sentry Integration

Error monitoring added across the console and API.

[​](https://supermemory.ai/docs/changelog/overview#may-28-2025)

May 28, 2025

APIConsole

### [​](https://supermemory.ai/docs/changelog/overview\#launch-ready-api)  Launch-Ready API

Console reached launchable state with login page improvements, auth fixes, and the first version of the new dashboard with React Query.

### [​](https://supermemory.ai/docs/changelog/overview\#infinite-chat)  Infinite Chat

Memory Router proxy with automatic context compression for infinite-length conversations with LLMs.

### [​](https://supermemory.ai/docs/changelog/overview\#container-tags-in-search)  Container Tags in Search

Filter search results by container tags for scoped memory retrieval.

### [​](https://supermemory.ai/docs/changelog/overview\#google-docs-md-export)  Google Docs MD Export

Google Drive connector switched from PDF to Markdown export for better content fidelity.

[​](https://supermemory.ai/docs/changelog/overview#may-8-2025)

May 8, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#api-v3)  API v3

New `/v3/` endpoints replacing v2 — cleaner routes, updated memory endpoint, and new update/delete operations.

### [​](https://supermemory.ai/docs/changelog/overview\#onedrive-connector-2)  OneDrive Connector

Initial OneDrive integration for syncing files into Supermemory.

### [​](https://supermemory.ai/docs/changelog/overview\#connections-architecture)  Connections Architecture

New connection-document relationship model for tracking which connector synced which document.

[​](https://supermemory.ai/docs/changelog/overview#april-30-2025)

April 30, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#comprehensive-api-documentation)  Comprehensive API Documentation

New interactive API references on Mintlify with detailed parameter explanations, response schemas, and bearer auth.

### [​](https://supermemory.ai/docs/changelog/overview\#container-tags-system)  Container Tags System

Enhanced organizational grouping for better memory isolation and user-scoped content.

### [​](https://supermemory.ai/docs/changelog/overview\#auto-content-type-detection)  Auto Content Type Detection

Automatic processing of PDFs, images, videos, and web content regardless of URL extensions.

[​](https://supermemory.ai/docs/changelog/overview#april-28-2025)

April 28, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#google-drive-connector)  Google Drive Connector

New endpoints for programmatic Google Drive integration and file syncing.

[​](https://supermemory.ai/docs/changelog/overview#april-25-2025)

April 25, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#search-improvements)  Search Improvements

- **`documentThreshold` and `chunkThreshold`** — fine-tune search sensitivity.
- **`docId` parameter** — search within specific large documents.
- **`onlyMatchingChunks`** — precise result filtering.
- **`endUserId` filtering** — scope search to specific users.
- **Reranking** — improved result quality with a reranking step.

[​](https://supermemory.ai/docs/changelog/overview#april-22-2025)

April 22, 2025

APIMCP

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-mcp-server)  Supermemory MCP Server

First version of the MCP server for AI model integrations.

### [​](https://supermemory.ai/docs/changelog/overview\#personalisation)  Personalisation

AI-generated personalization based on user memory patterns.

### [​](https://supermemory.ai/docs/changelog/overview\#list-memories-endpoint-2)  List Memories Endpoint

First version of the list memories API with pagination.

[​](https://supermemory.ai/docs/changelog/overview#april-14-2025)

April 14, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#team-api)  Team API

Organization invites and user management endpoints.

### [​](https://supermemory.ai/docs/changelog/overview\#analytics-api)  Analytics API

Hourly analytics tracking with detailed usage metrics.

### [​](https://supermemory.ai/docs/changelog/overview\#content-processing-pipeline)  Content Processing Pipeline

New ingestion workflow with status tracking: `queued` → `extracting` → `chunking` → `embedding` → `done`.

[​](https://supermemory.ai/docs/changelog/overview#march-27-2025)

March 27, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#connections-system)  Connections System

First version of the connectors architecture — sync external data sources into Supermemory.

### [​](https://supermemory.ai/docs/changelog/overview\#tag-based-filtering)  Tag-Based Filtering

Filter memories by tags in search and list operations.

### [​](https://supermemory.ai/docs/changelog/overview\#advanced-analytics)  Advanced Analytics

Request tracking, error counts, and usage metrics per organization.

[​](https://supermemory.ai/docs/changelog/overview#march-18-2025)

March 18, 2025

API

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-api-v2)  Supermemory API v2

The platform begins — Cloudflare Workers API with auth, ingestion workflows, vector search, and organization support. Built on Hono, Drizzle ORM, and Cloudflare D1/Hyperdrive.

[​](https://supermemory.ai/docs/changelog/overview#january-20-2025)

January 20, 2025

Console

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-v2-release)  Supermemory v2 Release

Major release of the consumer web app with new import tools (CSV, Markdown/Obsidian), improved hybrid search with date relevancy, batch delete, and space management (edit/delete names).

### [​](https://supermemory.ai/docs/changelog/overview\#docs-site-launch)  Docs Site Launch

First version of the documentation site with API reference, getting started guide, and pricing page.

[​](https://supermemory.ai/docs/changelog/overview#august-16-2024)

August 16, 2024

Console

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-v1-%E2%80%94-major-update)  Supermemory v1 — Major Update

New consumer app version with canvas/note editor, text-to-speech on AI answers, PWA support, improved Telegram bot with Markdown, and memory queue processing. Extension gets drag-and-dismiss features.

[​](https://supermemory.ai/docs/changelog/overview#july-21-2024)

July 21, 2024

Console

### [​](https://supermemory.ai/docs/changelog/overview\#producthunt-launch)  ProductHunt Launch

Supermemory launches on ProductHunt. Features at launch: shareable spaces, Twitter thread import, AI chat with citations, onboarding flow, recommended items, chat history, and keyboard shortcuts.

[​](https://supermemory.ai/docs/changelog/overview#june-23-2024)

June 23, 2024

Console

### [​](https://supermemory.ai/docs/changelog/overview\#multi-turn-chat-&-canvas)  Multi-Turn Chat & Canvas

Added multi-turn conversations, canvas with drag-and-drop, Telegram bot, vector lookup 2x speedup, and the first version of the Chrome extension.

[​](https://supermemory.ai/docs/changelog/overview#may-18-2024)

May 18, 2024

API

### [​](https://supermemory.ai/docs/changelog/overview\#backend-rewrite-to-hono)  Backend Rewrite to Hono

Backend migrated from Next.js API routes to Hono on Cloudflare Workers. Landing page redesign, browser rendering for web content extraction.

[​](https://supermemory.ai/docs/changelog/overview#april-11-2024)

April 11, 2024

Console

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-v1-launch)  Supermemory v1 Launch

First public release — spaces, chat with AI, Twitter bookmarks import, Chrome extension with save-from-page, notes editor, and search across all saved content.

[​](https://supermemory.ai/docs/changelog/overview#february-21-2024)

February 21, 2024

Console

### [​](https://supermemory.ai/docs/changelog/overview\#supermemory-is-born)  Supermemory is Born

Initial monorepo setup with auth, Chrome extension, AI chat with citations using OpenAI embeddings, and the first version of the web app.

Was this page helpful?

YesNo

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)