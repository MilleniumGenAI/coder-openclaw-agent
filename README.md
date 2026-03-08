# Coder for OpenClaw

`coder` is a coding-focused OpenClaw sub-agent for background code execution, test-driven edits, bug fixing, small project scaffolding, and small-to-medium data-analysis tasks.

## What This Project Includes
- A hardened `workspace-coder` prompt pack for OpenClaw.
- A Docker sandbox image definition for reproducible Linux-based execution.
- A practical document/data-processing runtime for HTML, PDF, spreadsheets, and office-style files.
- A minimal integration contract for wiring the agent into `openclaw.json`.

## Intended Scope (v1)
Supported:
- code execution and verification in the OpenClaw sandbox;
- bug fixing and test-driven edits;
- small project scaffolding;
- small-to-medium data-analysis tasks;
- HTML parsing and common document-processing tasks;
- honest blocked-state reporting through `PARTIAL` or `FAILURE`.

Out of scope:
- large monorepo refactors without tuning;
- long-running background jobs;
- multi-agent recursion;
- unsupported language/toolchain stacks unless you extend the image yourself.

## Requirements
- OpenClaw 2026.3.x or later.
- Docker available on the host.
- An authenticated `openai-codex` provider profile in your OpenClaw installation.

## Quickstart (10 minutes)
1. Clone or copy this repository to any local path.
2. Copy `openclaw/workspace-coder/` into your OpenClaw base directory, or point your agent config at that path directly.
3. Build the sandbox image:
   - `docker build -f docker/coder-sandbox.dockerfile -t coder-sandbox:latest .`
4. Register the agent in `openclaw.json` using `openclaw/agent-config.template.json` as a starting point.
5. Verify model access:
   - `openclaw models status --agent coder --probe --probe-provider openai-codex --json`
6. Verify sandbox wiring:
   - `openclaw sandbox explain --agent coder`
7. Run a first smoke task:
   - `openclaw agent --agent coder --json --message "Return strictly valid JSON matching coder SOUL schema. GOAL: create /tmp/coder/smoke/main.py that prints hello. INPUTS: none. CONSTRAINTS: work only in /tmp/coder/smoke; use python3 and Linux/bash commands only; use PARTIAL if blocked. SUCCESS CRITERIA: python3 /tmp/coder/smoke/main.py prints hello. DELIVERABLES: codeblocks and sandbox_log."`

## Required OpenClaw Workspace Files
The agent expects these injected prompt files:
- `AGENTS.md`
- `SOUL.md`
- `TOOLS.md`
- `IDENTITY.md`
- `MEMORY.md`
- `USER.md`
- `HEARTBEAT.md`

## Integration Contract
- Runtime source of truth: `openclaw/workspace-coder/SOUL.md`
- Sandbox image: `coder-sandbox:latest`
- Runtime style: Linux/bash only, `python3`, no provider CLIs from shell
- Working directory policy: `/tmp/coder/<task_name>/`
- Output schema: strict JSON with `status`, `task_summary`, `iterations_used`, `steps_total`, `steps_completed`, `steps_blocked`, `codeblocks`, `sandbox_log`, `self_corrections`, and `error_analysis`
- Main-agent prompt and orchestration rules: see `openclaw/main-coder-prompt.md`

## Runtime Stack
See `docker/RUNTIME.md` for the preinstalled tools and Python packages included in the default image.

## Validation Before Publishing
Recommended checks before publishing changes:
- `openclaw models status --agent coder --probe --probe-provider openai-codex --json`
- `openclaw sandbox explain --agent coder`
- at least one successful real coding smoke task through `openclaw agent --agent coder --json`
- one blocked-input task confirming honest `PARTIAL` or `FAILURE` behavior

## Known Limits
See `docs/known-limits.md`.

## Compatibility
See `docs/compatibility.md`.

## License
MIT
