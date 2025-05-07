//
//  UIApplication+Extension.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
