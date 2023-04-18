import SwiftUI

struct ContentView: View {
    @ObservedObject var menuModel = MenuModel()
    @ObservedObject var canvasModel = CanvasModel()
    @ObservedObject var introModel = IntroModel()
    
    var body: some View {
        if introModel.start {
            CanvasView(canvasModel: canvasModel,
                       menuModel: menuModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom, content: {
                MenuView(menuModel: menuModel)
                    .padding(.bottom, 40)
            })
        } else {
            IntroView(introModel: introModel)
        }
    }
}

struct ConentPreview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
