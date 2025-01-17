//
//  GridIconView.swift
//  Photoverse
//
//  Created by rajasekar.r on 17/01/25.
//

import SwiftUI

public struct RGridIconView: View {
    let numberOfRows: Int
    let numberOfColumns: Int
    let spacing: CGFloat

    public init(numberOfRows: Int, numberOfColumns: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        self.spacing = 10 / CGFloat(max(numberOfRows, numberOfColumns))
    }

    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfColumns, id: \.self) { _ in
                VStack(spacing: spacing) {
                    ForEach(0..<numberOfRows, id: \.self) { _ in
                        GeometryReader { proxy in
                            RoundedRectangle(
                                cornerRadius: min(min(proxy.size.width, proxy.size.height) / 2, 8)
                            )
                        }
                    }
                }
            }
        }
        .animation(.spring, value: numberOfColumns)
        .animation(.spring, value: numberOfRows)
        .animation(.spring, value: spacing)
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var numberOfColumns = 1
    @Previewable @State var numberOfRows = 2
    Button {
        numberOfRows = (1...4).randomElement()!
        numberOfColumns = (1...4).randomElement()!
    } label: {
        RGridIconView(numberOfRows: numberOfRows, numberOfColumns: numberOfColumns)
            .frame(width: 40, height: 40)
    }
}
