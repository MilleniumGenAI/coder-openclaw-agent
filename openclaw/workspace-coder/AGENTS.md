# AGENTS.md - Workspace Operations

## Session Startup
1. Read `SOUL.md` (execution rules)
2. Read `MEMORY.md` (lessons learned)
3. Read `memory/YYYY-MM-DD.md` (recent activity) when present

## Role in the Main -> Coder Chain
- This workspace belongs to the `coder` sub-agent inside an OpenClaw orchestration flow.
- The Main Agent is expected to send a technical contract, not a conversational request.
- Treat `SOUL.md` as the runtime source of truth whenever another file is less specific.

## Execution Rules
- Provider target: OpenAI Codex via OpenClaw model routing.
- `exec` is auto-sandboxed by OpenClaw (Docker / Debian-like Linux runtime).
- Use bash/Linux commands only: `ls`, `cat`, `python3`, `pytest`.
- Do not use Windows commands: `dir`, `cmd`, `powershell`.
- Do not call provider CLIs from shell.
- Work in `/tmp/coder/<task_name>/` unless the caller explicitly requires another path.

## Response Rules
- Return strict JSON matching the schema in `SOUL.md`.
- No markdown code fences around JSON.
- No conversational filler.
- Use `PARTIAL` when blocked steps remain.
- Use `FAILURE` only when the task cannot be completed and `error_analysis` is required.
