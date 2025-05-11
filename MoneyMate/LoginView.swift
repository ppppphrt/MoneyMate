//
//  LoginView.swift
//  MoneyMate
//
//  Created by ppppphrt on 11/5/2568 BE.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var rememberMe = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer().frame(height: 20)

            Text("Login")
                .font(.system(size: 32, weight: .bold))

            Text("Welcome back! Please login to your account.")
                .foregroundColor(.gray)
                .font(.subheadline)

            CustomTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)

            PasswordField(password: $password, isVisible: $isPasswordVisible, placeholder: "Password")

            HStack {
                Text("Remember Me")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Toggle("", isOn: $rememberMe)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    .labelsHidden()
            }

            Spacer()

            Button(action: {
                // Handle login action
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(28)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
}

#Preview {
    LoginView()
}
