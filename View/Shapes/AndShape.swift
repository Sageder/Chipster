import SwiftUI

struct AndShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let cubeWidth = size * 0.5
        let cubePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: rect.maxY - size))
            path.addLine(to: CGPoint(x: rect.minX + cubeWidth,
                                     y: rect.maxY - size))
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: rect.maxY))
            path.closeSubpath()
        }
        let circleSize = size * 0.5
        let circlePath = Path { path in
            path.addArc(center: CGPoint(x: rect.minX + cubeWidth,
                                        y: rect.maxY - circleSize),
                        radius: circleSize,
                        startAngle: .degrees(90),
                        endAngle: .degrees(270),
                        clockwise: true)
        }
        
        var path = cubePath
        path.addPath(circlePath)
        return path
    }
}

struct AndShape_Previews: PreviewProvider {
    static var previews: some View {
        GateShape_Preview.preview(gate: AndShape(), frame: false)
    }
}
