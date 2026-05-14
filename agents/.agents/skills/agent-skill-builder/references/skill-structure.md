# Skill Structure

Use this reference when splitting an overlong skill, choosing where content belongs, or adding metadata.

## Context Budget

Skills pay context in three tiers:

- Index: `name` and `description` are always visible. Keep descriptions short, usually 50 words or fewer.
- Load: `SKILL.md` stays in context after the skill loads. Keep it lean enough that every sentence earns its place.
- Runtime files: `scripts/`, `references/`, `assets/`, subskills, and config are paid only when read or executed.

Target `SKILL.md` under roughly 5,000 tokens; split sooner if conditional material grows. Spend tokens where they change behavior. Delete obvious tool instructions, broad explanations, stale API trivia, and content already covered by global instructions.

## Progressive Disclosure

Use the skill directory as a hierarchy:

- `SKILL.md`: routing-adjacent workflow, durable judgment, and gotchas.
- `scripts/`: deterministic helpers the agent would otherwise recreate.
- `references/`: long docs, APIs, edge cases, and domain material loaded only when needed.
- `assets/`: templates, examples, schemas, starter files, and static resources.
- `config.json`: first-run setup or persistent user choices when supported by the runtime.

Add bundled resources only when they reduce repeated work or keep expensive context out of the main skill body.

For large domains, use nested hierarchy instead of one flat file list. Group topics into a small number of obvious categories, add short index files when needed, and give the agent clear pointers for which branch to read. If the model must choose among hundreds of files, add a quick reference or search helper.

## Format And Metadata

The root `SKILL.md` frontmatter must include `name` and `description`. The `name` must match the directory, use lowercase letters, and prefer hyphens over spaces.

Use optional fields sparingly:

- `depends:` for skills that must load together when the runtime supports dependency loading and when nearly every invocation needs both skills.
- `metadata:` for owner, review, eval coverage, or lifecycle data needed by humans or tooling.
- Auxiliary JSON or YAML for runtime details that should not pollute model context.

When frontmatter carries tool-only data, account for whether the agent runtime strips it before loading the body.

Do not add `depends: skill-creator` to a skill merely because `skill-creator` may be useful later. Prefer an explicit handoff when only evals, packaging, or trigger-description optimization need it.
