import SwiftUI
import CoreData

struct RegistrationFormView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var firstName: String = ""
    @State private var fatherName: String = ""
    @State private var grandFatherName: String = ""
    @State private var dob: Date = Date()
    @State private var mothersFirstName: String = ""
    @State private var mothersFatherName: String = ""
    @State private var selectedRegion: String = "Region1"
    @State private var selectedCity: String = "City1"
    @State private var selectedDistrict: String = "District1"
    @State private var phoneNumber: String = ""
    @State private var emailAddress: String = ""
    @State private var photo: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var sourceType: ImageSourceType = .camera
    @State private var showActionSheet: Bool = false
    @State private var selectedCountryCode: String = "+251" // Default country code
    
    // New state variables
    @State private var citizenship: String = "Citizenship1"
    @State private var placeOfBirth: String = ""
    @State private var sex: String = "Male"
    @State private var maritalStatus: String = "Single"
    @State private var spouseIDNumber: String = ""
    @State private var educationLevel: String = "High School"
    
    // Error and success state variables
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var showSuccessMessage: Bool = false

    let regions = ["Region1", "Region2", "Region3"]
    let cities = ["City1", "City2", "City3"]
    let districts = ["District1", "District2", "District3"]
    let countryCodes = ["+251", "+1", "+44", "+61", "+81", "+86"] // Example country codes
    let citizenships = ["Citizenship1", "Citizenship2", "Citizenship3"]
    let sexes = ["Male", "Female", "Other"]
    let maritalStatuses = ["Single", "Married", "Divorced", "Widowed"]
    let educationLevels = ["High School", "Bachelor's Degree", "Master's Degree", "PhD", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Father's Name", text: $fatherName)
                    TextField("Grandfather's Name", text: $grandFatherName)
                    DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                    Picker("Citizenship", selection: $citizenship) {
                        ForEach(citizenships, id: \.self) { citizenship in
                            Text(citizenship)
                        }
                    }
                    TextField("Place of Birth", text: $placeOfBirth)
                    Picker("Sex", selection: $sex) {
                        ForEach(sexes, id: \.self) { sex in
                            Text(sex)
                        }
                    }
                    Picker("Marital Status", selection: $maritalStatus) {
                        ForEach(maritalStatuses, id: \.self) { status in
                            Text(status)
                        }
                    }
                    if maritalStatus == "Married" {
                        TextField("Spouse ID Number", text: $spouseIDNumber)
                    }
                    Picker("Education Level", selection: $educationLevel) {
                        ForEach(educationLevels, id: \.self) { level in
                            Text(level)
                        }
                    }
                }

                Section(header: Text("Mother's Information")) {
                    TextField("Mother's First Name", text: $mothersFirstName)
                    TextField("Mother's Father Name", text: $mothersFatherName)
                }

                Section(header: Text("Address Information")) {
                    Picker("Region", selection: $selectedRegion) {
                        ForEach(regions, id: \.self) { region in
                            Text(region)
                        }
                    }

                    Picker("City", selection: $selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }

                    Picker("District", selection: $selectedDistrict) {
                        ForEach(districts, id: \.self) { district in
                            Text(district)
                        }
                    }
                }

                Section(header: Text("Contact Information")) {
                    HStack {
                        Picker("Code", selection: $selectedCountryCode) {
                            ForEach(countryCodes, id: \.self) { code in
                                Text(code)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100)

                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .padding(.leading, 10)
                    }

                    TextField("Email Address", text: $emailAddress)
                        .keyboardType(.emailAddress)
                }

                Section(header: Text("Photograph")) {
                    if let photo = photo {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Button(action: {
                            showActionSheet = true
                        }) {
                            Text("Add Photograph")
                        }
                    }
                }

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                if showSuccessMessage {
                    Text("User registered successfully")
                        .foregroundColor(.green)
                }

                Button(action: {
                    // Handle registration submission
                    validateAndRegisterUser()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Registration Form")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $photo, sourceType: $sourceType)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select Image Source"), buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    },
                    .cancel()
                ])
            }
        }
    }

    private func validateAndRegisterUser() {
        // Reset error and success state
        showError = false
        errorMessage = ""
        showSuccessMessage = false

        // Validate fields
        if firstName.isEmpty ||
            fatherName.isEmpty ||
            grandFatherName.isEmpty ||
            mothersFirstName.isEmpty ||
            mothersFatherName.isEmpty ||
            placeOfBirth.isEmpty ||
            phoneNumber.isEmpty ||
            emailAddress.isEmpty ||
            (maritalStatus == "Married" && spouseIDNumber.isEmpty) {
            
            errorMessage = "Please fill in all the required fields."
            showError = true
        } else if photo == nil {
            errorMessage = "Please add a photograph."
            showError = true
        } else {
            // All fields are valid, proceed with registration
            registerUser()
        }
    }

    private func registerUser() {
        let newUser = RegisteredUser(context: viewContext)
        newUser.firstName = firstName
        newUser.fatherName = fatherName
        newUser.grandFatherName = grandFatherName
        newUser.dob = dob
        newUser.mothersFirstName = mothersFirstName
        newUser.mothersFatherName = mothersFatherName
        newUser.selectedRegion = selectedRegion
        newUser.selectedCity = selectedCity
        newUser.selectedDistrict = selectedDistrict
        newUser.phoneNumber = phoneNumber
        newUser.emailAddress = emailAddress
        newUser.citizenship = citizenship
        newUser.placeOfBirth = placeOfBirth
        newUser.sex = sex
        newUser.maritalStatus = maritalStatus
        newUser.spouseIDNumber = spouseIDNumber
        newUser.educationLevel = educationLevel
        newUser.identityNumber = generateUniqueIdentifier()
        if let photo = photo {
            newUser.photo = photo.pngData()
        }

        do {
            try viewContext.save()
            showSuccessMessage = true
            clearForm()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }

    private func clearForm() {
        firstName = ""
        fatherName = ""
        grandFatherName = ""
        dob = Date()
        mothersFirstName = ""
        mothersFatherName = ""
        selectedRegion = "Region1"
        selectedCity = "City1"
        selectedDistrict = "District1"
        phoneNumber = ""
        emailAddress = ""
        photo = nil
        citizenship = "Citizenship1"
        placeOfBirth = ""
        sex = "Male"
        maritalStatus = "Single"
        spouseIDNumber = ""
        educationLevel = "High School"
    }

    private func generateUniqueIdentifier() -> String {
        return String(format: "%09d", arc4random_uniform(1000000000))
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
