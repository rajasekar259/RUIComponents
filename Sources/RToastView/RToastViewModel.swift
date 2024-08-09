//
//  ToastViewModel.swift
//  RToastViewApp
//
//  Created by rajasekar.r on 09/08/24.
//

import Foundation
import Combine

public struct Toast: Equatable, Identifiable {
    public let id = UUID().uuidString
    let message: String
    
    public static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        lhs.message == rhs.message
    }
}

public extension Toast {
    enum Position { case top, bottom }
}


@MainActor
public class RToastViewModel: ObservableObject {
    @Published var position: Toast.Position
    @Published var toasts: [Toast]
    
    public init(position: Toast.Position = .bottom, messages: [String] = []) {
        self.position = position
        self.toasts = messages.map { Toast(message: $0) }
    }
    
    public func removeToast(_ toast: Toast) {
        toasts.removeAll(where: { $0.id == toast.id })
    }
    
    public func addToast(message: String, duration: TimeInterval = 3) {
        let toast = Toast(message: message)
        
        switch position {
        case .bottom: toasts.append(toast)
        case .top: toasts.insert(toast, at: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.removeToast(toast)
        }
    }
}
