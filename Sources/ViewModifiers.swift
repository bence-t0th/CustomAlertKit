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
    var bottomSheetBackgroundColor: Color
    var customContent: () -> CustomContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheet(visible: $visible, background: background, bottomSheetBackgroundColor: bottomSheetBackgroundColor) {
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
