---
summary: "CLI reference for `bobolt agent` (send one agent turn via the Gateway)"
read_when:
  - You want to run one agent turn from scripts (optionally deliver reply)
title: "agent"
---

# `bobolt agent`

Run an agent turn via the Gateway (use `--local` for embedded).
Use `--agent <id>` to target a configured agent directly.

Related:

- Agent send tool: [Agent send](/tools/agent-send)

## Examples

```bash
bobolt agent --to +15555550123 --message "status update" --deliver
bobolt agent --agent ops --message "Summarize logs"
bobolt agent --session-id 1234 --message "Summarize inbox" --thinking medium
bobolt agent --agent ops --message "Generate report" --deliver --reply-channel slack --reply-to "#reports"
```
