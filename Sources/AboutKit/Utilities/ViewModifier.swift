//
//  ViewModifier.swift
//  AboutKit
//
//  Created by PK on 2024/10/21.
//

import SwiftUI

struct FormStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            content
                .formStyle(.grouped)
        } else {
            content
        }
    }
}
