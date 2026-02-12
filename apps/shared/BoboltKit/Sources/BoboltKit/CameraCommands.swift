import Foundation

public enum BoboltCameraCommand: String, Codable, Sendable {
    case list = "camera.list"
    case snap = "camera.snap"
    case clip = "camera.clip"
}

public enum BoboltCameraFacing: String, Codable, Sendable {
    case back
    case front
}

public enum BoboltCameraImageFormat: String, Codable, Sendable {
    case jpg
    case jpeg
}

public enum BoboltCameraVideoFormat: String, Codable, Sendable {
    case mp4
}

public struct BoboltCameraSnapParams: Codable, Sendable, Equatable {
    public var facing: BoboltCameraFacing?
    public var maxWidth: Int?
    public var quality: Double?
    public var format: BoboltCameraImageFormat?
    public var deviceId: String?
    public var delayMs: Int?

    public init(
        facing: BoboltCameraFacing? = nil,
        maxWidth: Int? = nil,
        quality: Double? = nil,
        format: BoboltCameraImageFormat? = nil,
        deviceId: String? = nil,
        delayMs: Int? = nil)
    {
        self.facing = facing
        self.maxWidth = maxWidth
        self.quality = quality
        self.format = format
        self.deviceId = deviceId
        self.delayMs = delayMs
    }
}

public struct BoboltCameraClipParams: Codable, Sendable, Equatable {
    public var facing: BoboltCameraFacing?
    public var durationMs: Int?
    public var includeAudio: Bool?
    public var format: BoboltCameraVideoFormat?
    public var deviceId: String?

    public init(
        facing: BoboltCameraFacing? = nil,
        durationMs: Int? = nil,
        includeAudio: Bool? = nil,
        format: BoboltCameraVideoFormat? = nil,
        deviceId: String? = nil)
    {
        self.facing = facing
        self.durationMs = durationMs
        self.includeAudio = includeAudio
        self.format = format
        self.deviceId = deviceId
    }
}
