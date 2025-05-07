import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedUserType: UserType = .admin
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showHelp: Bool = false
    @State private var showForgotPassword: Bool = false
    @Binding var loggedInUsername: String

    // Predefined list of users
    let users = [
        User(username: "user1", password: "password1", userType: .admin),
        User(username: "user2", password: "password2", userType: .issuer),
        User(username: "user3", password: "password3", userType: .verifier),
        User(username: "user4", password: "password4", userType: .admin),
        User(username: "user5", password: "password5", userType: .issuer),
        User(username: "user6", password: "password6", userType: .verifier),
        User(username: "user7", password: "password7", userType: .admin),
        User(username: "user8", password: "password8", userType: .issuer),
        User(username: "user9", password: "password9", userType: .verifier),
        User(username: "user10", password: "password10", userType: .admin)
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // App logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 20)

                Text("Login")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 50)
                    .padding(.horizontal)
                
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(height: 50)
                    } else {
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(height: 50)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                Picker("User Type", selection: $selectedUserType) {
                    ForEach(UserType.allCases) { userType in
                        Text(userType.rawValue.capitalized).tag(userType)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Button(action: {
                    // Handle login action
                    login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Forgot password button
                NavigationLink(destination: ForgotPasswordView(), isActive: $showForgotPassword) {
                    Button(action: {
                        showForgotPassword.toggle()
                    }) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .padding(.top, 10)
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Login")
            .navigationBarItems(trailing:
                Button(action: {
                    showHelp.toggle()
                }) {
                    Image(systemName: "questionmark.circle")
                        .imageScale(.large)
                        .padding()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                loadCredentials()
            }
            .sheet(isPresented: $showHelp) {
                HelpView()
            }
        }
    }
    
    // Function to handle login
    private func login() {
        if let user = users.first(where: { $0.username == username && $0.password == password && $0.userType == selectedUserType }) {
            loggedInUsername = user.username
            isLoggedIn = true
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            saveCredentials(username: user.username, password: user.password, userType: user.userType)
        } else {
            // Handle login failure
            alertMessage = "Invalid username, password, or user type"
            showAlert = true
        }
    }

    // Function to save credentials
    private func saveCredentials(username: String, password: String, userType: UserType) {
        UserDefaults.standard.set(username, forKey: "savedUsername")
        UserDefaults.standard.set(password, forKey: "savedPassword")
        UserDefaults.standard.set(userType.rawValue, forKey: "savedUserType")
    }

    // Function to load credentials
    private func loadCredentials() {
        if let savedUsername = UserDefaults.standard.string(forKey: "savedUsername"),
           let savedPassword = UserDefaults.standard.string(forKey: "savedPassword"),
           let savedUserTypeRawValue = UserDefaults.standard.string(forKey: "savedUserType"),
           let savedUserType = UserType(rawValue: savedUserTypeRawValue) {
            username = savedUsername
            password = savedPassword
            selectedUserType = savedUserType
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    @State static var loggedInUsername = ""
    
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn, loggedInUsername: $loggedInUsername)
    }
}
