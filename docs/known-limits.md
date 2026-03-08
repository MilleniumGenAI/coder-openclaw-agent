# Known Limits

- Optimized for small-to-medium coding and data tasks, not large monorepo programs.
- Assumes Linux/bash semantics inside Docker; Windows shell commands are intentionally unsupported.
- Does not spawn its own sub-agents.
- Long-running tasks may exceed the practical timeout envelope of an agent turn.
- Additional language ecosystems may require extending the sandbox image.
- Strong orchestration quality still depends on the calling prompt from the main agent.
