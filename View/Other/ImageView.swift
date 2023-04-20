import SwiftUI

struct ImageView: View {
    let image: String
    let credit: String
    let url: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding()
            
            Link("Credit: \(credit)", destination: URL(string: url)!)
        }
    }
}

