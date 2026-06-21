import '@logseq/libs';

async function main() {
  console.log('Logseq plugin loaded');
  
  logseq.Editor.registerSlashCommand('Hello', async () => {
    logseq.App.showMsg('Hello from Logseq Plugin!');
  });
}

logseq.ready(main).catch(console.error);
