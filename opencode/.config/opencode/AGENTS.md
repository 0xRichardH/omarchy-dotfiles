# Agent Guidelines

## Code Design Principles

### Single Responsibility Principle (SRP)

When planning to write code, you MUST respect the Single Responsibility Principle. Before implementing any solution:

1. **Analyze the task** - Understand what needs to be done
2. **Identify responsibilities** - Break down the functionality into distinct concerns
3. **Decide on structure** - Determine if you need to:
   - Refactor existing code into separate private functions
   - Extract functionality into separate files/modules
   - Create new abstractions to maintain clean separation

### Code Organization Rules

- **One responsibility per function** - Each function should do one thing well
- **One responsibility per module/file** - Each file should have a clear, single purpose
- **Extract when needed** - If a function or file is handling multiple concerns, refactor into separate units
- **Think before coding** - Always plan the structure before implementation
- **No backward compatibility** - Break old formats freely

### Decision Framework

Before writing code, ask yourself:
- Does this function/file have more than one reason to change?
- Can this be broken down into smaller, focused pieces?
- Should this logic live in a separate private function?
- Should this functionality be in its own file/module?

If the answer is yes to any of these, refactor accordingly.

## Git

- Sign commits for all git changes
