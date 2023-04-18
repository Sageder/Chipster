import SwiftUI

class CanvasModel: ObservableObject {
    @Published var gates: [GateWrapper] = []
    @Published private var cur: GateId?
    
    @Published var connections: [GateConnection] = []
    @Published private var curConnection: ConnectionId?
    @Published var connecting: Bool = false
    @Published var fromConnection: GateId?
    
    @Published var showAllDebug: Bool = false
    @Published var blockInput: Bool = false
    
    func clear() {
        reset()
        resetConnection()
        gates = []
        connections = []
    }
}

// For gates
extension CanvasModel {
    func setCur(_ cur: GateWrapper) {
        self.cur = cur.id
    }
    
    func reset() {
        cur = nil
    }
    
    func addGate(_ type: Gate, offset: CGSize) {
        gates.append(GateWrapper(type: type,
                                 numOfType: getGateTypeNum(type),
                                 offset: offset))
    }
    
    func rotateGate() {
        let i = getIndexOfGate(cur)
        if i == -1 {
            return
        }
        
        let rot = gates[i].rotation.degrees + 90
        gates[i].rotation = Angle(degrees: rot)
    }
    
    func removeGate() {
        let i = getIndexOfGate(cur)
        if i == -1 {
            return
        }
        
        let id = gates[i].id
        removeConnections(gateId: id)
        
        gates.remove(at: i)
        reset()
    }
    
    func verifyGate(id: GateId)->Bool {
        return gates.contains(where: { $0.id == id })
    }
    
    func getGate(id: GateId)->GateWrapper? {
        return gates.first { $0.id == id }
    }
    
    func gateOffset(id: GateId, to: Bool, toIndex: Int?)->CGPoint {
        let i = getIndexOfGate(id)
        if (i == -1) {
            return .zero
        }
        
        var off = gates[i].drag.offset
        off.x += gates[i].offset.width
        off.y += gates[i].offset.height
        return off
    }
    
    func gatePos(id: GateId, to: Bool, toIndex: Int?, size: CGSize)->CGPoint {
        let off = gateOffset(id: id,
                             to: to,
                             toIndex: toIndex)
        return off.pointFromOffset(size)
    }
    
    func getGateTypeNum(_ type: Gate)->Int {
        var i = 0;
        
        for gate in gates {
            if gate.type == type {
                i += 1
            }
        }
        
        return i
    }
    
    /// Returns -1 if gate wasn't found
    private func getIndexOfGate(_ id: GateId?)->Int {
        if (id == nil) {
            return -1
        }
        
        guard let i = gates.firstIndex(where: {
            id == $0.id
        }) else {
            return -1
        }
        
        return i
    }
}

// For connections
extension CanvasModel {
    func setCurConnection(_ cur: GateConnection) {
        self.curConnection = cur.id
    }
    
    func setFromConnection(_ from: GateId) {
        fromConnection = from
    }
    
    func resetConnection() {
        curConnection = nil
        connecting = false
        fromConnection = nil
    }
    
    func fromInConnections(from: GateId)->Bool {
        return connections.contains(where: { $0.from == from })
    }
    
    func toInConnections(to: GateId)->Bool {
        return connections.contains(where: { $0.to == to })
    }
    
    func removeConnection() {
        let i = getIndexOfConnection(curConnection)
        if i == -1 {
            return
        }
        
        connections.remove(at: i)
    }
    
    func removeConnections(gateId: GateId) {
        for c in connections {
            if (c.from == gateId ||
                c.to == gateId) {
                setCurConnection(c)
                removeConnection()
                resetConnection()
            }
        }
    }
    
    func verifyConnection(id: ConnectionId)->Bool {
        return connections.contains(where: { $0.id == id })
    }
    
    func connectGates(from: GateId, to: GateId, toIndex: Int) {
        let connection = GateConnection(from: from,
                                        to: to,
                                        toIndex: toIndex)
        connections.append(connection)
    }
    
    func isConnectedIn(to gateId: GateId, index: Int)->Bool {
        for c in connections {
            if (c.to == gateId && c.toIndex == index) {
                return true
            }
        }
        
        return false
    }
    
    func isConnectedOut(to gateId: GateId)->Bool {
        for c in connections {
            if (c.from == gateId) {
                return true
            }
        }
        
        return false
    }
    
    func checkForIn()->Bool {
        if (!connecting ||
            fromConnection == nil ||
            !verifyGate(id: fromConnection!)) {
            resetConnection()
            return false
        }
        
        return true
    }
    
    /// Returns -1 if connection wasn't found
    private func getIndexOfConnection(_ id: ConnectionId?)->Int {
        if (id == nil) {
            return -1
        }
        
        guard let i = connections.firstIndex(where: {
            id == $0.id
        }) else {
            return -1
        }
        
        return i
    }
}
