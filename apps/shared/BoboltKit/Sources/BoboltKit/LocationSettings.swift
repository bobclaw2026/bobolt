import Foundation

public enum BoboltLocationMode: String, Codable, Sendable, CaseIterable {
    case off
    case whileUsing
    case always
}
