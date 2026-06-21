import reactPlugin from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import logseqDevPlugin from "vite-plugin-logseq";

export default defineConfig({
  plugins: [logseqDevPlugin(), reactPlugin()],
  build: {
    target: "esnext",
    minify: "esbuild",
  },
});
