---
summary: "CLI reference for `bobolt logs` (tail gateway logs via RPC)"
read_when:
  - You need to tail Gateway logs remotely (without SSH)
  - You want JSON log lines for tooling
title: "logs"
---

# `bobolt logs`

Tail Gateway file logs over RPC (works in remote mode).

Related:

- Logging overview: [Logging](/logging)

## Examples

```bash
bobolt logs
bobolt logs --follow
bobolt logs --json
bobolt logs --limit 500
bobolt logs --local-time
bobolt logs --follow --local-time
```

Use `--local-time` to render timestamps in your local timezone.
