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
    ///     @State var visible = false
    ///
    ///     var body: some View {
    ///         ...
    ///         }
    ///         .bottomSheet(visible: $visible,
    ///                      background: .blur(.extraLight),
    ///                      contentBackgroundColor: .white) {
    ///             Text("Text on bottomsheet")
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - visible: A binding to a Boolean value that determines
    ///   whether to present the bottomsheet. When the user swipes down or
    ///   taps outside of the bottomsheet, this value will be false.
    ///   - background: BackgroundType, that determines the background behind
    ///   the bottomsheet
    ///   - contentBackgroundColor: The background color of the bottomsheet
    ///   - content: The custom content of the bottomsheet
    ///
    /// - Returns: A view that's capable of displaying a bottomsheet with custom
    ///   content
    func bottomSheet(visible: Binding<Bool>, background: BackgroundType? = nil, contentBackgroundColor: Color, content: @escaping () -> some View) -> some View {
        modifier(BottomSheetModifier(visible: visible, background: background, contentBackgroundColor: contentBackgroundColor, customContent: content))
    }
    
    
    /// Presents a snackbar with custom content when a given condition is true. It disappears
    /// after 3 seconds.
    ///
    /// Use this modifier to display a snackbar at the bottom of the screen with custom content.
    ///
    ///     @State var visible = false
    ///
    ///     var body: some View {
    ///         ...
    ///         }
    ///         .snackbar(visible: $visible) {
    ///             Text("Text on snackbar")
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - visible: A binding to a Boolean value that determines
    ///   whether to present the snackbar. When the user swipes down this value will be false.
    ///   - content: The custom content of the snackbar
    ///
    /// - Returns: A view that's capable of displaying a snackbar with custom content
    ///   at the bottom of the screen
    func snackbar(visible: Binding<Bool>, content: @escaping () -> some View) -> some View {
        modifier(SnackbarModifier(visible: visible, customContent: content))
    }
    
    
    /// Presents an alert with custom content when a given condition is true.
    ///
    /// Use this modifier to display an alert with custom content.
    ///
    ///     @State var visible = false
    ///
    ///     var body: some View {
    ///         ...
    ///         }
    ///         .alert(visible: $visible, background: .color(.red)) {
    ///             Text("Text on alert")
    ///                 .padding(16)
    ///                 .background(.white)
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - visible: A binding to a Boolean value that determines
    ///   whether to present the alert. Providing a dismiss button is the developers
    ///   responsibility.
    ///   - background: BackgroundType, that determines the background behind
    ///   the alert
    ///   - content: The custom content of the alert
    ///
    /// - Returns: A view that's capable of displaying an alert with custom
    ///   content in the middle of the screen
    func alert(visible: Binding<Bool>, background: BackgroundType? = nil, content: @escaping () -> some View) -> some View {
        modifier(AlertModifier(visible: visible, background: background, customContent: content))
    }
}


/// The background types behind some views
///
/// - blur:     The background is a UIVisualEffectView with the given UIBlurEffect
/// - color:   The background is the given color
public enum BackgroundType {
    case blur(UIBlurEffect.Style)
    case color(Color)
}
