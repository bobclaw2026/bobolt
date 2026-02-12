import Foundation

// Stable identifier used for both the macOS LaunchAgent label and Nix-managed defaults suite.
// nix-bobolt writes app defaults into this suite to survive app bundle identifier churn.
let launchdLabel = "ai.bobolt.mac"
let gatewayLaunchdLabel = "ai.bobolt.gateway"
let onboardingVersionKey = "bobolt.onboardingVersion"
let onboardingSeenKey = "bobolt.onboardingSeen"
let currentOnboardingVersion = 7
let pauseDefaultsKey = "bobolt.pauseEnabled"
let iconAnimationsEnabledKey = "bobolt.iconAnimationsEnabled"
let swabbleEnabledKey = "bobolt.swabbleEnabled"
let swabbleTriggersKey = "bobolt.swabbleTriggers"
let voiceWakeTriggerChimeKey = "bobolt.voiceWakeTriggerChime"
let voiceWakeSendChimeKey = "bobolt.voiceWakeSendChime"
let showDockIconKey = "bobolt.showDockIcon"
let defaultVoiceWakeTriggers = ["bobolt"]
let voiceWakeMaxWords = 32
let voiceWakeMaxWordLength = 64
let voiceWakeMicKey = "bobolt.voiceWakeMicID"
let voiceWakeMicNameKey = "bobolt.voiceWakeMicName"
let voiceWakeLocaleKey = "bobolt.voiceWakeLocaleID"
let voiceWakeAdditionalLocalesKey = "bobolt.voiceWakeAdditionalLocaleIDs"
let voicePushToTalkEnabledKey = "bobolt.voicePushToTalkEnabled"
let talkEnabledKey = "bobolt.talkEnabled"
let iconOverrideKey = "bobolt.iconOverride"
let connectionModeKey = "bobolt.connectionMode"
let remoteTargetKey = "bobolt.remoteTarget"
let remoteIdentityKey = "bobolt.remoteIdentity"
let remoteProjectRootKey = "bobolt.remoteProjectRoot"
let remoteCliPathKey = "bobolt.remoteCliPath"
let canvasEnabledKey = "bobolt.canvasEnabled"
let cameraEnabledKey = "bobolt.cameraEnabled"
let systemRunPolicyKey = "bobolt.systemRunPolicy"
let systemRunAllowlistKey = "bobolt.systemRunAllowlist"
let systemRunEnabledKey = "bobolt.systemRunEnabled"
let locationModeKey = "bobolt.locationMode"
let locationPreciseKey = "bobolt.locationPreciseEnabled"
let peekabooBridgeEnabledKey = "bobolt.peekabooBridgeEnabled"
let deepLinkKeyKey = "bobolt.deepLinkKey"
let modelCatalogPathKey = "bobolt.modelCatalogPath"
let modelCatalogReloadKey = "bobolt.modelCatalogReload"
let cliInstallPromptedVersionKey = "bobolt.cliInstallPromptedVersion"
let heartbeatsEnabledKey = "bobolt.heartbeatsEnabled"
let debugPaneEnabledKey = "bobolt.debugPaneEnabled"
let debugFileLogEnabledKey = "bobolt.debug.fileLogEnabled"
let appLogLevelKey = "bobolt.debug.appLogLevel"
let voiceWakeSupported: Bool = ProcessInfo.processInfo.operatingSystemVersion.majorVersion >= 26
