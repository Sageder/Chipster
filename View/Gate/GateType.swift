import SwiftUI

enum GateType {
    case `in`
    case out
    case not
    case and
    case or
    case xor
    
    func getName()->String {
        switch (self) {
        case .in:
            return "In"
        case .out:
            return "Out"
        case .not:
            return "Not"
        case .and:
            return "And"
        case .or:
            return "Or"
        case .xor:
            return "Xor"
        }
    }
    
    static func from(item: MenuItem)->GateType {
        switch (item) {
        case .in:
            return .in
        case .out:
            return .out
        case .not:
            return .not
        case .and:
            return .and
        case .or:
            return .or
        case .xor:
            return .xor
        default:
            assertionFailure("Can't translate MenuItem to GateType")
            return .not
        }
    }
    
    static func all()->[GateType] {
        return [
            .in,
            .out,
            .not,
            .and,
            .or,
            .xor
        ]
    }
}
