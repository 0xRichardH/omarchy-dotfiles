---
name: agent-skill-builder
description: Load when the user wants to create, update, or refactor an agent skill, improve skill routing, split overlong skill instructions, or turn a repeated agent workflow into a reusable skill. Hand off to skill-creator for eval runs, packaging, and trigger-description optimization.
---

# Agent Skill Builder

Create, update, and refactor agent skills with tight routing, lean instructions, and progressive disclosure. Use this skill to shape the skill artifact; use `skill-creator` for formal eval runs, review viewers, packaging, and description optimization.

Do not add `depends: skill-creator` by default. Most skill-shaping tasks do not need the full eval and packaging workflow loaded immediately; explicit handoff keeps lightweight edits cheap.

## Fast Path

Before writing or changing a skill, decide whether a skill is needed.

A skill is useful when the agent would otherwise get the task wrong, behave inconsistently, miss durable domain knowledge, or need reusable taste/workflow guidance that is not already in global instructions.

A skill is usually not useful when it only lists obvious commands, repeats global instructions, documents behavior that changes too quickly to maintain, or captures something a short user prompt can reliably handle.

Use this filter for every proposed instruction: would the agent get this wrong without this sentence? If not, delete it.

## Workflow

1. Capture the user's intent, expected triggers, expected outputs, constraints, and examples of successful behavior.
2. Draft routing evals before changing the description or body. Include positive triggers, near-miss negatives, forbidden loads, and progressive-read checks when bundled resources matter.
3. Choose or preserve a lowercase hyphenated skill name that matches the directory.
4. Write the `description` as routing guidance, not documentation. Prefer `Load when...` and realistic user intent.
5. Keep `SKILL.md` focused on durable judgment, gotchas, and pointers to optional resources.
6. Move heavy or conditional content into `references/`, deterministic repeated work into `scripts/`, and templates or schemas into `assets/`.
7. Hand off to `skill-creator` for eval runs, review UI, packaging, or trigger-description optimization.

## When To Read More

- Read `references/routing-evals.md` before changing a skill description, designing trigger boundaries, or resolving collisions with adjacent skills.
- Read `references/skill-structure.md` when splitting an overlong skill, choosing between `references/`, `assets/`, and `scripts/`, or adding metadata/config.
- Read `references/maintenance.md` when changing a merged skill, handling a one-off failure, or deciding whether a broad rewrite is justified.

## New Skills

Start from routing, not content. A useful skill has a precise load boundary before it has a long body.

Use this minimum shape:

```markdown
---
name: lowercase-hyphenated-name
description: Load when the user asks for...
---

# Skill Title

One short paragraph describing the behavior this skill changes.

## Workflow

1. ...

## Gotchas

- ...
```

## Updating Existing Skills

Preserve the existing skill name unless the user explicitly asks to rename it. The name is part of the routing surface and may be referenced by installed configs or docs.

Inspect the current skill before editing. Read the frontmatter, verify the directory name matches `name`, identify the trigger boundary, and separate durable guidance from examples, templates, scripts, and long references.

Prefer the smallest refactor that improves routing precision, reduces context cost, or makes the workflow easier for the model to follow.

## Description Rules

The description is the skill's routing trigger. It should help the agent decide whether to load the skill, not summarize the implementation.

Good descriptions start with `Load when`, stay short, include realistic user intents, and name boundaries when adjacent skills might otherwise conflict. Avoid broad keywords that cause off-target loading.

## Body Rules

Write for a model, not a human README.

Explain non-obvious judgment, preferences, gotchas, and failure modes. Do not list commands the model already knows unless exact flags or ordering are critical. Keep examples only when they teach a boundary, format, or gotcha.

If `SKILL.md` starts becoming a catalog, split content into files and add short pointers that tell the agent when to read each file.

## Gotchas

- Do not create a skill just because a workflow can be documented. Skills are a context tax.
- Do not broaden the description to catch every related query. Favor precise routing over recall at any cost.
- Do not change a merged skill's description without trigger evals for positive, negative, and forbidden cases.
- Do not bury trigger guidance in the body. The model only sees the description before loading the skill.
- Do not duplicate `skill-creator`. Use it for evals, packaging, review workflows, and description optimization.
- Do not refactor an existing skill into multiple files unless the split lowers context cost or clarifies conditional loading.
- Do not invent top-level folders for common resource types. Prefer `assets/` for templates and schemas unless preserving an existing skill's established convention.
- Do not add backward-compatibility instructions unless installed configs, persisted files, or explicit user requirements need them.

## Handoff To Skill Creator

Use `skill-creator` when any of these are true:

- The user wants to test whether the skill works.
- The user wants eval prompts, baselines, reviewer output, or quantitative grading.
- The routing description changed and needs trigger evals.
- The user wants the skill packaged for installation.
- Feedback from trial runs needs to be incorporated into another iteration.

When handing off, summarize the current skill path, intended behavior, positive triggers, near-miss negatives, forbidden loads, progressive-read checks, and any open questions.
