import CoreLocation
import Foundation
import BoboltKit
import UIKit

protocol CameraServicing: Sendable {
    func listDevices() async -> [CameraController.CameraDeviceInfo]
    func snap(params: BoboltCameraSnapParams) async throws -> (format: String, base64: String, width: Int, height: Int)
    func clip(params: BoboltCameraClipParams) async throws -> (format: String, base64: String, durationMs: Int, hasAudio: Bool)
}

protocol ScreenRecordingServicing: Sendable {
    func record(
        screenIndex: Int?,
        durationMs: Int?,
        fps: Double?,
        includeAudio: Bool?,
        outPath: String?) async throws -> String
}

@MainActor
protocol LocationServicing: Sendable {
    func authorizationStatus() -> CLAuthorizationStatus
    func accuracyAuthorization() -> CLAccuracyAuthorization
    func ensureAuthorization(mode: BoboltLocationMode) async -> CLAuthorizationStatus
    func currentLocation(
        params: BoboltLocationGetParams,
        desiredAccuracy: BoboltLocationAccuracy,
        maxAgeMs: Int?,
        timeoutMs: Int?) async throws -> CLLocation
}

protocol DeviceStatusServicing: Sendable {
    func status() async throws -> BoboltDeviceStatusPayload
    func info() -> BoboltDeviceInfoPayload
}

protocol PhotosServicing: Sendable {
    func latest(params: BoboltPhotosLatestParams) async throws -> BoboltPhotosLatestPayload
}

protocol ContactsServicing: Sendable {
    func search(params: BoboltContactsSearchParams) async throws -> BoboltContactsSearchPayload
    func add(params: BoboltContactsAddParams) async throws -> BoboltContactsAddPayload
}

protocol CalendarServicing: Sendable {
    func events(params: BoboltCalendarEventsParams) async throws -> BoboltCalendarEventsPayload
    func add(params: BoboltCalendarAddParams) async throws -> BoboltCalendarAddPayload
}

protocol RemindersServicing: Sendable {
    func list(params: BoboltRemindersListParams) async throws -> BoboltRemindersListPayload
    func add(params: BoboltRemindersAddParams) async throws -> BoboltRemindersAddPayload
}

protocol MotionServicing: Sendable {
    func activities(params: BoboltMotionActivityParams) async throws -> BoboltMotionActivityPayload
    func pedometer(params: BoboltPedometerParams) async throws -> BoboltPedometerPayload
}

extension CameraController: CameraServicing {}
extension ScreenRecordService: ScreenRecordingServicing {}
extension LocationService: LocationServicing {}
