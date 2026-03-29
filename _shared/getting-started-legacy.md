---
title: Getting Started
description: How to open the docs surface and run the local workspace checks
audience: both
tags:
  - getting-started
  - workflow
  - docs
---

# Getting Started

This page captures the practical entry points that already exist in the repository. It is the quickest route from a fresh checkout to a readable docs page, a running agent, and a verification pass that proves your edits did not drift away from the repository's actual scripts. The aim here is not to cover every subsystem. It is to give you a clean, repeatable loop that a contributor can follow without guessing which surface is authoritative.

## Open The Surface

- Open `/` for the docs landing surface.
- Open `/docs` for the markdown reader.
- Open `/chat` for the CopilotKit control surface.

The split matters because each route plays a different role. `/` should help a reader orient themselves. `/docs` should render the committed markdown corpus. `/chat` should stay focused on actions and guidance. If a user wants to learn how the workspace fits together, the docs pages should answer that without forcing them through the control surface first.

## Local Commands

```bash
pnpm --filter @kijko/wikiagent-web dev
pnpm --filter @kijko/wikiagent-agent dev
pnpm --filter @kijko/shared check
pnpm --filter @kijko/wikiagent-web check
```

The first command starts the browser app, the second starts the agent, and the remaining checks confirm that the TypeScript surfaces still compile cleanly. Those package names are stable across the repo, so they are better references than ad hoc shell snippets that only work in one directory or one shell session.

## Recommended Editing Loop

1. Pick the page you want to change and read the related pages first.
2. Update the markdown with a clear title, a concrete explanation, and a short example.
3. Add cross-links only to pages that already exist in the docs corpus.
4. Re-run the checks above before you ask anyone else to review the content.

That loop keeps the docs work safe in a brownfield repo because it forces each change to answer three questions: what changed, where did it change, and how can someone else verify it without re-learning the whole codebase?

## What To Verify First

- The page title matches the slug and the navigation label.
- The page describes something that actually appears in the repo, such as a route, a seed record, or a package script.
- The example commands still exist in `package.json` or another verified file.
- The prose stays inside the current runtime model rather than inventing a future implementation.

```text
docs/
  implementation/
    architecture.md
    deployment.md
  wiki-content/
    docs/
      index.md
      getting-started.md
      kijko-frontend.md
      panopticon.md
      panopticon-2-0.md
      hypervisa-3-0.md
      baton-exchange.md
```

That file layout is worth keeping in your head because it tells you where the authored content lives and where the implementation notes live. When a page starts to feel vague, the fastest fix is usually to anchor it to one file in that tree and one action the reader can take.

## Operational Notes

- `config/wikiagent.yaml` points `docs_root` at `wiki-content/docs`.
- `conductor/workflow.md` documents the Hetzner-safe workflow and the main verification commands.
- The superconductor run artifacts in `conductor/superconductor/` record the prompt, CGC, and NLM gut-check requirements. In this slice, those checks are documented in conductor artifacts instead of being executed by the web app itself.

If you are trying to understand whether the docs surface is "done," the honest answer is that it is done when the page content is specific, the commands are real, and the links help a reader move to the next page without wandering. That is a smaller bar than a complete platform launch, but it is the right bar for the docs corpus in this workspace.

## Next Steps

- Read [`kijko-frontend`](/docs/kijko-frontend) to understand the route and catalog split.
- Read [`panopticon`](/docs/panopticon) if you want to see how the docs pages tie back to seed data.
- Read [`baton-exchange`](/docs/baton-exchange) if you need a model for documenting a protocol-style label.
