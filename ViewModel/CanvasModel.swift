import SwiftUI

class CanvasModel: ObservableObject {
    @Published var gates: [GateWrapper] = []
    @Published var cur: UUID?
    
    /// Returns -1 if cur wasn't found
    private func getIndexOfCur()->Int {
        if (cur == nil) {
            return -1
        }
        
        guard let i = gates.firstIndex(where: {
            cur == $0.id
        }) else {
            return -1
        }
        
        return i
    }
    
    func addGate(_ type: Gate, offset: CGSize) {
        gates.append(GateWrapper(type: type,
                                 offset: offset))
    }
    
    func rotateGate() {
        let i = getIndexOfCur()
        if i == -1 {
            return
        }
        
        let rot = gates[i].rotation.degrees + 90
        gates[i].rotation = Angle(degrees: rot)
    }
    
    func removeGate() {
        let i = getIndexOfCur()
        if i == -1 {
            return
        }
                
        gates.remove(at: i)
    }
    
    func setCur(_ cur: GateWrapper) {
        self.cur = cur.id
    }
}
