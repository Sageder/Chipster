import SwiftUI

typealias GateId = UUID

struct Gate: Identifiable {
    static var size: CGFloat = 75
    
    let id: GateId = UUID()
    let type: GateType
    let num: Int
    
    var offset: CGPoint = .zero
    var rotation: Angle = .zero
    var in0: Bool = false
    var in1: Bool = false
    
    func usesIn0()->Bool {
        if type == .in {
            return false
        }
        
        return true
    }
    
    func usesIn1()->Bool {
        if (type == .not ||
            type == .in ||
            type == .out) {
            return false
        }
        
        return true
    }
    
    func usesOut()->Bool {
        if type == .out {
            return false
        }
        
        return true
    }
    
    func getOut()->Bool {
        switch (type) {
        case .in:
            return in0
        case .out:
            return in0
        case .not:
            return !in0
        case .and:
            return in0 && in1
        case .or:
            return in0 || in1
        case .xor:
            return in0 != in1
        }
    }
}
