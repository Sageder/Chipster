import SwiftUI

struct PageTwo: View {
    @State var currentGate: GateType = .in
    @ObservedObject var canvasModel: CanvasModel
    @ObservedObject var menuModel: MenuModel
    
    init() {
        menuModel = .init()
        canvasModel = .init()
        canvasModel.showAllDebug = true
        canvasModel.blockInput = true
        reset()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                explainGate(currentGate)
                
                Text("Logic circuits")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("\(Text("Gates").bold()) are the building blocks of logic circuits. They come in various forms and shapes, but here are the most common ones.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                HStack {
                    ForEach(GateType.all(), id: \.self) { gate in
                        let isCur = gate == currentGate
                        
                        Button {
                            withAnimation {
                                if currentGate != gate {
                                    currentGate = gate
                                    reset()
                                }
                            }
                        } label: {
                            Text(gate.getName())
                                .font(.title3)
                                .frame(width: 70, height: 70)
                                .background {
                                    if isCur {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.black)
                                    } else {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 2)
                                    }
                                }
                                .foregroundColor(isCur ? .white : .black)
                        }
                    }
                }
                
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
    
    func reset() {
        canvasModel.clear()
        canvasModel.addGate(type: currentGate, offset: .zero)
    }
}

extension PageTwo {
    @ViewBuilder
    func explainGate(_ gate: GateType)->some View {
        VStack(spacing: 20) {
            Spacer()
            
            CanvasView(menuModel: menuModel)
                .environmentObject(canvasModel)
                .frame(maxWidth: 200, maxHeight: 200)
            
            switch (gate) {
            case .in:
                Text("The \(Text("IN").bold()) gate represents the input to a logic circuit. It can have one or more inputs, and it is the starting point for any logical operation.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("You can change the input by pressing the \(Text("colored button").foregroundColor(canvasModel.gates[0].getOut() ? .green : .red)).")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(In0 indicates that it is the first in and therefore responsible for the first bit)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            case .out:
                Text("The \(Text("OUT").bold()) gate represents the output of a logic circuit. It can have one or more outputs, and it represents the final result of a logical operation.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("This time, the \(Text("colored button").foregroundColor(.red)) just shows you the output, it isn't pressable.")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(Out0 indicates that it is the first out and therefore responsible for the first bit)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            case .not:
                Text("The \(Text("NOT").bold()) gate (also called an inverter) takes a single input and produces the opposite value as output. If the input is a 0 (false), the output is a 1 (true), and vice versa.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(The circle on the left represents the input and the right one the output)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            case .and:
                Text("The \(Text("AND").bold()) gate takes two inputs and produces a single output that is true only if all inputs are true. If any input is false, the output is also false.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(The circles on the left represent the inputs and the right one the output)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            case .or:
                Text("The \(Text("OR").bold()) gate takes two or more inputs and produces a single output that is true if at least one input is true. If all inputs are false, the output is also false.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(The circles on the left represent the inputs and the right one the output)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            case .xor:
                Text("The \(Text("XOR").bold()) gate (short for \(Text("exclusive OR").bold())) takes two inputs and produces a single output that is true if exactly one input is true. If both inputs are false or both are true, the output is false.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("(The circles on the left represent the inputs and the right one the output)")
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
            }
            
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
        }
    }
}

struct PageTwo_Previews: PreviewProvider {
    static var previews: some View {
        PageTwo()
    }
}
