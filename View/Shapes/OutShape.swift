import SwiftUI

struct OutShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let cubeWidth = size * 0.7
        let cubeHeight = size * 0.7
        let top = rect.maxY - (size - cubeHeight) / 2
        let cubePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: top))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: top))
            path.addLine(to: CGPoint(x: rect.minX,
                                     y: top - cubeHeight))
            path.addLine(to: CGPoint(x: rect.minX + cubeWidth,
                                     y: top - cubeHeight))
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: top))
            path.closeSubpath()
        }
        let triangleWidth = size * 0.3
        let triangleHeight = size * 0.7
        let trianglePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: top))
            path.addLine(to: CGPoint(x: rect.minX + cubeWidth + triangleWidth,
                                     y: top - triangleHeight / 2))
            path.addLine(to: CGPoint(x: rect.minX + cubeWidth,
                                     y: top - triangleHeight))
            path.move(to: CGPoint(x: rect.minX + cubeWidth,
                                  y: top))
            path.closeSubpath()
        }
        
        var path = cubePath
        path.addPath(trianglePath)
        return path
    }
}

struct OutShape_Previews: PreviewProvider {
    static var previews: some View {
        GateShape_Preview.preview(gate: OutShape(), frame: false)
    }
}
