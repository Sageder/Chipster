import SwiftUI

class CanvasModel: ObservableObject {
    @Published var gates: [GateWrapper] = []
    @Published var cur: UUID?
    
    func addGate(_ type: Gate, offset: CGSize) {
        gates.append(GateWrapper(type: type,
                                 offset: offset))
    }
    
    func removeGate() {
        if (cur == nil) {
            return
        }
        
        guard let i = gates.firstIndex(where: {
            cur == $0.id
        }) else {
            return
        }
                
        gates.remove(at: i)
    }
    
    func setCur(_ cur: GateWrapper) {
        self.cur = cur.id
    }
}
