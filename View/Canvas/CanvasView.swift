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
                            
                            if canvasModel.blockInput {
                                return
                            }
                            
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
                    c.view(size: geometry.size)
                        .onTapGesture {
                            canvasModel.setCurConnection(c)
                            
                            if canvasModel.blockInput {
                                return
                            }
                            
                            if menuModel.cur == .erase {
                                canvasModel.removeConnection()
                            }
                        }
                }
            }
            .environmentObject(canvasModel)
            .contentShape(Rectangle())
            .onTapGesture { gesture in
                if canvasModel.blockInput {
                    return
                }
                
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
