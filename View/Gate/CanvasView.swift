import SwiftUI

struct CanvasView: View {
    @EnvironmentObject var canvasModel: CanvasModel
    @ObservedObject var menuModel: MenuModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.clear)
                
                ForEach(canvasModel.gates) { gate in
                    let i = canvasModel.getGateIndex(gate.id)
                    
                    drawGate(gate, i: i)
                        .rotationEffect(gate.rotation)
                        .modifier(DragModifier(offset: $canvasModel.gates[i].offset))
                        .onTapGesture {
                            if canvasModel.blockInput {
                                return
                            }
                            
                            if menuModel.cur == .rotate {
                                withAnimation {
                                    canvasModel.rotateGateIndex(i)
                                }
                            }
                            
                            if menuModel.cur == .erase {
                                withAnimation {
                                    canvasModel.removeGateIndex(i)
                                }
                            }
                        }
                }
                
                ForEach(canvasModel.connections) { connection in
                    let i = canvasModel.getConnectionIndex(connection.id)
                    
                    drawConnection(connection, i: i, size: geometry.size)
                        .onTapGesture {
                            if canvasModel.blockInput {
                                return
                            }
                            
                            if menuModel.cur == .erase {
                                withAnimation {
                                    canvasModel.removeConnectionIndex(i)
                                }
                            }
                        }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { gesture in
                if canvasModel.blockInput {
                    return
                }
                
                if menuModel.cur.isPlacable {
                    let offset = geometry.size.offsetFromMid(gesture)
                    canvasModel.addGate(type: GateType.from(item: menuModel.cur),
                                        offset: offset)
                }
            }
        }
    }
}

extension CanvasView {
    @ViewBuilder
    func drawGate(_ gate: Gate, i: Int)->some View {
        HStack(spacing: 15) {
            VStack(spacing: 25) {
                if gate.usesIn0() {
                    gateIn(gate, index: 0)
                }
                
                if gate.usesIn1() {
                    gateIn(gate, index: 1)
                }
            }
            
            switch (gate.type) {
            case .in:
                HStack {
                    Text("In\(gate.num)")
                        .font(.title3)
                    
                    ZStack {
                        Button {
                            withAnimation {
                                canvasModel.gates[i].in0.toggle()
                            }
                        } label: {
                            Circle()
                                .fill(gate.getOut() ? Color.green : Color.red)
                                .frame(width: 20, height: 20)
                        }
                        
                        InShape()
                            .stroke(lineWidth: 2.5)
                            .frame(width: Gate.size,
                                   height: Gate.size)
                    }
                }
            case .out:
                HStack {
                    ZStack {
                        Circle()
                            .fill(gate.getOut() ? Color.green : Color.red)
                            .frame(width: 20, height: 20)
                        
                        OutShape()
                            .stroke(lineWidth: 2.5)
                            .frame(width: Gate.size,
                                   height: Gate.size)
                    }
                    
                    Text("Out\(gate.num)")
                        .font(.title3)
                }
            case .not:
                NotShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: Gate.size,
                           height: Gate.size)
            case .and:
                AndShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: Gate.size,
                           height: Gate.size)
            case .or:
                OrShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: Gate.size,
                           height: Gate.size)
            case .xor:
                XorShape()
                    .stroke(lineWidth: 2.5)
                    .frame(width: Gate.size,
                           height: Gate.size)
            }
            
            if gate.usesOut() {
                gateOut(gate)
            }
        }
    }
    
    @ViewBuilder
    func gateIn(_ parent: Gate, index: Int)->some View {
        if canvasModel.isConnectedIn(to: parent.id, index: index) {
            Circle()
                .fill(Color.black)
                .frame(width: 15, height: 15)
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(Color.black)
                .frame(width: 15, height: 15)
                .opacity(canvasModel.showAllDebug ? 1 :
                         !canvasModel.connecting ? 0 :
                         canvasModel.fromConnection == parent.id ? 0 : 1)
                .onTapGesture {
                    if !canvasModel.checkForIn() || canvasModel.showAllDebug {
                        return
                    }
                    
                    withAnimation {
                        canvasModel.connectGates(from: canvasModel.fromConnection!,
                                                 to: parent.id,
                                                 toIndex: index)
                    }
                    
                    canvasModel.resetConnection()
                }
        }
    }
    
    @ViewBuilder
    func gateOut(_ parent: Gate)->some View {
        if canvasModel.isConnectedOut(to: parent.id) {
            Circle()
                .fill(Color.black)
                .frame(width: 15, height: 15)
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(Color.black)
                .frame(width: 15, height: 15)
                .opacity(canvasModel.showAllDebug ? 1 :
                            !canvasModel.connecting ? 1 :
                            canvasModel.fromConnection == parent.id ? 1 : 0)
                .onTapGesture {
                    if canvasModel.showAllDebug {
                        return
                    }
                    
                    canvasModel.fromConnection = parent.id
                    
                    withAnimation {
                        canvasModel.connecting = true
                    }
                }
        }
    }
}

extension CanvasView {
    @ViewBuilder
    func drawConnection(_ connection: Connection, i: Int, size: CGSize)->some View {
        let from = canvasModel.getGateIndex(connection.from)
        if from == -1 {
            Text("Error \(connection.from)")
        }
        
        ConnectionShape(start: canvasModel.gatePos(id: connection.from,
                                                   to: false,
                                                   toIndex: nil,
                                                   size: size),
                        end: canvasModel.gatePos(id: connection.to,
                                                 to: true,
                                                 toIndex: connection.toIndex,
                                                 size: size))
        .stroke(lineWidth: 2.5)
        .foregroundColor(canvasModel.gates[from].getOut() ? .green : .red)
        .onAppear {
            let to = canvasModel.getGateIndex(connection.to)
            if to == -1 {
                assertionFailure("Error \(connection.to)")
            }
            
            if connection.toIndex == 0 {
                canvasModel.gates[to].in0 = canvasModel.gates[from].getOut()
            } else {
                canvasModel.gates[to].in1 = canvasModel.gates[from].getOut()
            }
        }
        .onChange(of: canvasModel.gates[from].getOut()) { newValue in
            let to = canvasModel.getGateIndex(connection.to)
            if to == -1 {
                assertionFailure("Error \(connection.to)")
            }
            
            if connection.toIndex == 0 {
                canvasModel.gates[to].in0 = newValue
            } else {
                canvasModel.gates[to].in1 = newValue
            }
            
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(menuModel: .init())
            .environmentObject(CanvasModel())
    }
}
