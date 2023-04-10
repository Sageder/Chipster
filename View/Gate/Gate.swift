import SwiftUI

enum Gate {
    case `in`
    case out
    case not
    case and
    case or
    case xor
    
    static func from(item: MenuItem)->Gate {
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
            assertionFailure("Can't translate MenuItem to Gate")
            return .not
        }
    }
}

struct GateIn: View {
    static var size: CGFloat = 15
    
    @State var connected = false
    
    var body: some View {
        if (connected) {
            Circle()
                .fill(Color.green)
                .frame(width: GateIn.size,
                       height: GateIn.size)
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(Color.green)
                .frame(width: GateIn.size,
                       height: GateIn.size)
        }
    }
}

struct GateOut: View {
    static var size: CGFloat = 15
    
    @State var connected = false
    
    var body: some View {
        if (connected) {
            Circle()
                .fill(Color.red)
                .frame(width: GateIn.size,
                       height: GateIn.size)
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(Color.red)
                .frame(width: GateIn.size,
                       height: GateIn.size)
        }
    }
}

struct GateConnection: Identifiable {
    let id = UUID()
    let from: UUID
    let to: UUID
    let toIndex: Int
}
