# mcporter Code Generation & API

## Generate CLI from MCP Server

```bash
npx mcporter generate-cli --server <name>
npx mcporter generate-cli --command <url>
npx mcporter generate-cli <server> --bundle dist/
npx mcporter generate-cli <server> --compile  # Bun-compiled binary
```

## Generate TypeScript Types

```bash
npx mcporter emit-ts <server> --mode types        # .d.ts interface only
npx mcporter emit-ts <server> --mode client        # .d.ts + client wrapper
npx mcporter emit-ts <server> --include-optional   # Include all optional fields
```

## Inspect Generated CLI

```bash
npx mcporter inspect-cli <path>           # Human-readable summary
npx mcporter generate-cli --from <path>   # Regenerate from metadata
```

## TypeScript API

### One-shot Calls

```ts
import { callOnce } from 'mcporter';

const result = await callOnce({
  server: 'context7',
  toolName: 'resolve-library-id',
  args: { query: 'React hooks docs', libraryName: 'react' },
});
console.log(result);
```

### Runtime API

```ts
import { createRuntime, createServerProxy } from 'mcporter';

const runtime = await createRuntime();
const tools = await runtime.listTools('context7');
const result = await runtime.callTool('context7', 'resolve-library-id', {
  args: { query: 'React hooks docs', libraryName: 'react' },
});
await runtime.close();
```

### Server Proxy

```ts
const chrome = createServerProxy(runtime, 'chrome-devtools');
const snapshot = await chrome.takeSnapshot();
console.log(snapshot.text());     // Plain text
console.log(snapshot.json());     // Parsed JSON
console.log(snapshot.markdown()); // Markdown format
```

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `MCPORTER_CONFIG` | Default config path |
| `MCPORTER_LOG_LEVEL` | debug/info/warn/error |
| `MCPORTER_LIST_TIMEOUT` | List timeout (ms) |
| `MCPORTER_CALL_TIMEOUT` | Call timeout (ms) |
| `MCPORTER_OAUTH_TIMEOUT_MS` | OAuth browser timeout |
| `MCPORTER_OAUTH_NO_BROWSER` | Disable browser for OAuth |
| `MCPORTER_KEEPALIVE` | Force keep-alive for server |
| `MCPORTER_DISABLE_KEEPALIVE` | Force ephemeral for server |
