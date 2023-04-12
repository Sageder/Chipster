import SwiftUI

extension CGPoint {
    func pointFromOffset(_ size: CGSize)->CGPoint {
        return CGPoint(x: size.width / 2 + x,
                       y: size.height / 2 + y)
    }
}
