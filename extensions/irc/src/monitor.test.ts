import { describe, expect, it } from "vitest";
import { resolveIrcInboundTarget } from "./monitor.js";

describe("irc monitor inbound target", () => {
  it("keeps channel target for group messages", () => {
    expect(
      resolveIrcInboundTarget({
        target: "#bobolt",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: true,
      target: "#bobolt",
      rawTarget: "#bobolt",
    });
  });

  it("maps DM target to sender nick and preserves raw target", () => {
    expect(
      resolveIrcInboundTarget({
        target: "bobolt-bot",
        senderNick: "alice",
      }),
    ).toEqual({
      isGroup: false,
      target: "alice",
      rawTarget: "bobolt-bot",
    });
  });

  it("falls back to raw target when sender nick is empty", () => {
    expect(
      resolveIrcInboundTarget({
        target: "bobolt-bot",
        senderNick: " ",
      }),
    ).toEqual({
      isGroup: false,
      target: "bobolt-bot",
      rawTarget: "bobolt-bot",
    });
  });
});
