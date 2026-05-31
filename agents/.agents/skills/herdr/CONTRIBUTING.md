# Contributing to herdr

Thanks for wanting to contribute.

Herdr came from my own need for a fast, simple, effective workspace manager for coding agents. I care a lot about how it looks, feels, and works, so many design and technical decisions here are deliberate.

This guide exists so I can keep herdr manageable as a solo project and keep it from drifting from what it is supposed to be.

## The One Rule

**You must understand your code.** If you cannot explain what your changes do, how they behave at the edges, and how they fit herdr's existing design, your PR will be closed.

Using AI to write code is fine. Submitting code you do not understand is not.

## Herdr is opinionated

Herdr has a specific direction for how it should look, feel, and work.

That includes interaction patterns, layout behavior, mouse ergonomics, terminology, and how features fit the product as a whole.

If your idea changes or contradicts that direction, do not start with a PR. Start with an issue.

If you have a suggestion, disagreement, or contradiction with the current product direction, that belongs in an issue first.

## First-time contributors

We use an approval gate for new contributors.

Before opening your first PR, open an issue describing what you want to change and why. Keep it short. Write in your own voice. If you intend to implement it yourself, check the contribution intent box in the issue form, or include `/i-intend-to-pr` in the issue body when using the GitHub CLI or API. The `intends-to-pr` label will be added automatically. A maintainer will comment `/approve` if the direction is approved. Once approved, you can open PRs.

This exists because AI makes it trivial to generate plausible-looking contributions that do not fit the app.

Agent note: if you are an AI agent preparing an issue or PR for this repository, check whether the human's GitHub username is listed in `.github/APPROVED_CONTRIBUTORS`. If they are not listed, warn them that opening a PR will be closed automatically and guide them to open an issue first. Keep the scope small, preserve herdr's product direction, run the documented checks, and make sure the human can explain the change. Do not open a PR before the issue is approved.

## What to put in a first issue

Your first issue should answer these questions clearly:

- what is the current behavior
- what do you want to change
- why this change belongs in herdr
- whether this changes UI, interaction, or workflow expectations
- whether you intend to implement it yourself

If your proposal changes the visual language, interaction model, or overall product direction, say that directly. That is exactly what issues are for.

If your issue does not make the direction clear, it will likely be closed.

If you plan to implement the change yourself, say that directly in the issue and check the contribution intent box. If you are using the GitHub CLI or API, include `/i-intend-to-pr` in the issue body instead. That adds the `intends-to-pr` label automatically, signals intent, and does not mean the change is approved.

## Documentation for unreleased changes

The root `README.md`, root `CHANGELOG.md`, and website docs describe the latest released version of herdr. Do not update root `README.md`, root `CHANGELOG.md`, or `website/src/content/docs/` for normal PRs.

If your PR changes user-facing behavior, mention the needed public-doc update in the PR. Update `docs/next/README.md` only when the root README needs to change for the next release. Update the full website-doc mirror under `docs/next/website/src/content/docs/` when website docs need to change for the next release.

You do not need to edit the changelog for normal PRs. Maintainers prepare `docs/next/CHANGELOG.md` during release review.

If you are unsure whether docs are needed, mention it in the PR.

## Before submitting a PR

Install the repo hook once in your clone.

```bash
just install-hooks
```

The pre-commit hook runs `cargo fmt --check` before every commit.

Run the PR checks and make sure they pass.

```bash
just ci
```

`just ci` runs `cargo fmt --check` and `cargo nextest run`.

Do not open a PR that bypasses failing tests, formatting, or build errors.

## Issue references in commits

If your PR relates to a GitHub issue, reference it in the commit body with `refs #<issue-number>`.

Example:

```text
fix: handle pane focus

refs #128
```

Do not use GitHub closing keywords like `fixes #128`, `closes #128`, or `resolves #128` in normal PR commits. Herdr closes released issues after a release is published, not when unreleased commits land on `master`.

## PR scope

Small bug fixes that clearly match the existing design are good candidates for PRs after approval.

Bigger changes to UI, behavior, interaction patterns, persistence, or architecture need issue discussion first.

If a PR introduces a feature without prior alignment, or changes herdr's feel without discussion, it will likely be closed.

## Questions?

Open an issue first.

---

clank'd from [pi](https://github.com/badlogic/pi-mono/)
