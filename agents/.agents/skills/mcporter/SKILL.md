---
name: mcporter
description: "Load when the user wants to call MCP tools, list MCP servers, manage MCP configuration, or interact with Model Context Protocol servers. Triggers include 'call MCP', 'list MCP servers', 'mcporter', 'MCP tool', 'run MCP', 'configure MCP'. Also load for ad-hoc MCP calls, OAuth setup, or code generation from MCP servers."
---

# mcporter

CLI for calling MCP servers directly. Use `npx mcporter` — no global install required.

## Quick Start

```bash
npx mcporter list                           # List all configured servers
npx mcporter list <server>                  # Show server tools with signatures
npx mcporter call <server>.<tool> key=val   # Call a tool
npx mcporter config list                    # Show current configuration
```

## Configuration

Default config: `$HOME/.config/mcporter/mcporter.json` (override with `--config <path>` or `MCPORTER_CONFIG`).

Config supports JSONC (comments, trailing commas). Manage via CLI:

```bash
npx mcporter config add <name> <url>              # Add HTTP server
npx mcporter config add <name> --command "npx ..." # Add stdio server
npx mcporter config remove <name>                 # Remove server
npx mcporter config import <kind> --copy          # Import from editors
```

Env var interpolation in config: `${VAR}`, `${VAR:-fallback}`, `$env:VAR`. Secrets in `headers`, `env`, `bearerTokenEnv` resolve lazily at runtime.

## Calling Tools

### Syntax

```bash
npx mcporter call linear.create_comment issueId:ENG-123 body:'Looks good!'  # Colon
npx mcporter call linear.create_comment issueId=ENG-123 body='Looks good!'  # Equals
npx mcporter call 'linear.create_issue(title: "Bug", team: "ENG")'          # Function
npx mcporter linear.list_issues                                              # Shorthand
npx mcporter call https://mcp.linear.app/mcp.list_issues                     # Full URL
npx mcporter call --stdio "bun run ./server.ts" scrape url=https://example.com  # Stdio
npx mcporter call <server>.<tool> --args '{"key": "value"}'                  # JSON
```

### Key Flags

| Flag | Purpose |
|------|---------|
| `--output json` | Machine-readable output |
| `--config <path>` | Custom config file |
| `--json` | JSON output for `list`, `auth` |
| `--schema` | Full tool schema for `list` |
| `--all-parameters` | Show all optional params |
| `--no-browser` | Headless OAuth |
| `--persist <file>` | Save ad-hoc server to config |
| `--` | Stop flag parsing |

## Auth

```bash
npx mcporter auth <server>              # Browser OAuth
npx mcporter auth <server> --no-browser # Headless (prints URL)
```

## Ad-hoc Servers

Call any MCP server without editing config:

```bash
npx mcporter list --http-url https://mcp.example.com/mcp --name my-server
npx mcporter call --stdio "npx -y some-mcp-server" tool_name arg=value
```

Add `--persist config/mcporter.json` to save for reuse.

## Daemon

Keep stateful servers alive between calls:

```bash
npx mcporter daemon start|status|stop|restart
```

Add `"lifecycle": "keep-alive"` to a server config entry.

## Code Generation

Read `references/codegen.md` for CLI generation, TypeScript types, and runtime API.

## Gotchas

- Tool names auto-correct from typos (`listIssues` → `list_issues`)
- Skip the verb: `npx mcporter firecrawl` runs `list firecrawl` automatically
- Dotted tokens dispatch to call: `npx mcporter linear.list_issues`
- `--` stops flag parsing for positional values starting with `--`
- OAuth requires a browser by default; use `--no-browser` for headless
- Stdio servers inherit shell environment; use `--env KEY=val` only for overrides
- Config resolution order: `--config` > `MCPORTER_CONFIG` > `./config/mcporter.json` > `~/.config/mcporter/mcporter.json`
- Secrets (`Authorization`, `env`) resolve at runtime, not at parse time
