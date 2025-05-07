//
//  ForgotPasswordView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var username: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    let users = [
        User(username: "user1", password: "password1", userType: .admin),
        User(username: "user2", password: "password2", userType: .issuer),
        User(username: "user3", password: "password3", userType: .verifier),
        User(username: "user4", password: "password4", userType: .admin),
        User(username: "user5", password: "password5", userType: .issuer),
        User(username: "user6", password: "password6", userType: .verifier),
        User(username: "user7", password: "password7", userType: .admin),
        User(username: "user8", password: "password8", userType: .issuer),
        User(username: "user9", password: "password9", userType: .verifier),
        User(username: "user10", password: "password10", userType: .admin)
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Reset Password")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 50)
                    .padding(.horizontal)

                Button(action: {
                    handlePasswordReset()
                }) {
                    Text("Reset Password")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer()
            }
            .navigationBarTitle("Forgot Password", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func handlePasswordReset() {
        if let user = users.first(where: { $0.username == username }) {
            // In a real app, you would send a password reset request to the server here
            alertMessage = "An email with password reset instructions has been sent to \(user.username)"
        } else {
            alertMessage = "Username not found"
        }
        showAlert = true
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
