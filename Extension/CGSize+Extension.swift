import SwiftUI

extension CGSize {
    func offsetFromMid(_ point: CGPoint)->CGSize {
        let halfX = width / 2
        let halfY = height / 2
        
        let x = halfX > point.x ? -(halfX - point.x) : point.x - halfX
        let y = halfY > point.y ? -(halfY - point.y) : point.y - halfY
        
        return CGSize(width: x, height: y)
    }
}
