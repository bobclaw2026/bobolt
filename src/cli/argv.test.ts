import { describe, expect, it } from "vitest";
import {
  buildParseArgv,
  getFlagValue,
  getCommandPath,
  getPrimaryCommand,
  getPositiveIntFlagValue,
  getVerboseFlag,
  hasHelpOrVersion,
  hasFlag,
  shouldMigrateState,
  shouldMigrateStateFromPath,
} from "./argv.js";

describe("argv helpers", () => {
  it("detects help/version flags", () => {
    expect(hasHelpOrVersion(["node", "bobolt", "--help"])).toBe(true);
    expect(hasHelpOrVersion(["node", "bobolt", "-V"])).toBe(true);
    expect(hasHelpOrVersion(["node", "bobolt", "status"])).toBe(false);
  });

  it("extracts command path ignoring flags and terminator", () => {
    expect(getCommandPath(["node", "bobolt", "status", "--json"], 2)).toEqual(["status"]);
    expect(getCommandPath(["node", "bobolt", "agents", "list"], 2)).toEqual(["agents", "list"]);
    expect(getCommandPath(["node", "bobolt", "status", "--", "ignored"], 2)).toEqual(["status"]);
  });

  it("returns primary command", () => {
    expect(getPrimaryCommand(["node", "bobolt", "agents", "list"])).toBe("agents");
    expect(getPrimaryCommand(["node", "bobolt"])).toBeNull();
  });

  it("parses boolean flags and ignores terminator", () => {
    expect(hasFlag(["node", "bobolt", "status", "--json"], "--json")).toBe(true);
    expect(hasFlag(["node", "bobolt", "--", "--json"], "--json")).toBe(false);
  });

  it("extracts flag values with equals and missing values", () => {
    expect(getFlagValue(["node", "bobolt", "status", "--timeout", "5000"], "--timeout")).toBe(
      "5000",
    );
    expect(getFlagValue(["node", "bobolt", "status", "--timeout=2500"], "--timeout")).toBe(
      "2500",
    );
    expect(getFlagValue(["node", "bobolt", "status", "--timeout"], "--timeout")).toBeNull();
    expect(getFlagValue(["node", "bobolt", "status", "--timeout", "--json"], "--timeout")).toBe(
      null,
    );
    expect(getFlagValue(["node", "bobolt", "--", "--timeout=99"], "--timeout")).toBeUndefined();
  });

  it("parses verbose flags", () => {
    expect(getVerboseFlag(["node", "bobolt", "status", "--verbose"])).toBe(true);
    expect(getVerboseFlag(["node", "bobolt", "status", "--debug"])).toBe(false);
    expect(getVerboseFlag(["node", "bobolt", "status", "--debug"], { includeDebug: true })).toBe(
      true,
    );
  });

  it("parses positive integer flag values", () => {
    expect(getPositiveIntFlagValue(["node", "bobolt", "status"], "--timeout")).toBeUndefined();
    expect(
      getPositiveIntFlagValue(["node", "bobolt", "status", "--timeout"], "--timeout"),
    ).toBeNull();
    expect(
      getPositiveIntFlagValue(["node", "bobolt", "status", "--timeout", "5000"], "--timeout"),
    ).toBe(5000);
    expect(
      getPositiveIntFlagValue(["node", "bobolt", "status", "--timeout", "nope"], "--timeout"),
    ).toBeUndefined();
  });

  it("builds parse argv from raw args", () => {
    const nodeArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node", "bobolt", "status"],
    });
    expect(nodeArgv).toEqual(["node", "bobolt", "status"]);

    const versionedNodeArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node-22", "bobolt", "status"],
    });
    expect(versionedNodeArgv).toEqual(["node-22", "bobolt", "status"]);

    const versionedNodeWindowsArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node-22.2.0.exe", "bobolt", "status"],
    });
    expect(versionedNodeWindowsArgv).toEqual(["node-22.2.0.exe", "bobolt", "status"]);

    const versionedNodePatchlessArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node-22.2", "bobolt", "status"],
    });
    expect(versionedNodePatchlessArgv).toEqual(["node-22.2", "bobolt", "status"]);

    const versionedNodeWindowsPatchlessArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node-22.2.exe", "bobolt", "status"],
    });
    expect(versionedNodeWindowsPatchlessArgv).toEqual(["node-22.2.exe", "bobolt", "status"]);

    const versionedNodeWithPathArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["/usr/bin/node-22.2.0", "bobolt", "status"],
    });
    expect(versionedNodeWithPathArgv).toEqual(["/usr/bin/node-22.2.0", "bobolt", "status"]);

    const nodejsArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["nodejs", "bobolt", "status"],
    });
    expect(nodejsArgv).toEqual(["nodejs", "bobolt", "status"]);

    const nonVersionedNodeArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["node-dev", "bobolt", "status"],
    });
    expect(nonVersionedNodeArgv).toEqual(["node", "bobolt", "node-dev", "bobolt", "status"]);

    const directArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["bobolt", "status"],
    });
    expect(directArgv).toEqual(["node", "bobolt", "status"]);

    const bunArgv = buildParseArgv({
      programName: "bobolt",
      rawArgs: ["bun", "src/entry.ts", "status"],
    });
    expect(bunArgv).toEqual(["bun", "src/entry.ts", "status"]);
  });

  it("builds parse argv from fallback args", () => {
    const fallbackArgv = buildParseArgv({
      programName: "bobolt",
      fallbackArgv: ["status"],
    });
    expect(fallbackArgv).toEqual(["node", "bobolt", "status"]);
  });

  it("decides when to migrate state", () => {
    expect(shouldMigrateState(["node", "bobolt", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "bobolt", "health"])).toBe(false);
    expect(shouldMigrateState(["node", "bobolt", "sessions"])).toBe(false);
    expect(shouldMigrateState(["node", "bobolt", "memory", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "bobolt", "agent", "--message", "hi"])).toBe(false);
    expect(shouldMigrateState(["node", "bobolt", "agents", "list"])).toBe(true);
    expect(shouldMigrateState(["node", "bobolt", "message", "send"])).toBe(true);
  });

  it("reuses command path for migrate state decisions", () => {
    expect(shouldMigrateStateFromPath(["status"])).toBe(false);
    expect(shouldMigrateStateFromPath(["agents", "list"])).toBe(true);
  });
});
