---
url: https://supermemory.ai/docs/integrations/claude-code
title: Claude Code - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/integrations/claude-code#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Claude Code

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Get Your API Key](https://supermemory.ai/docs/integrations/claude-code#get-your-api-key)
- [Install the Plugin](https://supermemory.ai/docs/integrations/claude-code#install-the-plugin)
- [How It Works](https://supermemory.ai/docs/integrations/claude-code#how-it-works)
- [What Gets Captured](https://supermemory.ai/docs/integrations/claude-code#what-gets-captured)
- [Commands](https://supermemory.ai/docs/integrations/claude-code#commands)
- [/claude-supermemory:logout](https://supermemory.ai/docs/integrations/claude-code#%2Fclaude-supermemorylogout)
- [Configuration](https://supermemory.ai/docs/integrations/claude-code#configuration)
- [Environment Variables](https://supermemory.ai/docs/integrations/claude-code#environment-variables)
- [Settings File](https://supermemory.ai/docs/integrations/claude-code#settings-file)
- [Next Steps](https://supermemory.ai/docs/integrations/claude-code#next-steps)

![Claude Code + Supermemory](https://mintcdn.com/supermemory/6HwzudOPLAP67sR5/images/claude-code-supermemory.png?fit=max&auto=format&n=6HwzudOPLAP67sR5&q=85&s=3d8b5cd00244586ef748944d47b4308c)

This integration requires the **Supermemory Pro plan**. [Upgrade here](https://console.supermemory.ai/billing).

[Claude-Supermemory](https://github.com/supermemoryai/claude-supermemory) is a Claude Code plugin that gives your AI persistent memory across sessions. Your agent remembers what you worked on — across sessions, across projects.

## [​](https://supermemory.ai/docs/integrations/claude-code\#get-your-api-key)  Get Your API Key

Create a Supermemory API key from the [API Keys](https://console.supermemory.ai/keys) page, then add it to your shell profile so it persists across sessions:

- macOS / Linux (zsh)

- macOS / Linux (bash)

- Windows (PowerShell)


```
echo 'export SUPERMEMORY_CC_API_KEY="sm_..."' >> ~/.zshrc
source ~/.zshrc
```

```
echo 'export SUPERMEMORY_CC_API_KEY="sm_..."' >> ~/.bashrc
source ~/.bashrc
```

```
[System.Environment]::SetEnvironmentVariable("SUPERMEMORY_CC_API_KEY", "sm_...", "User")
```

Restart your terminal after running this.

## [​](https://supermemory.ai/docs/integrations/claude-code\#install-the-plugin)  Install the Plugin

```
# Add the plugin marketplace
/plugin marketplace add supermemoryai/claude-supermemory

# Install the plugin
/plugin install claude-supermemory
```

## [​](https://supermemory.ai/docs/integrations/claude-code\#how-it-works)  How It Works

Once installed, the plugin runs automatically:

- **Context Injection** — On session start, relevant memories are fetched and injected into Claude’s context. This includes user preferences, project knowledge, and past interactions.
- **Auto-Capture** — Tool usage is captured and stored during the session for future context.

### [​](https://supermemory.ai/docs/integrations/claude-code\#what-gets-captured)  What Gets Captured

| Tool | Captured As |
| --- | --- |
| Edit | `Edited src/auth.ts: "old code..." → "new code..."` |
| Write | `Created src/new-file.ts (500 chars)` |
| Bash | `Ran: npm test (SUCCESS/FAILED)` |
| Task | `Spawned agent: explore codebase` |

## [​](https://supermemory.ai/docs/integrations/claude-code\#commands)  Commands

### [​](https://supermemory.ai/docs/integrations/claude-code\#/claude-supermemorylogout)  /claude-supermemory:logout

Log out from Supermemory and clear saved credentials.

```
/claude-supermemory:logout
```

## [​](https://supermemory.ai/docs/integrations/claude-code\#configuration)  Configuration

### [​](https://supermemory.ai/docs/integrations/claude-code\#environment-variables)  Environment Variables

```
SUPERMEMORY_CC_API_KEY=sm_...         # Required
SUPERMEMORY_SKIP_TOOLS=Read,Glob,Grep # Tools to not capture (optional)
SUPERMEMORY_DEBUG=true                # Enable debug logging (optional)
```

### [​](https://supermemory.ai/docs/integrations/claude-code\#settings-file)  Settings File

Create `~/.supermemory-claude/settings.json`:

```
{
  "skipTools": ["Read", "Glob", "Grep", "TodoWrite"],
  "captureTools": ["Edit", "Write", "Bash", "Task"],
  "maxContextMemories": 10,
  "maxProjectMemories": 20,
  "debug": false
}
```

## [​](https://supermemory.ai/docs/integrations/claude-code\#next-steps)  Next Steps

[**GitHub Repository** \\
\\
Source code, issues, and detailed README.](https://github.com/supermemoryai/claude-supermemory)

[**OpenClaw Plugin** \\
\\
Multi-platform memory for Telegram, WhatsApp, Discord, and more.](https://supermemory.ai/docs/integrations/openclaw)

Was this page helpful?

YesNo

[OpenClaw](https://supermemory.ai/docs/integrations/openclaw) [OpenCode](https://supermemory.ai/docs/integrations/opencode)

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)

![Claude Code + Supermemory](https://mintcdn.com/supermemory/6HwzudOPLAP67sR5/images/claude-code-supermemory.png?w=1100&fit=max&auto=format&n=6HwzudOPLAP67sR5&q=85&s=d03b1fc318e8e876855fbfd48f25a71e)