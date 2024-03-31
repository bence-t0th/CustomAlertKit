//
//  ViewModifiers.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 20/03/2024.
//

import SwiftUI

struct BottomSheetModifier<CustomContent: View>: ViewModifier {
    @Binding var visible: Bool
    var background: BackgroundType?
    var contentBackgroundColor: Color
    var customContent: () -> CustomContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheet(visible: $visible, background: background, contentBackgroundColor: contentBackgroundColor) {
                customContent()
            }
        }
    }
}

struct SnackbarModifier<CustomContent: View>: ViewModifier {
    @Binding var visible: Bool
    var customContent: () -> CustomContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Snackbar(visible: $visible) {
                customContent()
            }
        }
    }
}

struct AlertModifier<CustomContent: View>: ViewModifier {
    @Binding var visible: Bool
    var background: BackgroundType?
    var customContent: () -> CustomContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Alert(visible: $visible, background: background) {
                customContent()
            }
        }
    }
}
