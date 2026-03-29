---
title: Panopticon 2.0
description: Durable agent orchestration example from the seeded repo set
audience: both
tags:
  - panopticon
  - orchestration
  - seed-data
---

# Panopticon 2.0

Panopticon 2.0 is another repo label carried through the repository seed data. The legacy route data describes it as a durable agent orchestration upgrade, which makes it a useful reference for the docs surface. This page should be read as a versioned continuation of the Panopticon naming pattern, not as proof that the current app exposes a separate orchestration engine under that name. The repository uses the label to preserve a narrative of evolution, and the docs should preserve that same narrative without turning it into a runtime claim.

## Overview

- `server/routes.ts` seeds `Panopticon2.0` as an active monitored repository.
- The same file seeds a `docs/panopticon-2-0` page entry.
- The older route seed data describes the page as a durable orchestration upgrade.
- `conductor/tracks/kijko_phase1_recovery_20260323/spec.md` also references the label, which makes it a useful trace point for the current documentation run.

That combination gives the page a clear role in the corpus. Panopticon establishes the original label. Panopticon 2.0 shows what happens when the repo keeps the same idea but adds a version suffix to signal a later pass. That is a common documentation pattern in brownfield systems, and it helps readers understand that the repo is carrying context forward rather than creating a totally different product line.

## Context

This page helps keep the docs reader aligned with the repo names that already show up in the application data model, rather than introducing a separate naming scheme. Versioned labels are easy to misunderstand because they look like release notes. In this repo, they are better treated as semantic anchors. The suffix tells a reader that the label belongs to the same family as Panopticon, but the more important part is still the surrounding evidence: seed data, route wiring, and docs pages that use the label consistently.

If you are editing this page, favor concrete comparisons over abstract praise. Explain what is different about the follow-on label, what remains shared, and what files prove the relationship. That keeps the page useful even if the repository later changes how it stores labels internally.

## Why This Version Exists

The value of Panopticon 2.0 is that it shows how the workspace handles continuity. Many systems start with a project name and then accumulate a second version, a migration tag, or a durable variant once the first shape is no longer enough. The docs page gives that transition a place to live. It also gives reviewers a place to check whether an edit preserves the distinction between the original label and the versioned one.

In practice, that means the page should answer questions like:

1. Is this still part of the Panopticon family?
2. Which files mention the label?
3. What would need to change if the label were renamed?

Those are documentation questions, not product promises. The answer can be simple, but it should be explicit.

## Example Note Block

```md
Panopticon 2.0 is the follow-on label in the Panopticon family.
Use it when you need to point at the durable-orchestration example
that appears in the seed data, route data, and track artifacts.
```

That kind of note works well here because it is compact, traceable, and easy to revise. It also avoids the trap of pretending the docs page is a spec for behavior that the repo has not actually implemented.

## Comparison With Panopticon

- Panopticon is the original label and the more general reference point.
- Panopticon 2.0 is the versioned continuation that signals a later pass or a more durable variant.
- Both labels are useful when you want to test that docs and agent help text stay in sync.

The comparison matters because it helps readers decide where to go next. If they need the base vocabulary, they can read Panopticon. If they need the evolution story, they can read this page. If they need the route boundary or local checks, they should move to the getting-started or frontend pages instead of assuming the labels imply executable behavior.

## Example Search Loop

```bash
rg -n "Panopticon2.0|Panopticon 2.0" server conductor wiki-content
```

That search is useful when you are validating whether a label still appears where you expect it to. In a repo with parallel docs and agent work, the safest maintenance move is to verify the string across the relevant surfaces before you change the prose.

## Next Steps

- Read [`panopticon`](/docs/panopticon) for the base label and the broader repository vocabulary.
- Read [`baton-exchange`](/docs/baton-exchange) for another seeded label that acts like a protocol reference.
- Read [`getting-started`](/docs/getting-started) for the local verification commands that should stay green after an edit.

## Sources

- `server/routes.ts`
- `conductor/tracks/kijko_phase1_recovery_20260323/spec.md`
