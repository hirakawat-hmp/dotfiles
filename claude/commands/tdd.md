---
description: Enforce test-driven development workflow. Write tests FIRST, then implement minimal code to pass. Ensure 80%+ coverage.
---

# TDD Command

Invoke the **tdd-guide** agent to enforce test-driven development.

## Process

1. **Define Interfaces** - Types/interfaces first
2. **Write Failing Tests** (RED) - Tests that describe expected behavior
3. **Run Tests** - Verify they fail for the right reason
4. **Implement Minimal Code** (GREEN) - Just enough to pass
5. **Run Tests** - Verify they pass
6. **Refactor** (IMPROVE) - Clean up while keeping tests green
7. **Verify Coverage** - Ensure 80%+

## TDD Cycle

```
RED -> GREEN -> REFACTOR -> REPEAT
```

## When to Use

- Implementing new features
- Adding new functions/components
- Fixing bugs (write test that reproduces bug first)
- Refactoring existing code
- Building critical business logic

## MANDATORY Rules

- Tests MUST be written BEFORE implementation
- Tests MUST fail before writing code
- Implementation MUST be minimal to pass tests
- Refactoring MUST NOT break existing tests
- Coverage MUST be 80%+

## After TDD

- `/code-review` to review implementation
- `/verify` to run comprehensive checks
