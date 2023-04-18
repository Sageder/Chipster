import SwiftUI

struct IntroView: View {
    @ObservedObject var introModel: IntroModel
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
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
            if (selection - 1 >= 0) {
                Button {
                    withAnimation {
                        selection -= 1
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            }
            
            if (selection + 1 <= 2) {
                Button {
                    withAnimation {
                        selection += 1
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            } else {
                Button {
                    withAnimation {
                        withAnimation {
                            introModel.start = true
                        }
                    }
                } label: {
                   Text("Start 🚀")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(introModel: IntroModel())
    }
}
