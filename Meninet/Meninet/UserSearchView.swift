//
//  UserSearchView.swift
//  Meninet
//
//  Created by HLD on 18/05/2024.
//

import SwiftUI
import CoreData

struct UserSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: RegisteredUser.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RegisteredUser.firstName, ascending: true)]
    ) private var users: FetchedResults<RegisteredUser>

    @State private var searchText: String = ""
    @State private var selectedUser: RegisteredUser?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 4) // Adjust vertical padding
                
                if !searchText.isEmpty {
                    List {
                        ForEach(users.filter { user in
                            user.firstName?.localizedCaseInsensitiveContains(searchText) ?? false ||
                            user.fatherName?.localizedCaseInsensitiveContains(searchText) ?? false ||
                            user.grandFatherName?.localizedCaseInsensitiveContains(searchText) ?? false ||
                            user.identityNumber?.localizedCaseInsensitiveContains(searchText) ?? false ||
                            user.phoneNumber?.localizedCaseInsensitiveContains(searchText) ?? false
                        }) { user in
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
                                        Text("\(user.firstName ?? "") \(user.fatherName ?? "")")
                                            .font(.headline)
                                        Text("ID: \(user.identityNumber ?? "N/A")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                }
            }
            .navigationBarTitle("User Search")
            .navigationBarTitleDisplayMode(.inline) // Ensure title is inline
        }
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
