import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                Text("Welcome")
                    .font(.system(size: 36, weight: .bold))

                Text("Please choose an option to continue")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                VStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(28)
                    }

                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.purple)
                            .cornerRadius(28)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}
