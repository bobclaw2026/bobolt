import Foundation

public enum BoboltDeviceCommand: String, Codable, Sendable {
    case status = "device.status"
    case info = "device.info"
}

public enum BoboltBatteryState: String, Codable, Sendable {
    case unknown
    case unplugged
    case charging
    case full
}

public enum BoboltThermalState: String, Codable, Sendable {
    case nominal
    case fair
    case serious
    case critical
}

public enum BoboltNetworkPathStatus: String, Codable, Sendable {
    case satisfied
    case unsatisfied
    case requiresConnection
}

public enum BoboltNetworkInterfaceType: String, Codable, Sendable {
    case wifi
    case cellular
    case wired
    case other
}

public struct BoboltBatteryStatusPayload: Codable, Sendable, Equatable {
    public var level: Double?
    public var state: BoboltBatteryState
    public var lowPowerModeEnabled: Bool

    public init(level: Double?, state: BoboltBatteryState, lowPowerModeEnabled: Bool) {
        self.level = level
        self.state = state
        self.lowPowerModeEnabled = lowPowerModeEnabled
    }
}

public struct BoboltThermalStatusPayload: Codable, Sendable, Equatable {
    public var state: BoboltThermalState

    public init(state: BoboltThermalState) {
        self.state = state
    }
}

public struct BoboltStorageStatusPayload: Codable, Sendable, Equatable {
    public var totalBytes: Int64
    public var freeBytes: Int64
    public var usedBytes: Int64

    public init(totalBytes: Int64, freeBytes: Int64, usedBytes: Int64) {
        self.totalBytes = totalBytes
        self.freeBytes = freeBytes
        self.usedBytes = usedBytes
    }
}

public struct BoboltNetworkStatusPayload: Codable, Sendable, Equatable {
    public var status: BoboltNetworkPathStatus
    public var isExpensive: Bool
    public var isConstrained: Bool
    public var interfaces: [BoboltNetworkInterfaceType]

    public init(
        status: BoboltNetworkPathStatus,
        isExpensive: Bool,
        isConstrained: Bool,
        interfaces: [BoboltNetworkInterfaceType])
    {
        self.status = status
        self.isExpensive = isExpensive
        self.isConstrained = isConstrained
        self.interfaces = interfaces
    }
}

public struct BoboltDeviceStatusPayload: Codable, Sendable, Equatable {
    public var battery: BoboltBatteryStatusPayload
    public var thermal: BoboltThermalStatusPayload
    public var storage: BoboltStorageStatusPayload
    public var network: BoboltNetworkStatusPayload
    public var uptimeSeconds: Double

    public init(
        battery: BoboltBatteryStatusPayload,
        thermal: BoboltThermalStatusPayload,
        storage: BoboltStorageStatusPayload,
        network: BoboltNetworkStatusPayload,
        uptimeSeconds: Double)
    {
        self.battery = battery
        self.thermal = thermal
        self.storage = storage
        self.network = network
        self.uptimeSeconds = uptimeSeconds
    }
}

public struct BoboltDeviceInfoPayload: Codable, Sendable, Equatable {
    public var deviceName: String
    public var modelIdentifier: String
    public var systemName: String
    public var systemVersion: String
    public var appVersion: String
    public var appBuild: String
    public var locale: String

    public init(
        deviceName: String,
        modelIdentifier: String,
        systemName: String,
        systemVersion: String,
        appVersion: String,
        appBuild: String,
        locale: String)
    {
        self.deviceName = deviceName
        self.modelIdentifier = modelIdentifier
        self.systemName = systemName
        self.systemVersion = systemVersion
        self.appVersion = appVersion
        self.appBuild = appBuild
        self.locale = locale
    }
}
