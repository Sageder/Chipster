import SwiftUI

struct PageThree: View {
    @StateObject var canvasModel: CanvasModel = .init()
    @StateObject var menuModel: MenuModel = .init()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                
                Spacer()
                
                CanvasView(canvasModel: canvasModel, menuModel: menuModel)
                    .frame(maxHeight: (geometry.size.width / 1900) * 1100)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                    }
                    .onAppear {
                        resetCanvas()
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
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        }
                        .padding()
                    }
                
                Text("Connections")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("You can connect gates by clicking on the output of one and then on the input of another gate.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                
                Text("The color of the connection tells you wheter its \(Text("on (true)").foregroundColor(.green)) and \(Text("off (false)").foregroundColor(.red))")
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
    
    @ViewBuilder
    func imageView(_ image: String, url: String)->some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding()
            
            Link("Credit: Apple Inc.", destination: URL(string: url)!)
        }
    }
    
    func resetCanvas() {
        canvasModel.clear()
        canvasModel.blockInput = true
        canvasModel.addGate(.in, offset: CGSize(width: -200, height: 50))
        canvasModel.addGate(.in, offset: CGSize(width: -200, height: -50))
        canvasModel.addGate(.xor, offset: CGSize(width: 0, height: 0))
        canvasModel.addGate(.out, offset: CGSize(width: 200, height: 0))
    }
}

struct PageThree_Previews: PreviewProvider {
    static var previews: some View {
        PageThree()
    }
}
