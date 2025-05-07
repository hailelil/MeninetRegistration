//
//  LogoutView.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//

import SwiftUI

struct LogoutView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Are you sure you want to log out?")
                    .font(.headline)
                    .padding()

                Button(action: {
                    // Perform logout action
                    isLoggedIn = false
                }) {
                    Text("Logout")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .navigationBarTitle("Logout")
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    @State static var isLoggedIn = true

    static var previews: some View {
        LogoutView(isLoggedIn: $isLoggedIn)
    }
}
