//
//  Snackbar.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 20/03/2024.
//

import SwiftUI

struct Snackbar<Content: View>: View {
    @Binding var visible: Bool
    @State var content: Content
    @State var timer = Timer.publish(every: 3, on: .main, in: .commonModes).autoconnect()
    
    init(visible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._visible = visible
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            if visible {
                content
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                    .padding([.horizontal, .bottom], 16)
                    .gesture(DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.height > 10 {
                                timer.upstream.connect().cancel()
                                withAnimation {
                                    visible = false
                                }
                            }
                        }
                    )
            }
        }
        .onChange(of: visible) { newValue in
            if newValue {
                timer = Timer.publish(every: 3, on: .main, in: .commonModes).autoconnect()
            }
        }
        .onReceive(timer) { _ in
            timer.upstream.connect().cancel()
            withAnimation(.bouncy(duration: 0.3)) {
                visible = false
            }
        }
    }
}
