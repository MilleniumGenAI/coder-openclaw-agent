## When Main Must Delegate to `coder`

Use `coder` for any task involving:

- code writing or code edits;
- code execution;
- tests, lint-like verification, or technical validation;
- parsing, data transformation, or data-analysis tasks;
- bug fixing, small project scaffolding, or reproducible sandbox execution.

Main should stay focused on:

- user interaction;
- high-level orchestration;
- turning user requests into technical contracts;
- validating and presenting `coder` outputs.

Main should not do coding work directly if `coder` can do it.

## Core Main-Agent Rules

- Treat `coder` as a machine-to-machine sub-agent, not a conversational assistant.
- Write sub-agent directives in English.
- Always instruct `coder` to return strict JSON matching its `SOUL.md` schema.
- Use a concrete technical contract with inputs, constraints, and success criteria.
- Do not assume success without verification artifacts.

## Required Prompt Shape

Use this shape when delegating:

```text
Return strictly valid JSON matching coder SOUL schema.

GOAL:
<task>

INPUTS:
<files, data, user request>

CONSTRAINTS:
- Work only in /tmp/coder/<task_name> unless explicitly told otherwise.
- Use python3 and Linux/bash commands only.
- Do not hallucinate missing files or data.
- Use PARTIAL if blocked.

SUCCESS CRITERIA:
<tests, commands, or output conditions>

DELIVERABLES:
- codeblocks for created/changed files
- sandbox_log with verification output
- self_corrections when applicable
```

## Runtime Expectations Main Must Respect

Main should assume that `coder`:

- runs through OpenClaw `exec` in a Docker Linux sandbox;
- uses bash/Linux commands, not Windows shell commands;
- treats `/tmp/coder/<task_name>/` as the default working area;
- may return `PARTIAL` when blocked, instead of faking completion.

Main should not ask `coder` to:

- use provider CLIs from shell;
- work in Windows shell syntax;
- write into the main workspace unless explicitly required;
- recursively spawn more sub-agents.

## Expected Output Contract

Main should expect a JSON object containing at least:

- `status` = `SUCCESS | PARTIAL | FAILURE`
- `task_summary`
- `iterations_used`
- `steps_total`
- `steps_completed`
- `steps_blocked`
- `codeblocks`
- `sandbox_log`
- `self_corrections`
- `error_analysis`

Do not expect conversational explanations. Trust the structured payload.

## Result Processing Rules

1. Save the raw sub-agent output.
2. Run JSON extraction/cleanup with a strict host-side JSON validator or extraction helper.
3. Parse the cleaned JSON only.
4. Process by status:
   - `SUCCESS`: deliver the verified result.
   - `PARTIAL`: present partial deliverables and clearly surface blockers.
   - `FAILURE`: analyze the error details before deciding the next move.

## Retry Rules

- Do not blindly respawn `coder` with the same unchanged prompt.
- You may issue one correction prompt if the only problem is invalid JSON formatting.
- If `coder` still fails after one correction, stop and report the technical roadblock.
- If `coder` reports a persistent environment/runtime problem, escalate it instead of looping.

## Quality Rules for Main

- Ask `coder` for explicit verification whenever the task can be tested.
- Prefer exact file/data inputs over vague descriptions.
- If a file may be missing, state that hallucination is forbidden.
- If the task is high-risk or multi-step, make success criteria explicit before execution.
- Keep the orchestration layer thin: main should specify, validate, and present, not duplicate implementation logic.
