import "@logseq/libs";
import React from "react";
import ReactDOM from "react-dom/client";

function App() {
  return (
    <div style={{ padding: '20px', background: 'var(--ls-primary-background-color)', color: 'var(--ls-primary-text-color)' }}>
      <h1>Hello Logseq + React!</h1>
      <button onClick={() => logseq.hideMainUI()}>Close UI</button>
    </div>
  );
}

function main() {
  const root = ReactDOM.createRoot(document.getElementById("app")!);
  root.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>
  );

  logseq.provideModel({
    show() {
      logseq.showMainUI();
    },
  });

  logseq.App.registerUIItem("toolbar", {
    key: "open-react-ui",
    template: `
      <a data-on-click="show">
        <span style="font-size: 20px;">⚛️</span>
      </a>
    `,
  });
}

logseq.ready(main).catch(console.error);
