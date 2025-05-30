import SwiftUI
import FirebaseAuth

struct ProfilePage: View {
    @State private var showLogoutAlert = false
    @State private var userDisplayName: String = ""
    @State private var userEmail: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "person.crop.square.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 4)
                            )
                        
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black))
                            .offset(x: 5, y: 5)
                    }
                    
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(userDisplayName.isEmpty ? userEmail : userDisplayName)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 40)
                
                // Options
                VStack(spacing: 16) {
                    Button {
                        tabSelection.selectedTab = .home
                    } label: {
                        MenuItem(icon: "house.fill", label: "Home", iconColor: .purple)
                    }

                    MenuItem(icon: "gearshape.fill", label: "Settings", iconColor: .purple)

                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        MenuItem(icon: "arrow.right.square.fill", label: "Logout", iconColor: .red)
                    }
                }
                .padding()
                
                Spacer()
                
                // Logout Alert
                if showLogoutAlert {
                    VStack(spacing: 12) {
                        Text("Logout?")
                            .font(.headline)
                        
                        Text("Are you sure you want to log out?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 20) {
                            Button("No") {
                                showLogoutAlert = false
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            
                            Button("Yes") {
                                logout()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding()
                }
            }
            .onAppear {
                loadUser()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
        }
    }

    func loadUser() {
        let user = Auth.auth().currentUser
        userDisplayName = user?.displayName ?? ""
        userEmail = user?.email ?? ""
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }

}


struct MenuItem: View {
    var icon: String
    var label: String
    var iconColor: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(10)
                .background(iconColor.opacity(0.7))
                .cornerRadius(10)
            Text(label)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
