import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var rememberMe = true
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHome = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Spacer().frame(height: 20)

                Text("Register")
                    .font(.system(size: 32, weight: .bold))

                Text("Enter your personal details.")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Group {
                    CustomTextField(text: $name, placeholder: "Name")
                    CustomTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)
                    PasswordField(password: $password, isVisible: $isPasswordVisible, placeholder: "Password")
                    PasswordField(password: $confirmPassword, isVisible: $isConfirmPasswordVisible, placeholder: "Confirm Password")
                }

                HStack {
                    Text("Remember Me for the next time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Toggle("", isOn: $rememberMe)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                        .labelsHidden()
                }

                Spacer()

                Button(action: {
                    guard password == confirmPassword else {
                        alertMessage = "Passwords do not match."
                        showAlert = true
                        return
                    }

                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            alertMessage = "Registration failed: \(error.localizedDescription)"
                            showAlert = true
                        } else if let user = authResult?.user {
                            let changeRequest = user.createProfileChangeRequest()
                            changeRequest.displayName = name
                            changeRequest.commitChanges { commitError in
                                if let commitError = commitError {
                                    alertMessage = "Name save failed: \(commitError.localizedDescription)"
                                    showAlert = true
                                } else {
                                    isLoggedIn = true
                                    navigateToHome = true
                                }
                            }
                        }
                    }
                }) {
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(28)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Register"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                NavigationLink(destination: MainView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
    }
}

struct PasswordField: View {
    @Binding var password: String
    @Binding var isVisible: Bool
    var placeholder: String

    var body: some View {
        HStack {
            if isVisible {
                TextField(placeholder, text: $password)
            } else {
                SecureField(placeholder, text: $password)
            }

            Button(action: {
                isVisible.toggle()
            }) {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
        
    }
}

#Preview {
    RegisterView()
}
