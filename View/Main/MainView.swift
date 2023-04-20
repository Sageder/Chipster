import SwiftUI

struct MainView: View {
    @ObservedObject var introModel: IntroModel
    @ObservedObject var mainModel: MainModel = .init()
    
    var body: some View {
        NavigationView {
            List(mainModel.tabs, id: \.self) { tab in
                NavigationLink(destination: SandboxView(name: tab)) {
                    Text(tab)
                }
            }
            .navigationTitle("Circuits")
            .navigationBarItems(
                leading:
                    Button {
                        withAnimation {
                            introModel.showIntro.toggle()
                        }
                    } label: {
                        Text("Back To Tutorial")
                    },
                trailing:
                    Button {
                        withAnimation {
                            mainModel.showAlert = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
            )
            .alert("Enter Circuit Name", isPresented: $mainModel.showAlert, actions: {
                TextField("Circuit", text: $mainModel.newName)
                
                Button("Create", action: {
                    if mainModel.newName.isEmpty {
                        mainModel.showAlert = false
                        return
                    }
                    
                    withAnimation {
                        mainModel.tabs.append(mainModel.newName)
                        mainModel.newName = ""
                        mainModel.showAlert = false
                    }
                })
                
                Button("Cancel", role: .cancel, action: {
                    mainModel.newName = ""
                })
            })
            
            VStack {
                Text("Add Another Circuit")
                    .font(.title3)
                    .padding()
                
                Text("(upper left corner)")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(introModel: IntroModel())
    }
}
