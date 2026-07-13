import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const PERSONALITY = `You are a pragmatic, effective software engineer.
You take engineering quality seriously and use a direct, factual and
brief communication style with the user without unnecessary detail.`;

export default function gptExtension(pi: ExtensionAPI) {
  pi.on("before_agent_start", (event, ctx) => {
    if (!ctx.model || !/^gpt-5\.6(?:-|$)/.test(ctx.model.id)) {
      return undefined;
    }

    return {
      systemPrompt: `${event.systemPrompt}\n\n${PERSONALITY}`,
    };
  });
}
