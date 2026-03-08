# Compatibility

## Tested Baseline
- OpenClaw: 2026.3.x
- Provider: `openai-codex/gpt-5.3-codex`
- Sandbox image tag: `coder-sandbox:latest`
- Host expectation: Docker available and functional

## Notes
- The public package is intentionally OpenClaw-only for v1.
- If your OpenClaw installation injects a different prompt file set, keep `SOUL.md` as the source of truth.
- If you extend the sandbox image with extra language runtimes, keep the default JSON contract unchanged.
