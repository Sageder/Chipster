import SwiftUI

typealias ConnectionId = UUID

struct GateConnection: Identifiable {
    @EnvironmentObject var canvasModel: CanvasModel
    
    let id: ConnectionId = UUID()
    let from: GateId
    let to: GateId
    let toIndex: Int
}
