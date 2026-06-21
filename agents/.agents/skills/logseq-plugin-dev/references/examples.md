# Logseq Plugin Examples

## Basic Slash Command
```javascript
logseq.Editor.registerSlashCommand('Hello World', async () => {
  await logseq.Editor.insertAtEditingCursor('Hello from the plugin! 🚀');
});
```

## Adding a Toolbar Icon
```javascript
logseq.App.registerUIItem('toolbar', {
  key: 'my-plugin-button',
  template: `
    <a class="button" data-on-click="toggleApp">
      <i class="ti ti-activity"></i>
    </a>
  `,
});

logseq.provideModel({
  toggleApp() {
    logseq.showMainUI();
  }
});
```

## Recursive Block Transformer (Mind Map style)
```javascript
async function transformToTree(blocks) {
  return blocks.map(block => {
    return {
      label: block.content.split('\n')[0], // Use first line as label
      children: block.children ? transformToTree(block.children) : []
    };
  });
}

// Usage
const tree = await transformToTree(await logseq.Editor.getCurrentPageBlocksTree());
```

## Keyboard Shortcuts
```javascript
logseq.App.registerCommandPalette({
  key: 'my-plugin-action',
  label: 'Trigger Plugin Action',
  keybinding: {
    binding: 'ctrl+shift+p'
  }
}, async () => {
  logseq.App.showMsg('Action Triggered!');
});
```
