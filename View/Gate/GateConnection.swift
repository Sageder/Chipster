import SwiftUI

typealias ConnectionId = UUID

struct GateConnection: Identifiable {
    @EnvironmentObject var canvasModel: CanvasModel
    
    let id: ConnectionId = UUID()
    let from: GateId
    let to: GateId
    let toIndex: Int
    
    func startPoint()->CGPoint {
        let gate = canvasModel.getGate(id: from)
        if (gate == nil) {
            assertionFailure("Wrong gateID \(from)")
            return .zero
        }
        
        // TODO: delete or rewrite
        
        return gate!.entireOffset
    }
    
    func endPoint()->CGPoint {
        let gate = canvasModel.getGate(id: to)
        if (gate == nil) {
            assertionFailure("Wrong gateID \(to)")
            return .zero
        }
        
        // TODO: delete or rewrite
        
        return gate!.entireOffset
    }
}
