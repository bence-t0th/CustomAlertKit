//
//  Extensions.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 20/03/2024.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension CGFloat {
    static var topSafeAreaHeight: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.keyWindow?.safeAreaInsets.top ?? .zero
    }
    
    static var bottomSafeAreaHeight: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.keyWindow?.safeAreaInsets.bottom ?? .zero
    }
}
