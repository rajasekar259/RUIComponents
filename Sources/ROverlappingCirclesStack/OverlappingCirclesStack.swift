//
//  OverlappingCirclesStack.swift
//  RUIComponents
//
//  Created by Rajasekar R on 05/06/25.
//

import SwiftUI


public struct OverlappingCirclesStack<Data, Content>: View where Data : RandomAccessCollection, Content : View {
    let items: Data
    
    let overlappingOffset: CGFloat
    let spacing: CGFloat
    let isFirstItemPrimary: Bool
    @ViewBuilder var itemView: (Data.Element) -> Content
    
    public init(_ data: Data, overlappingOffset: CGFloat = 30, spacing: CGFloat = 5, isFirstItemPrimary: Bool = false, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = data
        self.itemView = content
        self.overlappingOffset = overlappingOffset
        self.spacing = spacing
        self.isFirstItemPrimary = isFirstItemPrimary
    }
    
    public var body: some View {
        HStack(spacing: -overlappingOffset) {
            ForEach(
                items.enumerated().map { (offset: $0.0, element: $0.1) },
                id: \.offset
            ) { item in
                Circle()
                    .zIndex(Double(isFirstItemPrimary ? items.count - item.offset : item.offset))
                    .blendMode(.destinationOut)
                    .overlay {
                        itemView(item.element)
                            .clipShape(Circle())
                            .padding(spacing)
                    }
            }
        }
        .compositingGroup()
    }
}

#Preview {
    OverlappingCirclesStackPreview()
}
