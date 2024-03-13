//
//  BottomSheet.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 12/03/2024.
//

import SwiftUI

struct Demo: View {
    @State var visible = true
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy(duration: 0.3)) {
                visible.toggle()
            }
        }) {
            Text("Change Visible")
        }
        .bottomSheet(visible: $visible) {
            VStack {
                Text("he")
                Text("he")
            }
        }
    }
}

struct BottomSheet<Content: View>: View {
    @Binding var visible: Bool
    @State private var offset = CGSizeZero
    @State var content: Content

    init(visible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._visible = visible
    }

    var body: some View {
        ZStack {
            if visible {
                VisualEffectView(effect: UIBlurEffect(style: .regular))
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                    .onTapGesture {
                        withAnimation {
                            visible.toggle()
                        }
                    }
                    .ignoresSafeArea()
                    .zIndex(0)
            }
            
            VStack {
                Spacer()
                Color(UIColor.systemGray6)
                    .frame(height: 20-max(offset.height, -8))
                    .padding(.bottom, -20)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .zIndex(1)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(minHeight: visible ? .zero : UIScreen.main.bounds.height * 2)
                
                VStack(spacing: 0) {
                    HStack {
                        Color(UIColor.systemGray3)
                            .frame(width: 64, height: 4)
                            .clipShape(Capsule())
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color(UIColor.systemGray))
                            .font(.system(size: 32))
                    }
                    .padding(.vertical, 16)

                    content
                        .padding(.bottom, .bottomSafeAreaHeight)
                        .frame(width: UIScreen.main.bounds.width)
                    
                }
                .fixedSize(horizontal: true, vertical: true)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(32, corners: [.topLeft, .topRight])
                .offset(x: 0, y: max(offset.height, -8))
//                .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: -20)
//                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -10)
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
            }
            .zIndex(2)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxHeight: UIScreen.main.bounds.height - .bottomSafeAreaHeight - .topSafeAreaHeight)
    }
}

#Preview {
    Demo()
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
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


struct BottomSheetModifier<CustomContent: View>: ViewModifier {
    @Binding var visible: Bool
    var customContent: () -> CustomContent
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheet(visible: $visible) {
                customContent()
            }
        }
    }
}

