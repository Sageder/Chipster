import SwiftUI

struct ContentView: View {
    @ObservedObject var menuModel = MenuModel()
    @ObservedObject var canvasModel = CanvasModel()
    
    var body: some View {
        CanvasView(canvasModel: canvasModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom, content: {
                MenuView(menuModel: menuModel)
                    .padding(.bottom, 40)
            })
    }
}
