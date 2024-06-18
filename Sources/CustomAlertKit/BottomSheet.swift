//
//  BottomSheet.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 12/03/2024.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var visible: Bool
    @State private var offset = CGSizeZero
    @State var content: Content
    @State var bottomSheetBackground: BackgroundType?
    @State var contentBackgroundColor: Color
    private var closable: Bool
    
    @ViewBuilder var background: some View {
        switch bottomSheetBackground {
        case .blur(let style):
            VisualEffectView(effect: UIBlurEffect(style: style))
        case .color(let color):
            color
        case nil:
            Color.clear
        }
    }
    
    init(visible: Binding<Bool>, background: BackgroundType?, contentBackgroundColor: Color, closable: Bool, @ViewBuilder content: @escaping () -> Content) {
        self._visible = visible
        self.content = content()
        self.bottomSheetBackground = background
        self.contentBackgroundColor = contentBackgroundColor
        self.closable = closable
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            
            if visible {
                content
                    .padding(.bottom, .bottomSafeAreaHeight + 50)
                    .frame(width: UIScreen.main.bounds.width)
                    .fixedSize(horizontal: true, vertical: true)
                    .background(contentBackgroundColor)
                    .cornerRadius(32, corners: [.topLeft, .topRight])
                    .offset(x: 0, y: closable ? max(offset.height, -8) : 0 + 50)
                    .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: -20)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -10)
                    .gesture(DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            if closable {
                                withAnimation {
                                    if offset.height > 100 {
                                        visible = false
                                    }
                                    offset = .zero
                                }
                            }
                        }
                    )
                    .transition(.move(edge: .bottom).animation(.bouncy))
            }
            
            contentBackgroundColor
                .frame(height: 30)
                .offset(x: 0, y: max(offset.height, -8))
                .padding(.bottom, -30)
                .opacity(visible ? 1 : 0)
        }
        .background(
            background
                .ignoresSafeArea()
                .onTapGesture {
                    if closable {
                        withAnimation {
                            visible.toggle()
                        }
                    }
                }
                .opacity(visible ? 1 : 0)
        )
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxHeight: UIScreen.main.bounds.height - .bottomSafeAreaHeight - .topSafeAreaHeight)
    }
}
