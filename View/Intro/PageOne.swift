import SwiftUI

struct PageOne: View {
    let credit = "Apple Inc."
    let url = "https://www.apple.com/newsroom/2022/06/apple-unveils-m2-with-breakthrough-performance-and-capabilities/"
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack {
                        ImageView(image: "M2",
                                  credit: credit,
                                  url: url)
                        .frame(maxWidth: geometry.size.width)
                        
                        ImageView(image: "M2-Memory",
                                  credit: credit,
                                  url: url)
                        .frame(maxWidth: geometry.size.width)
                        
                        ImageView(image: "M2-Transistors",
                                  credit: credit,
                                  url: url)
                        .frame(maxWidth: geometry.size.width)
                    }
                }
                .frame(maxHeight: (geometry.size.width / 1900) * 1100)
                
                Text("Modern chips like Apple's M2 are complex")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("They have different areas of the chip that serve different use cases and billions of 2nd generation 5nm transistors.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                
                Text("But at their core, they are composed of numerous \(Text("logic circuits").bold()) working in tandem.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                    .padding()
                
                Spacer()
            }
        }
    }
}

struct PageOne_Previews: PreviewProvider {
    static var previews: some View {
        PageOne()
    }
}
