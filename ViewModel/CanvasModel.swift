import SwiftUI

class CanvasModel: ObservableObject {
    @Published var gates: [Gate] = []
    @Published var connections: [Connection] = []
    
    @Published var connecting: Bool = false
    @Published var fromConnection: GateId?
    
    @Published var showAllDebug: Bool = false
    @Published var blockInput: Bool = false
    
    func clear() {
        gates = []
        connections = []
        resetConnection()
    }
}

extension CanvasModel {
    func getGateIndex(_ id: GateId)->Int {
        guard let i = gates.firstIndex(where: {
            id == $0.id
        }) else {
            return -1
        }
        
        return i
    }
    
    func addGate(type: GateType, offset: CGPoint) {
        gates.append(Gate(type: type,
                          num: getNum(type),
                          offset: offset))
    }
    
    func rotateGateIndex(_ i: Int) {
        let rot = gates[i].rotation.degrees + 90
        gates[i].rotation = Angle(degrees: rot)
    }
    
    func removeGateIndex(_ i: Int) {
        removeConnections(gates[i].id)
        gates.remove(at: i)
    }

    func getNum(_ type: GateType)->Int {
        var i = 0;
        
        for gate in gates {
            if gate.type == type {
                i += 1
            }
        }
        
        return i
    }
    
    func verifyGate(id: GateId)->Bool {
        return gates.contains(where: { $0.id == id })
    }
    
    func gateOffset(id: GateId, to: Bool, toIndex: Int?)->CGPoint {
        let i = getGateIndex(id)
        if (i == -1) {
            return .zero
        }
        
        var offset = gates[i].offset
        
        let deltaX = Gate.size / 2 + 30
        let plusX: CGFloat = gates[i].type == .in || gates[i].type == .out ? 10 : 0
        let deltaY: CGFloat = 18
        
        // TODO: Refactor
        // this is currently a mess, but it works 🤣
        // outer ifs check rotation
        // inner ifs determine wheter it's a GateIn 0, GateIn 1 or a GateOut
        // then it adds the delta offset from the center of the gate
        if Int(gates[i].rotation.degrees) % 360 == 0 {
            if toIndex == nil {
                offset.x += deltaX + plusX
            } else if toIndex! == 0 {
                offset.x -= deltaX + plusX
                if gates[i].usesIn1() {
                    offset.y -= deltaY
                }
            } else if toIndex! == 1 {
                offset.x -= deltaX
                offset.y += deltaY
            }
        } else if Int(gates[i].rotation.degrees) % 360 == 90 {
            if toIndex == nil {
                offset.y += deltaX + plusX
            } else if toIndex! == 0 {
                offset.y -= deltaX + plusX
                if gates[i].usesIn1() {
                    offset.x += deltaY
                }
            } else if toIndex! == 1 {
                offset.y -= deltaX
                offset.x -= deltaY
            }
        } else if Int(gates[i].rotation.degrees) % 360 == 180 {
            if toIndex == nil {
                offset.x -= deltaX + plusX
            } else if toIndex! == 0 {
                offset.x += deltaX + plusX
                if gates[i].usesIn1() {
                    offset.y += deltaY
                }
            } else if toIndex! == 1 {
                offset.x += deltaX
                offset.y -= deltaY
            }
        } else if Int(gates[i].rotation.degrees) % 360 == 270 {
            if toIndex == nil {
                offset.y -= deltaX + plusX
            } else if toIndex! == 0 {
                offset.y += deltaX + plusX
                if gates[i].usesIn1() {
                    offset.x -= deltaY
                }
            } else if toIndex! == 1 {
                offset.y += deltaX
                offset.x += deltaY
            }
        }
        
        return offset
    }
}

extension CanvasModel {
    func getConnectionIndex(_ id: ConnectionId)->Int {
        guard let i = connections.firstIndex(where: {
            id == $0.id
        }) else {
            return -1
        }
        
        return i
    }
    
    func removeConnections(_ id: GateId) {
        for i in connections.indices {
            if connections[i].from == id ||
                connections[i].to == id {
                removeConnectionIndex(i)
            }
        }
    }
    
    func removeConnectionIndex(_ i: Int) {
        connections.remove(at: i)
    }
    
    func connectGates(from: GateId, to: GateId, toIndex: Int) {
        connections.append(Connection(from: from,
                                      to: to,
                                      toIndex: toIndex))
    }
    
    func isConnectedIn(to gateId: GateId, index: Int)->Bool {
        for c in connections {
            if c.to == gateId && c.toIndex == index {
                return true
            }
        }
        
        return false
    }
    
    func isConnectedOut(to gateId: GateId)->Bool {
        for c in connections {
            if c.from == gateId {
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
    
    func resetConnection() {
        connecting = false
        fromConnection = nil
    }
    
    func verifyConnection(id: ConnectionId)->Bool {
        return connections.contains(where: { $0.id == id })
    }
    
    func gatePos(id: GateId, to: Bool, toIndex: Int?, size: CGSize)->CGPoint {
        let off = gateOffset(id: id,
                             to: to,
                             toIndex: toIndex)
        return off.pointFromOffset(size)
    }
}
