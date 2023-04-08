import SwiftUI

enum Gate {
    case not
    case and
    case or
    case xor
    
    static func from(item: MenuItem)->Gate {
        switch (item) {
        case .not:
            return .not
        case .and:
            return .and
        case .or:
            return .or
        case .xor:
            return .xor
        case .line:
            // TODO: impliment
            return .not
        default:
            assertionFailure("Can't translate MenuItem to Gate")
            return .not
        }
    }
}

struct GateIn: View {
    static var size: CGFloat = 15
    
    var body: some View {
        Circle()
            .fill(Color.green)
            .frame(width: GateIn.size,
                   height: GateIn.size)
    }
}

struct GateOut: View {
    static var size: CGFloat = 15
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: GateOut.size,
                   height: GateOut.size)
    }
}
