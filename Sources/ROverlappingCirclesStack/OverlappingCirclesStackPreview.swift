//
//  OverlappingCirclesStackPreview.swift
//  RUIComponents
//
//  Created by Rajasekar R on 05/06/25.
//

import SwiftUI

struct OverlappingCirclesStackPreview: View {
    var gradientBackground: some View {
        LinearGradient(colors: [.red, .orange, .purple, .blue], startPoint: .leading, endPoint: .trailing)
    }
    
    let colors = [Color.blue, Color.green, Color.yellow, Color.red]
    
    var body: some View {
        VStack {
            OverlappingCirclesStack(
                colors,
                id: \.self,
                overlappingOffset: 50,
                spacing: 5
            ) { $0 }
            
            OverlappingCirclesStack(
                colors,
                id: \.self,
                overlappingOffset: 50,
                spacing: 5
            ) { $0 }
                .compositingGroup()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(gradientBackground)
        .ignoresSafeArea()
    }
}

#Preview {
    OverlappingCirclesStackPreview()
}
