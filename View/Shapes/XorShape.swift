import SwiftUI

struct XorShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let twoHalfCurveCubeWidth = size * 0.5
        let twoHalfCurveCubeDist = twoHalfCurveCubeWidth * 0.4
        let twoHalfCurveCubePath = Path { path in
            path.move(to: CGPoint(x: rect.minX + twoHalfCurveCubeWidth,
                                  y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + twoHalfCurveCubeDist,
                                     y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX + twoHalfCurveCubeDist,
                                          y: rect.maxY - size),
                              control: CGPoint(x: rect.minX + twoHalfCurveCubeWidth + twoHalfCurveCubeDist,
                                               y: rect.maxY - size / 2))
            path.addLine(to: CGPoint(x: rect.minX + twoHalfCurveCubeWidth,
                                     y: rect.maxY - size))
            path.move(to: CGPoint(x: rect.minX,
                                  y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX,
                                          y: rect.maxY - size),
                              control: CGPoint(x: rect.minX + twoHalfCurveCubeWidth,
                                               y: rect.maxY - size / 2))
            path.move(to: CGPoint(x: rect.minX,
                                  y: rect.maxY))
            path.closeSubpath()
        }
        let circleSize = size * 0.5
        let circlePath = Path { path in
            path.addArc(center: CGPoint(x: rect.minX + twoHalfCurveCubeWidth,
                                        y: rect.maxY - circleSize),
                        radius: circleSize,
                        startAngle: .degrees(90),
                        endAngle: .degrees(270),
                        clockwise: true)
        }
        
        var path = twoHalfCurveCubePath
        path.addPath(circlePath)
        return path
    }
}

struct XorShape_Previews: PreviewProvider {
    static var previews: some View {
        GateShape_Preview.preview(gate: XorShape(), frame: false)
    }
}

