import SwiftUI

struct IntroView: View {
    @ObservedObject var introModel: IntroModel
    
    var body: some View {
        TabView(selection: $introModel.currentPage) {
            PageOne()
                .tag(0)
            
            PageTwo()
                .tag(1)
            
            PageThree()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
        .overlay {
            controlButtons()
        }
    }
    
    @ViewBuilder
    func controlButtons()->some View {
        if introModel.canGoBack() {
            Button {
                withAnimation {
                    introModel.goBack()
                }
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(30)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomLeading)
        }
        
        if introModel.canGoNext() {
            Button {
                withAnimation {
                    introModel.goNext()
                }
            } label: {
                Image(systemName: "arrow.right")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(30)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
        } else {
            Button {
                withAnimation {
                    introModel.closeIntro()
                }
            } label: {
                Text("Start 🚀")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(30)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(introModel: IntroModel())
    }
}
