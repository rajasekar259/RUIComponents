//
//  WaterfallGridDemoView.swift
//  Photoverse
//
//  Created by rajasekar.r on 17/01/25.
//

import SwiftUI
import RGridIconView

@available(iOS 16.0, *)
public struct WaterfallGridDemoView: View {
    @Namespace var girdItem

    struct GridItem: WaterfallGridItemContract, Equatable {
        let id = UUID().uuidString
        let gridHeight: CGFloat
        let color: Color
        let isLoading: Bool
    }

    @State var numberOfColums = 2
    @State var spacing = CGFloat(5)
    @State var items = [GridItem(
        gridHeight: 50,
        color: .white, isLoading: true
    )]

    @State var fetching = false

    public init() {}

    @ViewBuilder
    func contentGridView() -> some View {
        WaterfallGrid(
            items: items,
            numberOfColumns: numberOfColums,
            verticalSpacing: spacing,
            horizontalSpacing: spacing
        ) { item in
            Button {

            } label: {
                Group {
                    if item.isLoading {
                        VStack {
                            if fetching {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.gray)
                            } else {
                                EmptyView()
                            }
                        }
                        .onAppear {
                            Task {
                                await loadMore()
                            }
                        }
                        .task {
                            Task {
                                await loadMore()
                            }
                        }
                    } else {
                        Text(String(format: "%.0f", item.gridHeight))
                    }
                }
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: item.gridHeight)
                .background(item.color)
                .clipShape(RoundedRectangle(cornerRadius: spacing))
                .matchedGeometryEffect(id: item.id, in: girdItem)
                .shadow(color: .black.opacity(0.2), radius: spacing/2)
            }
            .tint(.white)
            .id(item.id)
        }
        .padding(spacing)
    }

    public var body: some View {
        NavigationStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    contentGridView()
                        .navigationTitle("Waterfall Grid")
                        .toolbar {
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Button {
                                    numberOfColums = max(1, (numberOfColums + 1) % 5)
                                    withAnimation {
                                        if let firstItem = items.first {
                                            scrollViewProxy.scrollTo(firstItem.id)
                                        }
                                    }
                                } label: {
                                    RGridIconView(numberOfRows: 2, numberOfColumns: numberOfColums)
                                        .padding(5)
                                        .frame(width: 40, height: 40)
                                }

                                Menu {
                                    Slider(value: $spacing, in: 1...20, step: 1)
                                } label: {
                                    Image(systemName: "space")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .overlay {
                                            Text("\(Int(spacing))")
                                                .padding(.bottom)
                                        }
                                }
                            }
                        }
                }
            }
        }
        .animation(.smooth, value: spacing)
        .animation(.snappy, value: numberOfColums)
        .animation(.smooth, value: items)
        .animation(.smooth, value: fetching)
    }

    func loadMore() async {
        guard !fetching else { return }

        fetching = true

        try? await Task.sleep(for: .seconds(2))

        let newItems = (1...10).map { _ in
            GridItem(
                gridHeight: CGFloat((50...200).randomElement()!),
                color: [Color.blue, .green, .yellow, .red].randomElement()!, isLoading: false
            )
        }

        withAnimation(.smooth) {
            let loadingItem = items.removeLast()
            self.items += (newItems + [loadingItem])
            fetching = false
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    WaterfallGridDemoView()
}
