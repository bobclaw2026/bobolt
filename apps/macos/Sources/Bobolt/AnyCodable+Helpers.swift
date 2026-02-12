import BoboltKit
import BoboltProtocol
import Foundation

// Prefer the BoboltKit wrapper to keep gateway request payloads consistent.
typealias AnyCodable = BoboltKit.AnyCodable
typealias InstanceIdentity = BoboltKit.InstanceIdentity

extension AnyCodable {
    var stringValue: String? { self.value as? String }
    var boolValue: Bool? { self.value as? Bool }
    var intValue: Int? { self.value as? Int }
    var doubleValue: Double? { self.value as? Double }
    var dictionaryValue: [String: AnyCodable]? { self.value as? [String: AnyCodable] }
    var arrayValue: [AnyCodable]? { self.value as? [AnyCodable] }

    var foundationValue: Any {
        switch self.value {
        case let dict as [String: AnyCodable]:
            dict.mapValues { $0.foundationValue }
        case let array as [AnyCodable]:
            array.map(\.foundationValue)
        default:
            self.value
        }
    }
}

extension BoboltProtocol.AnyCodable {
    var stringValue: String? { self.value as? String }
    var boolValue: Bool? { self.value as? Bool }
    var intValue: Int? { self.value as? Int }
    var doubleValue: Double? { self.value as? Double }
    var dictionaryValue: [String: BoboltProtocol.AnyCodable]? { self.value as? [String: BoboltProtocol.AnyCodable] }
    var arrayValue: [BoboltProtocol.AnyCodable]? { self.value as? [BoboltProtocol.AnyCodable] }

    var foundationValue: Any {
        switch self.value {
        case let dict as [String: BoboltProtocol.AnyCodable]:
            dict.mapValues { $0.foundationValue }
        case let array as [BoboltProtocol.AnyCodable]:
            array.map(\.foundationValue)
        default:
            self.value
        }
    }
}
