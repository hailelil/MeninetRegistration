//
//  MainView.swift
//  Meninet
//
//  Created by HLD on 17/05/2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isLoggedIn: Bool
    @State private var loggedInUsername: String = ""

    var body: some View {
        TabView {
            NavigationView {
                RegistrationFormView()
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("Register")
            }

            NavigationView {
                RegisteredUsersListView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Identity List")
            }

            NavigationView {
                UserSearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }

            NavigationView {
                StatisticsView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Statistics")
            }

            NavigationView {
                SettingsView(isLoggedIn: $isLoggedIn, username: $loggedInUsername)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isLoggedIn: .constant(false)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
