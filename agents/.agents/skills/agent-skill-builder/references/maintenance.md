# Maintenance

Use this reference when changing a merged skill, handling a one-off failure, or deciding whether a broader rewrite is justified.

## Append-Mostly Changes

Treat merged skills as append-mostly. Most production fixes should add a gotcha, tighten an accessory-file pointer, or add an eval that captures the observed failure.

Do not rewrite the workflow or broaden the description for a single failure unless evidence shows a boundary problem.

## Failure Triage

Classify the failure before editing:

- Failed to load: add realistic positive triggers and rerun trigger evals.
- Loaded off target: tighten the description and add negative or forbidden-load evals.
- Loaded correctly but used the wrong detail: add a gotcha, improve a reference pointer, or move the detail into a template/asset.
- Recreated repeated helper logic: add a script and point to it from `SKILL.md`.
- Conflicted with changed global instructions: remove duplication and check routing contention.

Prefer the smallest change that prevents the observed failure from recurring without broadening the skill's routing surface.

## Refactor Threshold

Refactor into multiple files when the split lowers context cost or clarifies conditional loading. Do not split only for neatness; each extra file should have a clear reason to be read later instead of always loaded.
