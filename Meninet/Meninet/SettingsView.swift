//
//  SettingsView.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @State private var showChangePassword = false
    @State private var syncStatus: String = "Not Synced"

    var body: some View {
        Form {
            Section(header: Text("My Session")) {
                NavigationLink(destination: MySessionView(username: username)) {
                    Text("View Session Details")
                }
            }

            Section(header: Text("Account Settings")) {
                Button(action: {
                    showChangePassword.toggle()
                }) {
                    Text("Change Password")
                }
                .sheet(isPresented: $showChangePassword) {
                    ChangePasswordView()
                }
            }

            Section(header: Text("Help")) {
                NavigationLink(destination: HelpView()) {
                    Text("Help & Support")
                }
            }

            Section(header: Text("Sync")) {
                Button(action: {
                    syncData()
                }) {
                    HStack {
                        Text("Sync Registered Users")
                        Spacer()
                        Text(syncStatus)
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
            }

            Section {
                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarTitle("Settings")
    }

    func syncData() {
        syncStatus = "Synced at \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))"
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLoggedIn: .constant(true), username: .constant("example_user"))
    }
}
