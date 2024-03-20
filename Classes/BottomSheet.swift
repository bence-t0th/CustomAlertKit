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
    @State var backgroundColor: Color
    
    init(visible: Binding<Bool>, backgroundColor: Color, @ViewBuilder content: @escaping () -> Content) {
        self._visible = visible
        self.content = content()
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(minHeight: visible ? .zero : UIScreen.main.bounds.height * 2)
            
            VStack(spacing: 0) {
                Color(UIColor.systemGray3)
                    .frame(width: 32, height: 4)
                    .clipShape(Capsule())
                    .padding(.vertical, 16)
                
                content
                    .padding(.bottom, .bottomSafeAreaHeight)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .fixedSize(horizontal: true, vertical: true)
            .background(backgroundColor)
            .cornerRadius(32, corners: [.topLeft, .topRight])
            .offset(x: 0, y: max(offset.height, -8))
            .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: -20)
            .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -10)
            .mask(Rectangle()
                .padding(.top, -100)
            )
            .gesture(DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation(.bouncy(duration: 0.3)) {
                        if offset.height > 100 {
                            visible = false
                        }
                        offset = .zero
                    }
                }
            )
            
            backgroundColor
                .frame(height: 30)
                .offset(x: 0, y: max(offset.height, -8))
                .padding(.bottom, -30)
                .edgesIgnoringSafeArea(.bottom)
        }
        
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .regular))
                .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                .onTapGesture {
                    withAnimation {
                        visible.toggle()
                    }
                }
                .opacity(visible ? 1.0 : 0.0)
        )
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxHeight: UIScreen.main.bounds.height - .bottomSafeAreaHeight - .topSafeAreaHeight)
    }
}
