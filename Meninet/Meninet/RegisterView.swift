//
//  RegisterView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var selectedOption: String = "Register"

    var body: some View {
        VStack {
            if selectedOption == "Register" {
                RegistrationFormView()
            } else if selectedOption == "Registered Users" {
                RegisteredUsersListView()
            }
        }
        .navigationBarTitle("Register", displayMode: .inline)
        .navigationBarItems(trailing:
            Menu {
                Button(action: {
                    selectedOption = "Register"
                }) {
                    Label("Register", systemImage: "square.and.pencil")
                }

                Button(action: {
                    selectedOption = "Registered Users"
                }) {
                    Label("Registered Users", systemImage: "list.bullet")
                }
            } label: {
                Label("Options", systemImage: "ellipsis.circle")
                    .imageScale(.large)
            }
        )
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
