import SwiftUI

enum MenuItem: String, Identifiable {
    case line = "Line"
    case not = "Not"
    case and = "And"
    case or = "Or"
    case xor = "Xor"
    case move = "Move"
    case erase = "Erase"
    
    var id: String {
        return rawValue
    }

    func shape()->AnyShape { 
        switch self {
        case .line:
            return AnyShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        case .not:
            return AnyShape(NotShape())
        case .and:
            return AnyShape(AndShape())
        case .or:
            return AnyShape(OrShape())
        case .xor:
            return AnyShape(XorShape())
        default:
            print("Error: shape() called on a non shape.")
            return AnyShape(Circle())
        }
    }
    
    var isPlacable: Bool {
        return self == .line ||
            self == .not ||
            self == .and ||
            self == .or ||
            self == .xor
    }
    
    static func placeables()->[MenuItem] {
        return [
            .line,
            .not,
            .and,
            .or,
            .xor,
        ]
    }
    
    var isActionable: Bool {
        return self == .move ||
            self == .erase
    }
    
    static func actionables()->[MenuItem] {
        return [
            .move,
            .erase
        ]
    }
}

class MenuModel: ObservableObject {
    @Published var cur: MenuItem = .line
    
    init() {}
}
