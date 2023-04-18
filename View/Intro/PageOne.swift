import SwiftUI

struct PageOne: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack {
                        imageView("M2", url: "https://www.apple.com/newsroom/2022/06/apple-unveils-m2-with-breakthrough-performance-and-capabilities/")
                            .frame(maxWidth: geometry.size.width)
                        
                        imageView("M2-Memory", url: "https://www.apple.com/newsroom/2022/06/apple-unveils-m2-with-breakthrough-performance-and-capabilities/")
                            .frame(maxWidth: geometry.size.width)
                        
                        imageView("M2-Transistors", url: "https://www.apple.com/newsroom/2022/06/apple-unveils-m2-with-breakthrough-performance-and-capabilities/")
                            .frame(maxWidth: geometry.size.width)
                    }
                }
                .frame(maxHeight: (geometry.size.width / 1900) * 1100)
                
                
                Text("Modern chips like Apple's M2 are complex.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("They have different areas of the chip that have different use cases and \(Text("billions of second gen 5nm transistors").bold()).")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 450)
                
                Text("But on a basic level, they are just a lot of \(Text("logic circuits").bold()).")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 500)
                    .padding()
                
                Text("Let's build them 🔥")
                    .font(.title2)
                
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
}

struct PageOne_Previews: PreviewProvider {
    static var previews: some View {
        PageOne()
    }
}
