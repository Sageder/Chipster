import SwiftUI

struct MenuView: View {
    @ObservedObject var menuModel: MenuModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 25) {
            ForEach(MenuItem.placeables()) { item in
                menuItem(item, size: 35)
            }
            
            Divider()
                .background(Color.white)
                .frame(height: 40)
                
            ForEach(MenuItem.actionables()) { item in
                menuItem(item, size: 35)
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(Capsule().fill(Color.black))
    }
    
    @ViewBuilder
    func menuItem(_ item: MenuItem, size: CGFloat)->some View {
        VStack {
            Button {
                withAnimation {
                    menuModel.cur = item
                }
            } label: { 
                let isCur = menuModel.cur == item
                let color = isCur ? Color.white : Color.white.opacity(0.7)
                
                if (item.isPlacable) {
                    item.shape()
                        .stroke(lineWidth: 2.5)
                        .frame(width: size, height: item == .line ? size / 4 : size)
                        .foregroundColor(color)
                }
                
                if (item == .move) {
                    Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                        .foregroundColor(color)
                }
                
                if (item == .erase) {
                    Image(systemName: "eraser")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                        .foregroundColor(color)
                }
            }
        }
    }
}

