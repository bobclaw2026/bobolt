import Foundation
import Testing
@testable import Bobolt

@Suite(.serialized)
struct BoboltConfigFileTests {
    @Test
    func configPathRespectsEnvOverride() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("bobolt-config-\(UUID().uuidString)")
            .appendingPathComponent("bobolt.json")
            .path

        await TestIsolation.withEnvValues(["OPENCLAW_CONFIG_PATH": override]) {
            #expect(BoboltConfigFile.url().path == override)
        }
    }

    @MainActor
    @Test
    func remoteGatewayPortParsesAndMatchesHost() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("bobolt-config-\(UUID().uuidString)")
            .appendingPathComponent("bobolt.json")
            .path

        await TestIsolation.withEnvValues(["OPENCLAW_CONFIG_PATH": override]) {
            BoboltConfigFile.saveDict([
                "gateway": [
                    "remote": [
                        "url": "ws://gateway.ts.net:19999",
                    ],
                ],
            ])
            #expect(BoboltConfigFile.remoteGatewayPort() == 19999)
            #expect(BoboltConfigFile.remoteGatewayPort(matchingHost: "gateway.ts.net") == 19999)
            #expect(BoboltConfigFile.remoteGatewayPort(matchingHost: "gateway") == 19999)
            #expect(BoboltConfigFile.remoteGatewayPort(matchingHost: "other.ts.net") == nil)
        }
    }

    @MainActor
    @Test
    func setRemoteGatewayUrlPreservesScheme() async {
        let override = FileManager().temporaryDirectory
            .appendingPathComponent("bobolt-config-\(UUID().uuidString)")
            .appendingPathComponent("bobolt.json")
            .path

        await TestIsolation.withEnvValues(["OPENCLAW_CONFIG_PATH": override]) {
            BoboltConfigFile.saveDict([
                "gateway": [
                    "remote": [
                        "url": "wss://old-host:111",
                    ],
                ],
            ])
            BoboltConfigFile.setRemoteGatewayUrl(host: "new-host", port: 2222)
            let root = BoboltConfigFile.loadDict()
            let url = ((root["gateway"] as? [String: Any])?["remote"] as? [String: Any])?["url"] as? String
            #expect(url == "wss://new-host:2222")
        }
    }

    @Test
    func stateDirOverrideSetsConfigPath() async {
        let dir = FileManager().temporaryDirectory
            .appendingPathComponent("bobolt-state-\(UUID().uuidString)", isDirectory: true)
            .path

        await TestIsolation.withEnvValues([
            "OPENCLAW_CONFIG_PATH": nil,
            "OPENCLAW_STATE_DIR": dir,
        ]) {
            #expect(BoboltConfigFile.stateDirURL().path == dir)
            #expect(BoboltConfigFile.url().path == "\(dir)/bobolt.json")
        }
    }
}
