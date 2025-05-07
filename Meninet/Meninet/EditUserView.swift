//
//  EditUserView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//
import SwiftUI
import CoreData

struct EditUserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var user: RegisteredUser
    
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var sourceType: ImageSourceType = .photoLibrary

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Photo")) {
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                        } else if let photoData = user.photo, let photo = UIImage(data: photoData) {
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                        }

                        HStack {
                            Button(action: {
                                sourceType = .photoLibrary
                                showImagePicker = true
                            }) {
                                Text("Choose Photo")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 10)

                            Button(action: {
                                sourceType = .camera
                                showImagePicker = true
                            }) {
                                Text("Take Photo")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 10)
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage, sourceType: $sourceType)
                    }
                }

                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: Binding(
                        get: { user.firstName ?? "" },
                        set: { user.firstName = $0 }
                    ))
                    TextField("Father's Name", text: Binding(
                        get: { user.fatherName ?? "" },
                        set: { user.fatherName = $0 }
                    ))
                    TextField("Grandfather's Name", text: Binding(
                        get: { user.grandFatherName ?? "" },
                        set: { user.grandFatherName = $0 }
                    ))
                    DatePicker("Date of Birth", selection: Binding(
                        get: { user.dob ?? Date() },
                        set: { user.dob = $0 }
                    ), displayedComponents: .date)
                    TextField("Citizenship", text: Binding(
                        get: { user.citizenship ?? "" },
                        set: { user.citizenship = $0 }
                    ))
                    TextField("Place of Birth", text: Binding(
                        get: { user.placeOfBirth ?? "" },
                        set: { user.placeOfBirth = $0 }
                    ))
                    TextField("Sex", text: Binding(
                        get: { user.sex ?? "" },
                        set: { user.sex = $0 }
                    ))
                    Picker("Marital Status", selection: Binding(
                        get: { user.maritalStatus ?? "" },
                        set: { user.maritalStatus = $0 }
                    )) {
                        Text("Single").tag("Single")
                        Text("Married").tag("Married")
                        Text("Divorced").tag("Divorced")
                        Text("Widowed").tag("Widowed")
                    }
                    if user.maritalStatus == "Married" {
                        TextField("Spouse ID Number", text: Binding(
                            get: { user.spouseIDNumber ?? "" },
                            set: { user.spouseIDNumber = $0 }
                        ))
                    }
                    TextField("Education Level", text: Binding(
                        get: { user.educationLevel ?? "" },
                        set: { user.educationLevel = $0 }
                    ))
                }

                Section(header: Text("Mother's Information")) {
                    TextField("Mother's First Name", text: Binding(
                        get: { user.mothersFirstName ?? "" },
                        set: { user.mothersFirstName = $0 }
                    ))
                    TextField("Mother's Father's Name", text: Binding(
                        get: { user.mothersFatherName ?? "" },
                        set: { user.mothersFatherName = $0 }
                    ))
                }

                Section(header: Text("Address Information")) {
                    TextField("Region", text: Binding(
                        get: { user.selectedRegion ?? "" },
                        set: { user.selectedRegion = $0 }
                    ))
                    TextField("City", text: Binding(
                        get: { user.selectedCity ?? "" },
                        set: { user.selectedCity = $0 }
                    ))
                    TextField("District", text: Binding(
                        get: { user.selectedDistrict ?? "" },
                        set: { user.selectedDistrict = $0 }
                    ))
                }

                Section(header: Text("Contact Information")) {
                    TextField("Phone Number", text: Binding(
                        get: { user.phoneNumber ?? "" },
                        set: { user.phoneNumber = $0 }
                    ))
                    TextField("Email Address", text: Binding(
                        get: { user.emailAddress ?? "" },
                        set: { user.emailAddress = $0 }
                    ))
                }
                
                Section {
                    Button(action: save) {
                        Text("Save")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationBarTitle("Edit User", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func save() {
        if let selectedImage = selectedImage {
            user.photo = selectedImage.jpegData(compressionQuality: 1.0)
        }

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(user: RegisteredUser())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

