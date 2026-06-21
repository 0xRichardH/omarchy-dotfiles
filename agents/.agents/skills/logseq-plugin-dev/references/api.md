# Logseq Plugin API Reference

## `logseq.App`
General application-level operations.

- `showMsg(msg, type)`: Shows a toast message.
- `onThemeModeChanged(callback)`: Listen for dark/light mode switches.
- `registerCommandPalette(config, callback)`: Add to command palette (Cmd+Shift+P).
- `getUserConfigs()`: Get current graph and user settings.

## `logseq.Editor`
Block and page manipulation.

- `getCurrentPageBlocksTree()`: Get all blocks on the current page.
- `insertBlock(parentBlockId, content, options)`: Insert a new block.
- `updateBlock(blockId, content)`: Update block text.
- `registerSlashCommand(name, callback)`: Add a `/` command.
- `onBlockChanged(callback)`: Listen for block edits.

## `logseq.DB`
Data querying using Datalog/Datascript.

- `datascriptQuery(query, ...inputs)`: Execute a raw Datalog query.
- `q(query)`: Shorthand for simple queries.

## `logseq.UI`
Custom UI injection.

- `provideUI(config)`: Inject HTML into specific locations (toolbar, sidebar, block).
- `showMainUI()`: Open the main plugin iframe.
- `hideMainUI()`: Close the main plugin iframe.
- `provideStyle(css)`: Inject custom CSS into the main app.

## `logseq.FileStorage`
Persistent storage for plugin data.

- `getItem(key)`: Retrieve a value.
- `setItem(key, value)`: Store a value.
