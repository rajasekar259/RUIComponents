//
//  RProgressView.swift
//  RUIComponents
//
//  Created by rajasekar.r on 11/02/25.
//

import SwiftUI

struct RProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.spinningCircularProgress)
            .foregroundStyle(.blue)
    }
}

#Preview {
    RProgressView()
}

public extension ProgressViewStyle where Self == SpinningCircularProgressStyle {
    static var spinningCircularProgress: Self { .init() }
}


public struct SpinningCircularProgressStyle: ProgressViewStyle {
    let size: CGFloat
    let lineWidth: CGFloat
    let progress: CGFloat
    @State private var isAnimating = false

    init(size: CGFloat = 20, progress: CGFloat = 0.65) {
        self.size = size
        self.progress = progress
        self.lineWidth = size / 10
    }

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0.0, to: min(1.0, self.progress))
                .stroke(
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.radians(isAnimating ? 2 * CGFloat.pi : 0))
        }
        .padding(lineWidth/2)
        .frame(width: size, height: size)
        .onAppear {
            isAnimating = true
        }
        .onDisappear {
            isAnimating = false
        }
        .animation(
            .linear(duration: 1.0)
            .repeatForever(autoreverses: false),
            value: isAnimating
        )
    }
}
