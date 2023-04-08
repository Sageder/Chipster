import SwiftUI

struct CanvasView: View {
    @ObservedObject var canvasModel: CanvasModel
    @ObservedObject var menuModel: MenuModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.clear)
                
                ForEach(canvasModel.gates) { gate in
                    gate.gate()
                        .offset(gate.offset)
                        .onTapGesture {
                            canvasModel.setCur(gate)
                            
                            if menuModel.cur == .erase {
                                canvasModel.removeGate()
                            }
                        }
                        .modifier(DragModifier())
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { gesture in
                if (menuModel.cur.isPlacable) {
                    let offset = geometry.size.offsetFromMid(gesture)
                    canvasModel.addGate(Gate.from(item: menuModel.cur),
                                        offset: offset)
                }
            }
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
