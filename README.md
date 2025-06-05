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

## WaterfallGrid

<pre> ```
    import RWaterfallGrid


    
    WaterfallGrid(
            items: items,
            numberOfColumns: numberOfColums,
            verticalSpacing: spacing,
            horizontalSpacing: spacing
        ) { item in

        //Configure Your view

        }
``` </pre>

![Simulator Screenshot - iPhone 16 Pro - 2025-01-17 at 13 39 00](https://github.com/user-attachments/assets/5125e2a3-e4c5-4192-964b-d5db24563313)

https://github.com/user-attachments/assets/18c123b0-6fe6-4d5d-8fc4-1b11ca147e25


## Overlapping Circles Stack: True separation using blend mode and composition Group

<pre> ```
    import ROverlappingCirclesStack


    let colors = [Color.blue, Color.green, Color.yellow, Color.red]
    
    OverlappingCirclesStack(
                colors,
                id: \.self,
                overlappingOffset: 50,
                spacing: 5
            ) { $0 }
``` </pre>

![ContentView](https://github.com/user-attachments/assets/3c8d1fe1-fc24-4837-9397-f64f1ea4fd87)

