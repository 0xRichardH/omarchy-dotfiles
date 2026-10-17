# pstack model configuration. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` or `auto` as a value: the role runs on the parent chat model (omit the subagent `model`). Alias entries in a panel list still count toward its fan-out.
# budget: medium (high)
feature, refactoring: grok-4.7
bug-fix: grok-4.7
perf-issue: grok-4.7
hillclimb: grok-4.7
judgment and prose: gpt-6.1-sol
hardest tasks: gpt-6.1-sol
how explorer: grok-4.7
how explainer: gpt-6.1-sol
why investigators: grok-4.7
why synthesizer: gpt-6.1-sol
reflect tooling: grok-4.7
reflect judgment, divergent, synthesizer: gpt-6.1-sol
arena runners: gpt-6.1-sol, grok-4.7
arena cross-judge pool: gpt-6.1-sol, grok-4.7
swarm workers: grok-4.7
architect runners: gpt-6.1-sol, grok-4.7
interrogate reviewers: gpt-6.1-sol, grok-4.7
