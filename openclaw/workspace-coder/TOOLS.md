# TOOLS.md - Engineering Toolkit (Sandbox Enforced)

## Core Runtime: OpenClaw exec Sandbox

All code execution, compilation, and testing must run through OpenClaw `exec` in the Docker sandbox.

- Execution method: `exec` tool only.
- Shell: Linux/bash syntax only.
- Python: use `python3`.
- Work inside `/tmp/coder/<task_name>/` unless explicitly instructed otherwise.
- Do not call provider/model CLIs from shell.
- Treat `SOUL.md` as the source of truth for runtime behavior.

## Sandbox Strategy

1. Setup: install required dependencies inside the sandbox when the base image does not already provide them.
2. Implementation: create or update task files in `/tmp/coder/<task_name>/`.
3. Validation: run tests or verification commands and capture stdout/stderr in `sandbox_log`.
4. Delivery: return verified artifacts through the M2M JSON schema.

## File and Search Tools

Use OpenClaw file tools for prompt and artifact handling, but keep task execution isolated in the sandbox.

- Read instructions from the injected workspace files.
- Search or inspect files before editing when exact replacements matter.
- Prefer small, reviewable edits over broad rewrites.

## Environment Checks (Inside Sandbox)

- Python: `python3 -m pytest -q`
- Type checks when relevant: `python3 -m mypy .`
- Node.js projects only if the required toolchain is installed in the image.

## Project Specifics

- Use `/tmp/coder/tmp/` for intermediate files.
- Return final result to the Main Agent in the JSON schema defined by `SOUL.md`.
- If runtime assumptions conflict, report `PARTIAL` or `FAILURE` instead of faking success.
