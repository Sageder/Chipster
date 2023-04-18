import SwiftUI

struct PageTwo: View {
    @State var currentGate: Gate = .in
    @State var canvasModel: CanvasModel
    
    init() {
        canvasModel = .init()
        canvasModel.showAllDebug = true
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
                    ForEach(Gate.all(), id: \.self) { gate in
                        let isCur = gate == currentGate
                        
                        Button {
                            withAnimation {
                                currentGate = gate
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
    
    @ViewBuilder
    func explainGate(_ gate: Gate)->some View {
        VStack {
            Text(gate.getName())
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            GateWrapper(type: gate, numOfType: 0, offset: .zero)
                .environmentObject(canvasModel)
            
            
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
