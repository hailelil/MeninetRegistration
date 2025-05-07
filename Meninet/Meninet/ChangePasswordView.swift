//
//  ChangePasswordView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Current Password")) {
                    SecureField("Current Password", text: $currentPassword)
                }

                Section(header: Text("New Password")) {
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm Password", text: $confirmPassword)
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button(action: {
                    changePassword()
                }) {
                    Text("Change Password")
                }
            }
            .navigationBarTitle("Change Password")
        }
    }

    func changePassword() {
        // Add logic to change password
        if newPassword != confirmPassword {
            showError = true
            errorMessage = "Passwords do not match"
        } else {
            // Handle password change logic
            showError = false
            // Dismiss view after successful password change
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
