import SwiftUI

struct GateWrapper: Identifiable {
    static var size: CGFloat = 75
    
    let id = UUID()
    let type: Gate
    let offset: CGSize
    
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
        HStack {
            VStack(spacing: 25) {
                GateIn()
                
                if usesIn1 {
                    GateIn()
                }
            }
            
            switch (type) {
            case .not:
                NotShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
            case .and:
                AndShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
            case .or:
                OrShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
            case .xor:
                XorShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
            }
            
            GateOut()
        }
    }
}

struct GateWrapper_Previews: PreviewProvider {
    static var previews: some View {
        GateWrapper(type: .not, offset: .zero).gate()
    }
}
