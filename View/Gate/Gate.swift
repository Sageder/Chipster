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
    
    static func all()->[Gate] {
        return [
            .in,
            .out,
            .not,
            .and,
            .or,
            .xor
        ]
    }
    
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
}

struct GateIn: View {
    static var size: CGFloat = 15
    
    @EnvironmentObject var canvasModel: CanvasModel
    let parent: GateId
    let index: Int
    var connected: Bool {
        return canvasModel.isConnectedIn(to: parent,
                                         index: index)
    }
    
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
                .opacity(canvasModel.showAllDebug ? 1 : canvasModel.connecting ? canvasModel.fromConnection == parent ? 0 : 1 : 0)
                .onTapGesture {
                    if (!canvasModel.checkForIn() && canvasModel.showAllDebug) {
                        return
                    }
                    
                    withAnimation {
                        canvasModel.connectGates(from: canvasModel.fromConnection!,
                                                 to: parent,
                                                 toIndex: index)
                    }
                    
                    canvasModel.resetConnection()
                }
        }
    }
}

struct GateOut: View {
    static var size: CGFloat = 15
    
    @EnvironmentObject var canvasModel: CanvasModel
    let parent: GateId
    var connected: Bool {
        return canvasModel.isConnectedOut(to: parent)
    }
    
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
                .opacity(canvasModel.showAllDebug ? 1 : canvasModel.connecting ? canvasModel.fromConnection == parent ? 1 : 0 : 1)
                .onTapGesture {
                    if (canvasModel.showAllDebug) {
                        return
                    }
                    
                    canvasModel.setFromConnection(parent)
                    
                    withAnimation {
                        canvasModel.connecting = true
                    }
                }
        }
    }
}
