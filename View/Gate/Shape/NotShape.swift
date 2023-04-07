import SwiftUI

struct NotShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let triangleWidth = size * 0.7
        let triangleHeight = size * 0.8
        let trianglePath = Path { path in
            path.move(to: CGPoint(x: rect.minX,
                                  y: rect.midY - triangleHeight / 2))
            path.addLine(to: CGPoint(x: rect.minX + triangleWidth,
                                     y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: rect.midY + triangleHeight / 2))
            path.closeSubpath()
        }
        let circleSize = size * 0.3
        let circlePath = Path(ellipseIn: CGRect(x: rect.maxX - circleSize,
                                                y: rect.midY - circleSize / 2,
                                                width: circleSize,
                                                height: circleSize))
        var path = trianglePath
        path.addPath(circlePath)
        return path
    }
}

struct NotShape_Previews: PreviewProvider {
    static var previews: some View {
        GateShape_Preview.preview(gate: NotShape(), frame: true)
    }
}

