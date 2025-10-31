//
//  AKWebView.swift
//  AboutKit
//
//  Created by PK on 2025/10/31.
//

import SwiftUI
import WebKit

@available(iOS 26.0, macOS 26.0, *)
struct AKWebView: View {
    let url: URL

    var body: some View {
        WebView(url: url)
            .navigationTitle(url.host ?? "Web Content")
            #if os(iOS) || os(visionOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .webViewBackForwardNavigationGestures(.disabled)
    }
}
