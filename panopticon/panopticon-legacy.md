---
title: Panopticon
description: Legacy repo label used in intent coverage, seed data, and help text
audience: both
tags:
  - panopticon
  - repo
  - seed-data
---

# Panopticon

Panopticon is one of the repo labels that appears repeatedly in the repository's seed data and tests. It is a useful anchor for documenting how the wiki surfaces line up with the repo names that the agent and legacy app already know about. In this workspace, the value of the page is not that Panopticon is a live service with its own runtime. The value is that the label already exists in the repo's vocabulary, so the docs can use it as a stable example without introducing new naming conventions.

## Overview

- `server/routes.ts` seeds `panopticon` as a monitored repository and also seeds a Panopticon docs page.
- `tests/wikiagent.test.ts` uses Panopticon in intent classification coverage.
- `apps/agent/src/lib/chat-engine.ts` includes Panopticon in the help text that suggests example user commands.
- `wiki-content/docs/panopticon.md` is the committed markdown page that readers see in the docs surface.

Those four signals matter because they show the label from three different angles: seed data, tests, and user-facing guidance. That is a strong indicator that the word is part of the workspace's shared language. When a term appears in all three places, documentation should explain it in a way that helps people preserve the existing meaning rather than reinterpreting it.

## Why It Matters

Panopticon is a good example of how the docs surface should stay grounded in the repo's own vocabulary. The name is not invented for the docs reader; it is already used by the agent, the test suite, and the legacy sample data. That makes it a useful reference point when you are deciding whether a page should describe something real, something aspirational, or something that is only useful as a seed label. In this case, it is the first category.

If you are writing or editing this page, the safest pattern is to treat Panopticon as a descriptive anchor for a repository identity rather than as a promise about behavior. The page can explain how the label is used, where it appears, and what kinds of edits should keep the meaning stable. It should not introduce a separate architecture or feature list unless the repository actually adds one.

## Practical Reading

When a reader lands on this page, they should come away knowing three things:

1. Panopticon is a real repo label in the workspace.
2. The docs and agent surfaces both know about it.
3. The right next step is to inspect the surrounding context instead of guessing at hidden product meaning.

That reading order is especially important in brownfield documentation. New contributors often assume a concise label means there is a hidden subsystem behind it. Here, the simpler explanation is usually the correct one: Panopticon is a named example that lets the repo demonstrate seed data, intent coverage, and docs linking without making the reader reverse-engineer a full product line.

## Example Search Loop

```bash
rg -n "Panopticon" server apps tests wiki-content
```

That search returns the places where the label has been wired into the repository. The command is useful for two reasons. First, it shows that the page is grounded in evidence rather than memory. Second, it gives a contributor a quick way to see whether an edit in one surface should be mirrored somewhere else. If the help text changes, the page should probably change. If the seed data changes, the page should probably change. If both stay the same, the page should stay stable too.

## Suggested Page Shape

If you need to expand the page later, keep the shape simple:

```md
# Panopticon
## What the label means here
## Where it appears in the repo
## How to verify the references
## When to update this page
## Related docs
```

That template keeps the page descriptive without drifting into speculative product language. It also gives reviewers a predictable structure, which matters when several workers are editing nearby files and the docs corpus has to remain coherent.

## Update Triggers

- A seed record changes from `panopticon` to a different label.
- The agent help text adds or removes Panopticon as an example command.
- The intent tests stop using Panopticon as a coverage case.
- The docs navigation changes and the page needs to point at a new companion page.

## Next Steps

- Read [`panopticon-2-0`](/docs/panopticon-2-0) to see the follow-on label and how versioned examples are handled.
- Read [`getting-started`](/docs/getting-started) if you want the local verification loop.
- Read [`kijko-frontend`](/docs/kijko-frontend) if you want the route boundary that renders this page.

## Sources

- `server/routes.ts`
- `tests/wikiagent.test.ts`
- `apps/agent/src/lib/chat-engine.ts`
