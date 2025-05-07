//
//  RegisterTabView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI

struct RegisterTabView: View {
    var body: some View {
        TabView {
            RegistrationFormView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Register")
                }

            RegisteredUsersListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Registered Users")
                }
        }
    }
}

struct RegisterTabView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTabView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
