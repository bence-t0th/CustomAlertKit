//
//  CustomAlertKit.swift
//  CustomAlertKit
//
//  Created by Bence Tóth on 12/03/2024.
//

import SwiftUI

public extension View {
    
    /// Presents a bottomsheet with custom content when a given condition is true.
    ///
    /// Use this modifier to display a bottomsheet with custom content.
    ///
    ///     struct Demo: View {
    ///         @State var visible = false
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 withAnimation(.bouncy(duration: 0.3)) {
    ///                     visible.toggle()
    ///                 }
    ///             }) {
    ///                 Text("Change vbaisible")
    ///             }
    ///             .bottomSheet(visible: $visible) {
    ///                 Text("Text on bottomsheet")
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - visible: A binding to a Boolean value that determines
    ///   whether to present the bottomsheet. When the user swipes down or
    ///   taps outside of the bottomsheet, this value will be false.
    ///   - content: The custom content of the bottomsheet
    ///
    /// - Returns: A view that's capable of displaying a bottomsheet with custom
    ///   content
    func bottomSheet(visible: Binding<Bool>, background: BackgroundType? = nil, bottomSheetBackgroundColor: Color, content: @escaping () -> some View) -> some View {
        modifier(BottomSheetModifier(visible: visible, background: background, bottomSheetBackgroundColor: bottomSheetBackgroundColor, customContent: content))
    }
    
    
    /// Presents a snackbar with custom content when a given condition is true.
    ///
    /// Use this modifier to display a snackbar with custom content.
    ///
    ///     struct Demo: View {
    ///         @State var visible = false
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 withAnimation(.bouncy(duration: 0.3)) {
    ///                     visible.toggle()
    ///                 }
    ///             }) {
    ///                 Text("Change visible")
    ///             }
    ///             .snackbar(visible: $visible) {
    ///                 Text("Text on snackbar")
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - visible: A binding to a Boolean value that determines
    ///   whether to present the snackbar. When the user swipes down this value will be false.
    ///   - content: The custom content of the snackbar
    ///
    /// - Returns: A view that's capable of displaying a snackbar at the bottom of the screen
    ///   with custom content
    func snackbar(visible: Binding<Bool>, content: @escaping () -> some View) -> some View {
        modifier(SnackbarModifier(visible: visible, customContent: content))
    }
}

public enum BackgroundType {
    case blur(UIBlurEffect.Style)
    case color(Color)
}
