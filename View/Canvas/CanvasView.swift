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
                    gate
                        .offset(gate.offset)
                        .modifier(gate.drag)
                        .onTapGesture {
                            canvasModel.setCur(gate)
                            
                            if menuModel.cur == .rotate {
                                withAnimation {
                                    canvasModel.rotateGate()
                                }
                            }
                            
                            if menuModel.cur == .erase {
                                canvasModel.removeGate()
                            }
                        }
                }
                
                ForEach(canvasModel.connections) { c in
                    ConnectionShape(start: canvasModel.gatePos(id: c.from,
                                                               to: false,
                                                               toIndex: nil,
                                                               size: geometry.size),
                                    end: canvasModel.gatePos(id: c.to,
                                                             to: true,
                                                             toIndex: c.toIndex,
                                                             size: geometry.size))
                        .stroke(lineWidth: 1.5)
                }
            }
            .environmentObject(canvasModel)
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
