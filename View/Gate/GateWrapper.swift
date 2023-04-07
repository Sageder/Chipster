import SwiftUI

struct GateWrapper: Identifiable {
    let id = UUID()
    let type: Gate
    
    var in0: Bool = false
    var in1: Bool = false
    
    var usesIn1: Bool {
        if (type == .not) {
            return false
        }
        
        return true
    }
    
    var out: Bool {
        switch (type) {
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
    
    @ViewBuilder
    func gate()->some View {
        switch (type) {
        case .not:
            NotShape()
                .frame(width: 100, height: 100)
        case .and:
            AndShape()
                .frame(width: 100, height: 100)
        case .or:
            OrShape()
                .frame(width: 100, height: 100)
        case .xor:
            XorShape()
                .frame(width: 100, height: 100)
        }
    }
}
