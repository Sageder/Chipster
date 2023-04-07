import SwiftUI

struct GateShape_Preview {
    @ViewBuilder
    static func preview<Gate: Shape>(gate: Gate, frame: Bool) -> some View {
        AnyView(
            ZStack {
                if frame {
                    Rectangle()
                        .stroke(style: StrokeStyle())
                        .frame(width: 100, height: 100)
                }
                
                gate
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .frame(width: 100, height: 100)
            }
        )
    }
}

