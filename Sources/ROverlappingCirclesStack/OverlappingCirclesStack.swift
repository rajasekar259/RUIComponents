//
//  OverlappingCirclesStack.swift
//  RUIComponents
//
//  Created by Rajasekar R on 05/06/25.
//

import SwiftUI


public struct OverlappingCirclesStack<Data, ID, Content>: View where Data : RandomAccessCollection, ID : Hashable, Content : View {
    let items: Data
    let id: KeyPath<Data.Element, ID>
    
    let overlappingOffset: CGFloat
    let spacing: CGFloat
    @ViewBuilder var itemView: (Data.Element) -> Content
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, overlappingOffset: CGFloat = 30, spacing: CGFloat = 5, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = data
        self.itemView = content
        self.id = id
        self.overlappingOffset = overlappingOffset
        self.spacing = spacing
    }
    
    public var body: some View {
        HStack(spacing: -overlappingOffset) {
            ForEach(items, id: id) { item in
                Circle()
                    .blendMode(.destinationOut)
                    .overlay {
                        itemView(item)
                            .clipShape(Circle())
                            .padding(spacing)
                    }
            }
        }
        .compositingGroup()
    }
}
