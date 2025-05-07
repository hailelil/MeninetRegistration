//
//  RegisteredUsersListView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI
import CoreData

struct RegisteredUsersListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: RegisteredUser.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RegisteredUser.firstName, ascending: true)]
    ) private var users: FetchedResults<RegisteredUser>

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 4) // Adjust vertical padding

                List(filteredUsers) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            if let photoData = user.photo, let uiImage = UIImage(data: photoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            }

                            VStack(alignment: .leading) {
                                Text("\(user.firstName ?? "") \(user.fatherName ?? "") \(user.grandFatherName ?? "")")
                                    .font(.headline)
                                Text("ID: \(user.identityNumber ?? "N/A")")
                                    .font(.headline)
                                Text("Phone: \(user.phoneNumber ?? "")")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Identities")
            .navigationBarTitleDisplayMode(.inline) // Ensure title is inline
        }
    }

    private var filteredUsers: [RegisteredUser] {
        if searchText.isEmpty {
            return Array(users)
        } else {
            return users.filter { user in
                (user.firstName?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                (user.fatherName?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                (user.grandFatherName?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                (user.identityNumber?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                (user.phoneNumber?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
}

struct RegisteredUsersListView_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredUsersListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

