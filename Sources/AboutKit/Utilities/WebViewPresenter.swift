//
//  WebViewPresenter.swift
//  AboutKit
//
//  Created by PK on 2025/10/31.
//

import SwiftUI

/// An action that presents a URL in an in-app web view when available,
/// falling back to the default browser otherwise.
struct OpenWebViewAction: Sendable {
    let action: @MainActor @Sendable (URL) -> Void
    
    @MainActor
    func callAsFunction(_ url: URL) {
        action(url)
    }
}

struct OpenWebViewKey: EnvironmentKey {
    static let defaultValue = OpenWebViewAction { _ in
        assertionFailure("OpenWebViewAction was not properly installed.")
    }
}

extension EnvironmentValues {
    /// An action that presents a URL in an in-app web view when available.
    var openWebView: OpenWebViewAction {
        get { self[OpenWebViewKey.self] }
        set { self[OpenWebViewKey.self] = newValue }
    }
}

/// A view modifier that adds the necessary components to present a URL
/// within the app using a WebView, with appropriate platform and OS version checks.
struct WebViewPresenter: ViewModifier {
    @Environment(\.openURL) private var openURL
    
    @State private var webViewURL: URL?

    @MainActor
    private func open(_ url: URL) {
        if #available(iOS 26.0, macOS 26.0, *) {
            self.webViewURL = url
        } else {
            openURL(url)
        }
    }

    func body(content: Content) -> some View {
        content
            .environment(\.openWebView, OpenWebViewAction(action: open))
            .sheet(item: $webViewURL) { url in
                if #available(iOS 26.0, macOS 26.0, *) {
                    AKWebView(url: url)
                }
            }
    }
}

extension URL: @retroactive Identifiable {
    public var id: String { self.absoluteString }
}

extension View {
    /// Adds the capability to present a URL in an in-app WebView.
    ///
    /// Use the `openWebView` environment action to trigger the presentation.
    func presentsWebView() -> some View {
        self.modifier(WebViewPresenter())
    }
}
