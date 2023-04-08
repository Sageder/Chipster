import SwiftUI

enum MenuItem: String, Identifiable {
    case `in` = "In"
    case out = "Out"
    case not = "Not"
    case and = "And"
    case or = "Or"
    case xor = "Xor"
    case rotate = "Rotate"
    case erase = "Erase"
    
    var id: String {
        return rawValue
    }

    func shape()->AnyShape { 
        switch self {
        case .in:
            return AnyShape(InShape())
        case .out:
            return AnyShape(OutShape())
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
        return self == .in ||
            self == .out ||
            self == .not ||
            self == .and ||
            self == .or ||
            self == .xor
    }
    
    static func placeables()->[MenuItem] {
        return [
            .in,
            .out,
            .not,
            .and,
            .or,
            .xor,
        ]
    }
    
    var isActionable: Bool {
        return self == .rotate ||
            self == .erase
    }
    
    static func actionables()->[MenuItem] {
        return [
            .rotate,
            .erase
        ]
    }
}

class MenuModel: ObservableObject {
    @Published var cur: MenuItem = .in
    
    init() {}
}
