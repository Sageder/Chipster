import SwiftUI

struct PageThree: View {
    @ObservedObject var canvasModel: CanvasModel
    @ObservedObject var menuModel: MenuModel
    
    init() {
        menuModel = .init()
        canvasModel = .init()
        resetCanvas()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                
                Spacer()
                
                CanvasView(menuModel: menuModel)
                    .environmentObject(canvasModel)
                    .frame(maxHeight: (geometry.size.width / 1900) * 1100)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                    }
                    .overlay(alignment: .center) {
                        VStack {
                            Text("Can you finish this circuit?")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button {
                                withAnimation {
                                    resetCanvas()
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                    .padding(3)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        }
                        .padding()
                    }
                
                Text("States & Connections")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("You can connect gates by clicking on the output of one and then on the input of another gate.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                
                Text("As already mentioned, you can change the input bits by pressing the colored buttons on IN gates. In general, the color tells you whether something \(Text("on (true)").foregroundColor(.green)) and \(Text("off (false)").foregroundColor(.red)).")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                
                Text("Have fun! 🥳")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                    .padding()
                
                Spacer()
                Spacer()
                
            }
            .padding()
        }
    }
    
    func resetCanvas() {
        canvasModel.clear()
        canvasModel.blockInput = true
        canvasModel.addGate(type: .in, offset: CGPoint(x: -300, y: 75))
        canvasModel.addGate(type: .in, offset: CGPoint(x: -300, y: -75))
        canvasModel.addGate(type: .not, offset: CGPoint(x: -125, y: -50))
        canvasModel.addGate(type: .xor, offset: CGPoint(x: 50, y: 0))
        canvasModel.addGate(type: .out, offset: CGPoint(x: 250, y: 0))
    }
}

struct PageThree_Previews: PreviewProvider {
    static var previews: some View {
        PageThree()
    }
}
