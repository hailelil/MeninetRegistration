//
//  HelpView.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Login")
                    .font(.headline)
                
                Text("1. Enter your username and password in the respective fields.")
                Text("2. Select your user type from the dropdown menu.")
                Text("3. Click the 'Login' button to access the app.")
                
                Divider()
                
                Text("Forgot Password?")
                    .font(.headline)
                
                Text("If you forgot your password, please contact your system administrator or use the 'Forgot Password' button to reset your password.")
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Help", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                // Dismiss the view
                dismiss()
            })
        }
    }

    private func dismiss() {
        // Logic to dismiss the view
        // This would typically be handled by the presenting view
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
