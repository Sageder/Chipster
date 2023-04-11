import SwiftUI

typealias GateId = UUID

struct GateWrapper: Identifiable, View {
    static var size: CGFloat = 75
    
    @EnvironmentObject var canvasModel: CanvasModel
    
    let id: GateId = UUID()
    let type: Gate
    let offset: CGSize
    
    var rotation: Angle = .zero
    
    @State var dragOffset: CGPoint = .zero
    
    @State var in0: Bool = false
    @State var in1: Bool = false
    
    var usesIn0: Bool {
        if type == .in {
            return false
        }
        
        return true
    }
    
    var usesIn1: Bool {
        if (type == .not ||
            type == .in ||
            type == .out) {
            return false
        }
        
        return true
    }
    
    var usesOut: Bool {
        if type == .out {
            return false
        }
        
        return true
    }
    
    var out: Bool {
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
    
    var body: some View {
        HStack {
            VStack(spacing: 25) {
                if usesIn0 {
                    GateIn(parent: id,
                           index: 0)
                }
                
                if usesIn1 {
                    GateIn(parent: id,
                           index: 1)
                }
            }
            
            switch (type) {
            case .in:
                InShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
            case .out:
                OutShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: GateWrapper.size,
                           height:  GateWrapper.size)
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
            
            if usesOut {
                GateOut(parent: id)
            }
        }
        .rotationEffect(rotation)
    }
}

struct GateWrapper_Previews: PreviewProvider {
    static var previews: some View {
        GateWrapper(type: .not, offset: .zero)
    }
}
