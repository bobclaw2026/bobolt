---
summary: "CLI reference for `bobolt agents` (list/add/delete/set identity)"
read_when:
  - You want multiple isolated agents (workspaces + routing + auth)
title: "agents"
---

# `bobolt agents`

Manage isolated agents (workspaces + auth + routing).

Related:

- Multi-agent routing: [Multi-Agent Routing](/concepts/multi-agent)
- Agent workspace: [Agent workspace](/concepts/agent-workspace)

## Examples

```bash
bobolt agents list
bobolt agents add work --workspace ~/.bobolt/workspace-work
bobolt agents set-identity --workspace ~/.bobolt/workspace --from-identity
bobolt agents set-identity --agent main --avatar avatars/bobolt.png
bobolt agents delete work
```

## Identity files

Each agent workspace can include an `IDENTITY.md` at the workspace root:

- Example path: `~/.bobolt/workspace/IDENTITY.md`
- `set-identity --from-identity` reads from the workspace root (or an explicit `--identity-file`)

Avatar paths resolve relative to the workspace root.

## Set identity

`set-identity` writes fields into `agents.list[].identity`:

- `name`
- `theme`
- `emoji`
- `avatar` (workspace-relative path, http(s) URL, or data URI)

Load from `IDENTITY.md`:

```bash
bobolt agents set-identity --workspace ~/.bobolt/workspace --from-identity
```

Override fields explicitly:

```bash
bobolt agents set-identity --agent main --name "Bobolt" --emoji "🦞" --avatar avatars/bobolt.png
```

Config sample:

```json5
{
  agents: {
    list: [
      {
        id: "main",
        identity: {
          name: "Bobolt",
          theme: "space lobster",
          emoji: "🦞",
          avatar: "avatars/bobolt.png",
        },
      },
    ],
  },
}
```
