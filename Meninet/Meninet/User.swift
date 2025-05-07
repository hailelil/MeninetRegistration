//
//  User.swift
//  Meninet
//
//  Created by HLD on 17/05/2024.
//

import Foundation

enum UserType: String, CaseIterable, Identifiable {
    case admin, issuer, verifier

    var id: String { self.rawValue }
}

struct User: Identifiable {
    var id = UUID()
    var username: String
    var password: String
    var userType: UserType
}
