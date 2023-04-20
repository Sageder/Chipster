import SwiftUI

struct SandboxView: View {
    @ObservedObject var menuModel: MenuModel = .init()
    @ObservedObject var canvasModel: CanvasModel = .init()
    
    let name: String
    
    var body: some View {
        CanvasView(menuModel: menuModel)
            .environmentObject(canvasModel)
            .overlay(alignment: .top, content: {
                VStack {
                    Text(name)
                        .font(.title)
                        .padding()
                    
                    Text("Build whatever circuit you want. 🤯 Be creative. 🎨")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .frame(width: 320)
                }
            })
            .overlay(alignment: .bottom, content: {
                MenuView(menuModel: menuModel)
                    .padding(.bottom, 40)
            })
    }
}

struct SandboxView_Previews: PreviewProvider {
    static var previews: some View {
        SandboxView(name: "Sandbox")
    }
}
