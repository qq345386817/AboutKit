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
    private let page = WebPage()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            WebView(page)
                .navigationTitle(page.title)
                #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(LocalizedStrings.done) {
                            dismiss()
                        }
                    }
                }
                #endif
                .webViewBackForwardNavigationGestures(.disabled)
        }
        .onAppear() {
            page.load(url)
        }
    }
}
