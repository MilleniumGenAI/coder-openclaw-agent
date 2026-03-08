# ClawHub Packaging

This repository publishes to ClawHub through the skill folder:

- `clawhub/coder-openclaw-agent/`

## Target
- Skill name: `Coder for OpenClaw`
- Skill slug: `coder-openclaw-agent`
- Current version: `0.1.2`

## Publish Root
Use `clawhub/coder-openclaw-agent/` as the publish root when running:

```bash
clawhub publish clawhub/coder-openclaw-agent --slug coder-openclaw-agent --name "Coder for OpenClaw" --version 0.1.2 --tags latest
```

## Checklist
- `VERSION` matches the skill version.
- `SKILL.md` has valid YAML frontmatter.
- The skill points to the public GitHub repository and avoids conflicting per-skill license terms.
- `metadata.openclaw.requires` reflects the actual tools referenced by the skill.
- The installation flow relies on relative repository paths and public docs, not on private local state.
- `openclaw models status --agent coder --probe --probe-provider openai-codex --json`
- `openclaw sandbox explain --agent coder`
- One successful coding smoke task.
- One blocked-input smoke task with honest `PARTIAL` or `FAILURE`.

## Expected Result
After publication, ClawHub users should be able to discover the skill, open `SKILL.md`, and follow a compact OpenClaw-specific integration flow that links back to this repository for the full prompt pack and runtime docs.