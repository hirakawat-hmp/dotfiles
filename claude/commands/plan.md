---
description: Restate requirements, assess risks, and create step-by-step implementation plan. WAIT for user CONFIRM before touching any code.
---

# Plan Command

Invoke the **planner** agent to create a comprehensive implementation plan.

## Process

1. **Restate Requirements** - Clarify what needs to be built
2. **Identify Risks** - Surface potential issues and blockers
3. **Create Step Plan** - Break down implementation into phases
4. **Wait for Confirmation** - MUST receive user approval before proceeding

## When to Use

- Starting a new feature
- Significant architectural changes
- Complex refactoring
- Multiple files/components will be affected
- Requirements are unclear or ambiguous

## CRITICAL

The planner agent will **NOT** write any code until you explicitly confirm the plan.

Respond with:
- "yes" / "proceed" to start implementation
- "modify: [your changes]" to adjust the plan
- "different approach: [alternative]" for a new direction

## After Planning

- `/tdd` to implement with test-driven development
- `/code-review` to review completed implementation
- `/verify` to run comprehensive checks
