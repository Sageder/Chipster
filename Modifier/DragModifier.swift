import SwiftUI

struct DragModifier: ViewModifier {
    @Binding var offset: CGPoint
    @State var prev: CGSize?
    
    func body(content: Content)->some View {
        content
            .offset(x: offset.x, y: offset.y)
            .gesture(DragGesture().onChanged({ drag in
                if ((prev == nil)) {
                    prev = drag.translation
                    return
                }
                
                offset.x += drag.translation.width - prev!.width
                offset.y += drag.translation.height - prev!.height
                
                prev = drag.translation
            }).onEnded({ _ in
                prev = nil
            }))
    }
}
