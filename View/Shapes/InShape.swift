import SwiftUI

struct InShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let triangleWidth = size * 0.3
        let triangleHeight = size * 0.7
        let top = rect.maxY - (size - triangleHeight) / 2
        let trianglePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + triangleWidth,
                                  y: top))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: top - triangleHeight / 2))
            path.addLine(to: CGPoint(x: rect.minX + triangleWidth,
                                     y: top - triangleHeight))
            path.move(to: CGPoint(x: rect.minX + triangleWidth,
                                  y: top))
            path.closeSubpath()
        }
        let cubeWidth = size * 0.7
        let cubeHeight = size * 0.7
        let cubePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + triangleWidth,
                                  y: top))
            path.addLine(to: CGPoint(x: rect.minX + triangleWidth + cubeWidth,
                                     y: top))
            path.addLine(to: CGPoint(x: rect.minX + triangleWidth + cubeWidth,
                                     y: top - cubeHeight))
            path.addLine(to: CGPoint(x: rect.minX + triangleWidth,
                                     y: top - cubeHeight))
            path.move(to: CGPoint(x: rect.minX + triangleWidth,
                                  y: top))
            path.closeSubpath()
        }
        
        
        var path = trianglePath
        path.addPath(cubePath)
        return path
    }
}

struct InShape_Previews: PreviewProvider {
    static var previews: some View {
        GateShape_Preview.preview(gate: InShape(), frame: false)
    }
}
