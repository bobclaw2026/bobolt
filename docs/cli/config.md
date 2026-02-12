---
summary: "CLI reference for `bobolt config` (get/set/unset config values)"
read_when:
  - You want to read or edit config non-interactively
title: "config"
---

# `bobolt config`

Config helpers: get/set/unset values by path. Run without a subcommand to open
the configure wizard (same as `bobolt configure`).

## Examples

```bash
bobolt config get browser.executablePath
bobolt config set browser.executablePath "/usr/bin/google-chrome"
bobolt config set agents.defaults.heartbeat.every "2h"
bobolt config set agents.list[0].tools.exec.node "node-id-or-name"
bobolt config unset tools.web.search.apiKey
```

## Paths

Paths use dot or bracket notation:

```bash
bobolt config get agents.defaults.workspace
bobolt config get agents.list[0].id
```

Use the agent list index to target a specific agent:

```bash
bobolt config get agents.list
bobolt config set agents.list[1].tools.exec.node "node-id-or-name"
```

## Values

Values are parsed as JSON5 when possible; otherwise they are treated as strings.
Use `--json` to require JSON5 parsing.

```bash
bobolt config set agents.defaults.heartbeat.every "0m"
bobolt config set gateway.port 19001 --json
bobolt config set channels.whatsapp.groups '["*"]' --json
```

Restart the gateway after edits.
