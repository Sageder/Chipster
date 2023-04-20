import SwiftUI

class IntroModel: ObservableObject {
    @Published var showIntro: Bool = true
    @Published var currentPage: Int = 0
    @Published var pages: Int = 3
}

extension IntroModel {
    func canGoBack()->Bool {
        return currentPage - 1 >= 0
    }
    
    func goBack() {
        if canGoBack() {
            currentPage -= 1
        }
    }
    
    func canGoNext()->Bool {
        return currentPage + 1 <= pages - 1
    }
    
    func goNext() {
        if canGoNext() {
            currentPage += 1
        }
    }
    
    func closeIntro() {
        showIntro.toggle()
    }
}
