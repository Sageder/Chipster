import SwiftUI

struct DragModifier: ViewModifier {
    let id: GateId
    
    @EnvironmentObject var canvasModel: CanvasModel
    @State var offset: CGPoint = .zero
    @State var prev: CGSize?
    
    func addOffset(_ deltaX: CGFloat, _ deltaY: CGFloat) {
        offset.x += deltaX
        offset.y += deltaY
        
        let succ = canvasModel.setDragOffset(id: id,
                                             offset: offset)
        if (!succ) {
            assertionFailure("DragModifier wrong GateId \(id)!")
        }
    }
  
    func body(content: Content)->some View {
        content
            .offset(x: offset.x, y: offset.y)
            .gesture(DragGesture().onChanged({ drag in
                if ((prev == nil)) {
                    prev = drag.translation
                    return
                }
          
                addOffset(drag.translation.width - prev!.width,
                          drag.translation.height - prev!.height)
                prev = drag.translation
            }).onEnded({ _ in
                prev = nil
            }))
    }
}
