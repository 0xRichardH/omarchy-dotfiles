# Routing Evals

Write routing evals before changing a skill description or adding a new skill body. A skill is only useful if it loads for the right requests and stays out of the way for adjacent ones.

## Eval Set

Start every new skill or description change with these cases:

- Positive triggers: realistic user phrasing that should load the skill.
- Near-miss negatives: related prompts that should use another skill or no skill.
- Forbidden loads: prompts where loading this skill would be harmful or noisy.
- Progressive-read checks: prompts that should cause the agent to read a specific `references/`, `assets/`, or `scripts/` file after the skill loads.

Use real user language, not keyword lists. Include casual phrasing, ambiguous requests, adjacent skills, and at least one prompt that should not load any skill.

## Description Changes

Treat the description as routing logic. Description changes can break other skills through off-target loading, so do not treat them as safe until evals cover the new boundary.

Good descriptions:

- Start with `Load when` or an equally direct trigger phrase.
- Stay short, usually 50 words or fewer.
- Include realistic user intents and phrases.
- Include boundaries when adjacent skills might otherwise conflict.

Avoid descriptions that explain every workflow step, advertise benefits, or use broad keywords that cause noisy loading.

## Formal Runs

Use `skill-creator` for formal runs, baselines, grading, review UI, packaging, and trigger-description optimization.

For production-critical skills, add end-to-end task evals with a rubric or LLM judge instead of relying only on routing checks.
