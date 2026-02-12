---
summary: "CLI reference for `bobolt reset` (reset local state/config)"
read_when:
  - You want to wipe local state while keeping the CLI installed
  - You want a dry-run of what would be removed
title: "reset"
---

# `bobolt reset`

Reset local config/state (keeps the CLI installed).

```bash
bobolt reset
bobolt reset --dry-run
bobolt reset --scope config+creds+sessions --yes --non-interactive
```
