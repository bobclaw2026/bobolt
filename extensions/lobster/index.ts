import type {
  AnyAgentTool,
  BoboltPluginApi,
  BoboltPluginToolFactory,
} from "../../src/plugins/types.js";
import { createLobsterTool } from "./src/lobster-tool.js";

export default function register(api: BoboltPluginApi) {
  api.registerTool(
    ((ctx) => {
      if (ctx.sandboxed) {
        return null;
      }
      return createLobsterTool(api) as AnyAgentTool;
    }) as BoboltPluginToolFactory,
    { optional: true },
  );
}
