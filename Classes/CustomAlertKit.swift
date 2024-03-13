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
    ///                 Text("Change Visible")
    ///             }
    ///             .bottomSheet(visible: $visible)
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
    func bottomSheet(visible: Binding<Bool>, content: @escaping () -> some View) -> some View {
        modifier(BottomSheetModifier(visible: visible, customContent: content))
    }
}
