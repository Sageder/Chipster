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
                .opacity(canvasModel.connecting ? 1 : 0)
                .onTapGesture {
                    if (!canvasModel.checkForIn()) {
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
                .opacity(canvasModel.connecting ? canvasModel.fromConnection == parent ? 1 : 0 : 1)
                .onTapGesture {
                    canvasModel.setFromConnection(parent)
                    
                    withAnimation {
                        canvasModel.connecting = true
                    }
                }
        }
    }
}
