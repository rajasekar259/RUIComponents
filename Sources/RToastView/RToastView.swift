//
//  RToastView.swift
//  RToastViewApp
//
//  Created by rajasekar.r on 09/08/24.
//

import SwiftUI

public struct ToastMessageView: View {
    let message: String
    let position: Toast.Position
    
    public init(message: String, position: Toast.Position) {
        self.message = message
        self.position = position
    }
    
    public var body: some View {
        Text(message)
            .font(.system(size: 13))
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .transition(
                .move(edge: position == .bottom ? .bottom : .top )
                .combined(with: .opacity)
            )
    }
}


public struct RToastView: View {
    @ObservedObject var viewModel: RToastViewModel
    
    public init(viewModel: RToastViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            if viewModel.position == .bottom { Spacer() }
            
            ForEach(viewModel.toasts) { toast in
                ToastMessageView(
                    message: toast.message,
                    position: viewModel.position
                )
                .onTapGesture {
                    viewModel.removeToast(toast)
                }
            }
            
            if viewModel.position == .top { Spacer() }
        }
        .padding()
        .animation(.spring(duration: 0.5),  value: viewModel.toasts)
    }
}

#Preview {
    RToastView(
        viewModel: .init(
            messages: ["Message 1", "Message 2"]
        )
    )
}
