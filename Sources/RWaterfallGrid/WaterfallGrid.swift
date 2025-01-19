//
//  WaterfallGrids.swift
//  Photoverse
//
//  Created by rajasekar.r on 17/01/25.
//

import SwiftUI

public protocol WaterfallGridItemContract: Identifiable {
    var gridHeight: CGFloat { get }
}

public struct WaterfallGrid<I, IV>: View where I: WaterfallGridItemContract, IV: View {
    struct Column {
        var items: [I]
    }

    let items: [I]
    private let numberOfColumns: Int
    private let columns: [Column]

    private let verticalSpacing: CGFloat
    private let horizontalSpacing: CGFloat

    @ViewBuilder
    private let itemView: (I) -> IV

    public init(
        items: [I],
        numberOfColumns: Int,
        verticalSpacing: CGFloat = 8,
        horizontalSpacing: CGFloat = 8,
        @ViewBuilder itemView: @escaping (I) -> IV
    ) {
        self.items = items
        self.numberOfColumns = numberOfColumns
        self.itemView = itemView
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing

        var columnsHeight = Array<CGFloat>(repeating: 0, count: numberOfColumns)
        var columns = Array<Column>(repeating: Column(items: []), count: numberOfColumns)

        for item in items {
            guard let minHeightColumn = columnsHeight.firstIndexOfMin()
            else { continue }
            columns[minHeightColumn].items.append(item)
            columnsHeight[minHeightColumn] += (item.gridHeight + verticalSpacing)
        }

        self.columns = columns
    }

    public var body: some View {
        HStack(alignment: .top, spacing: horizontalSpacing) {
            ForEach(0..<numberOfColumns, id: \.self) { column in
                LazyVStack(spacing: verticalSpacing) {
                    ForEach(columns[column].items) { item in
                        itemView(item)
                            .frame(height: item.gridHeight)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
#Preview {
    WaterfallGridDemoView()
}


public extension Array where Element: Comparable {
    func firstIndexOfMin() -> Index? {
        guard let minElement = self.min() else { return nil }
        return self.firstIndex(of: minElement)
    }
}
