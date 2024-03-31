//
//  Alert.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 26/03/2024.
//

import SwiftUI

struct Alert<Content: View>: View {
    @Binding var visible: Bool
    @State var content: Content
    var alertBackground: BackgroundType?
    
    init(visible: Binding<Bool>, background: BackgroundType?, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._visible = visible
        self.alertBackground = background
    }
    
    var body: some View {
        ZStack {
            if visible {
                switch alertBackground {
                case .blur(let style):
                    VisualEffectView(effect: UIBlurEffect(style: style))
                case .color(let color):
                    color
                case nil:
                    EmptyView()
                }
                                
                content
                    .opacity(visible ? 1 : 0)
                    .transition(.asymmetric(insertion: .scale(scale: 0.95, anchor: .bottom).combined(with: .opacity), removal: .identity))
            }
        }
        .ignoresSafeArea()
    }
}
