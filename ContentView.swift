import SwiftUI

struct ContentView: View {
    @ObservedObject var introModel: IntroModel = .init()

    
    var body: some View {
        MainView(introModel: introModel)
            .overlay {
                if introModel.showIntro {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                        
                        IntroView(introModel: introModel)
                    }
                    .ignoresSafeArea()
                }
            }
    }
}
