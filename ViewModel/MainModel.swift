import SwiftUI

class MainModel: ObservableObject {
    @Published var tabs: [String] = []
    @Published var showAlert: Bool = false
    @Published var newName: String = ""
}
