SwiftUI Simple Toast Messages

https://github.com/user-attachments/assets/edc603f1-b6c8-47b8-b604-58f6d08fbaa6


**How to use?**

import RToastView
struct ContentView: View {

    @StateObject var bottomToastViewModel = RToastViewModel(position: .bottom)
    @StateObject var topToastViewModel = RToastViewModel(position: .top)
    
    var body: some View {
        ZStack {
            VStack {
                Button("Fire Top Toasts") {
                    topToastViewModel.addToast(message: "Toast Message")
                }
                Button("Fire Bottom Toasts") {
                    bottomToastViewModel.addToast(message: "Toast Message")
                }
            }
            .padding()
            RToastView(viewModel: bottomToastViewModel)
            RToastView(viewModel: topToastViewModel)
        }
    }
}

