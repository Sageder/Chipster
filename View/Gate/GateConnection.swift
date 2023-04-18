import SwiftUI

typealias ConnectionId = UUID

struct GateConnection: Identifiable, View {
    @ObservedObject var canvasModel: CanvasModel
    
    let id: ConnectionId = UUID()
    let from: GateId
    let to: GateId
    let toIndex: Int
    
    var isOn: Bool {
        let gate = canvasModel.getGate(id: from)
        if (gate == nil) {
            return false
        }
        
        return gate!.out
    }
    
    var body: some View {
        Text("False GateConnection")
    }
    
    @ViewBuilder
    func view(size: CGSize) -> some View {
        ConnectionShape(start: canvasModel.gatePos(id: from,
                                                   to: false,
                                                   toIndex: nil,
                                                   size: size),
                        end: canvasModel.gatePos(id: to,
                                                 to: true,
                                                 toIndex: toIndex,
                                                 size: size))
        .stroke(lineWidth: 2.5)
        .foregroundColor(isOn ? .green : .red)
    }
}
