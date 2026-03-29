---
title: Kijko Frontend
description: Next.js docs surface with a separate chat route and a legacy client boundary
audience: both
tags:
  - frontend
  - nextjs
  - migration
---

# Kijko Frontend

The current frontend surface lives in `apps/web`, which now renders the docs landing page at `/` and keeps the CopilotKit chat surface at `/chat`. The legacy `client/` app still exists in the repo, so the migration boundary remains visible. That makes this page a good place to explain the browser shape of the workspace without pretending the migration is finished. Readers should come away understanding which routes are active today, which files own them, and where the docs corpus fits into the experience.

## Current Shape

- `apps/web/app/page.tsx` now points at the docs landing surface.
- `apps/web/app/chat/page.tsx` keeps the chat control surface reachable.
- `apps/web/lib/wikiagent-copilot-adapter.ts` routes CopilotKit traffic to the local agent.
- `apps/web/lib/docs.ts` loads docs pages from `wiki-content/docs` and exposes the current catalog.
- `client/src/App.tsx` still shows the older hash-routed frontend and is part of the migration context.

That shape is simple, but it matters. The docs page set is not an accidental side effect of the frontend. It is part of the UI contract. The app shell, the docs reader, and the chat route each have a different purpose, and the documentation should help a contributor keep those purposes separate.

## Route Responsibilities

The browser should make the route split obvious:

- `/` is the top-level reading surface.
- `/docs` is the markdown reader.
- `/chat` is the command and assistant surface.

Those route responsibilities help prevent a common brownfield mistake: mixing navigation, reading, and action-taking into one screen until the user no longer knows what the app is for. In this repository, the docs surface and the chat surface deliberately answer different questions. The docs pages explain the workspace. The chat surface helps operate it. The frontend page should make that difference feel intentional rather than incidental.

## Why The Legacy Client Still Matters

The old `client/` app is still useful because it shows the migration boundary. If a file is still present, it often means the repo wants a reader to know that there is a predecessor, even if the new route is now the primary one. This is especially important for docs because a reader may land here expecting a full rewrite. The page should tell them the truth: the new surface exists, but the legacy client still helps explain where the repo came from.

The right tone is not apology. It is context. The docs should say, in plain language, that the repo has shifted to a Next.js surface with a docs reader and chat route, while the older client stays in view as migration history. That makes the page a guide instead of a status banner.

## Example Filesystem Sketch

```text
apps/web/
  app/
    page.tsx
    chat/page.tsx
  lib/
    docs.ts
    wikiagent-copilot-adapter.ts
client/
  src/App.tsx
```

That sketch is enough to understand the browser boundary without exposing the entire codebase. It is also a useful mental map for anyone editing docs content, because the docs pages and the frontend routes are tightly coupled in how users discover them.

## Example Verification Loop

```bash
pnpm --filter @kijko/wikiagent-web dev
pnpm --filter @kijko/wikiagent-web check
```

Those commands are the easiest way to check whether a docs-page change still fits the frontend. The development server lets you inspect the rendered surface, and the typecheck confirms that the app code still compiles. If you are also changing docs content, pair those commands with a quick read of the relevant markdown page so the route and the prose still agree.

## Docs Catalog Notes

The docs catalog in `apps/web/lib/docs.ts` is intentionally explicit. That is why the current page list is easy to reason about and why the docs reader stays predictable. A static catalog is not the same thing as a dynamic filesystem scan, but it does make the current surface easier to control. For this repo slice, that tradeoff is acceptable because it keeps the browser behavior deterministic while the docs corpus is being expanded.

If the app eventually grows file-backed discovery, the docs page should be updated to explain the new source of truth. Until then, the safest assumption is that the catalog and the committed markdown files need to stay aligned by hand.

## Next Steps

- Read [`getting-started`](/docs/getting-started) for the local commands and verification loop.
- Read [`index`](/docs) for the map of the docs corpus.
- Read [`panopticon`](/docs/panopticon) if you want an example of how seeded labels show up in the docs layer.

## Sources

- `apps/web/app/page.tsx`
- `apps/web/app/chat/page.tsx`
- `apps/web/lib/wikiagent-copilot-adapter.ts`
- `apps/web/lib/docs.ts`
- `client/src/App.tsx`
