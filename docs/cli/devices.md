---
summary: "CLI reference for `bobolt devices` (device pairing + token rotation/revocation)"
read_when:
  - You are approving device pairing requests
  - You need to rotate or revoke device tokens
title: "devices"
---

# `bobolt devices`

Manage device pairing requests and device-scoped tokens.

## Commands

### `bobolt devices list`

List pending pairing requests and paired devices.

```
bobolt devices list
bobolt devices list --json
```

### `bobolt devices approve <requestId>`

Approve a pending device pairing request.

```
bobolt devices approve <requestId>
```

### `bobolt devices reject <requestId>`

Reject a pending device pairing request.

```
bobolt devices reject <requestId>
```

### `bobolt devices rotate --device <id> --role <role> [--scope <scope...>]`

Rotate a device token for a specific role (optionally updating scopes).

```
bobolt devices rotate --device <deviceId> --role operator --scope operator.read --scope operator.write
```

### `bobolt devices revoke --device <id> --role <role>`

Revoke a device token for a specific role.

```
bobolt devices revoke --device <deviceId> --role node
```

## Common options

- `--url <url>`: Gateway WebSocket URL (defaults to `gateway.remote.url` when configured).
- `--token <token>`: Gateway token (if required).
- `--password <password>`: Gateway password (password auth).
- `--timeout <ms>`: RPC timeout.
- `--json`: JSON output (recommended for scripting).

Note: when you set `--url`, the CLI does not fall back to config or environment credentials.
Pass `--token` or `--password` explicitly. Missing explicit credentials is an error.

## Notes

- Token rotation returns a new token (sensitive). Treat it like a secret.
- These commands require `operator.pairing` (or `operator.admin`) scope.
