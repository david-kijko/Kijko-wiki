---
url: https://supermemory.ai/docs/supermemory-mcp/introduction
title: About Supermemory MCP - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/supermemory-mcp/introduction#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

About Supermemory MCP

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [What Supermemory MCP Does](https://supermemory.ai/docs/supermemory-mcp/introduction#what-supermemory-mcp-does)
- [Supported Platforms](https://supermemory.ai/docs/supermemory-mcp/introduction#supported-platforms)
- [Key Features](https://supermemory.ai/docs/supermemory-mcp/introduction#key-features)
- [Core Workflow](https://supermemory.ai/docs/supermemory-mcp/introduction#core-workflow)
- [Security and Privacy](https://supermemory.ai/docs/supermemory-mcp/introduction#security-and-privacy)
- [Authentication Model](https://supermemory.ai/docs/supermemory-mcp/introduction#authentication-model)
- [Privacy Features](https://supermemory.ai/docs/supermemory-mcp/introduction#privacy-features)

Supermemory MCP Server 4.0 is a lightweight component that gives AI assistants persistent memory across conversations. It serves as a universal memory layer enabling Large Language Models (LLMs) to maintain context and memories across different applications and sessions, solving the fundamental limitation of AI assistants forgetting everything between conversations.

[**Quick Start** \\
\\
Jump to installation and setup](https://supermemory.ai/docs/supermemory-mcp/mcp)

## [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#what-supermemory-mcp-does)  What Supermemory MCP Does

**Supermemory MCP** functions as a universal memory system that bridges AI applications through the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/). It operates as an **MCP server** that communicates with MCP-compatible clients, storing and retrieving contextual information through the Supermemory API infrastructure.When users interact with any connected AI application, the system captures relevant information and makes it available across all other connected platforms through **semantic search and intelligent retrieval**.

### [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#supported-platforms)  Supported Platforms

- **Claude Desktop** \- Direct MCP protocol support
- **Cursor IDE** \- Global MCP server configuration via `~/.cursor/mcp.json`
- **Windsurf** \- Seamless integration for AI-powered development
- **VS Code** \- Compatible with AI coding extensions
- **Cline/Roo-Cline** \- Full MCP protocol support
- **Any MCP-compatible application** \- Universal compatibility through standard protocol

### [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#key-features)  Key Features

- **OAuth Authentication** \- Secure login through Supermemory accounts
- **API Key Support** \- Alternative authentication for automation and CI/CD
- **Persistent Memory** \- Save and recall information across sessions
- **User Profiles** \- Auto-generated profiles from stored memories
- **Project Scoping** \- Organize memories by project with `x-sm-project` header

## [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#core-workflow)  Core Workflow

1. User interacts with any MCP-compatible AI client
2. The client connects to `https://mcp.supermemory.ai/mcp`
3. OAuth flow authenticates the user (or API key validates directly)
4. During conversations, relevant information is stored using the `memory` tool
5. When context is needed, the `recall` tool retrieves relevant memories
6. The AI assistant accesses this persistent context regardless of which platform is being used

## [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#security-and-privacy)  Security and Privacy

### [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#authentication-model)  Authentication Model

- **OAuth by default** \- Secure authentication through Supermemory accounts
- **API key alternative** \- Keys start with `sm_` for programmatic access
- **Session isolation** \- Complete user data separation per account

### [​](https://supermemory.ai/docs/supermemory-mcp/introduction\#privacy-features)  Privacy Features

- **Data isolation** \- User memories completely separated by account
- **Secure infrastructure** \- Built on Cloudflare’s enterprise-grade platform
- **Open source** \- Full transparency into how your data is handled

[**Source Code** \\
\\
View the open-source implementation](https://github.com/supermemoryai/supermemory/tree/main/apps/mcp)

Was this page helpful?

YesNo

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)