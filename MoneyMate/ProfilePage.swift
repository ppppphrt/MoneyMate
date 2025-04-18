import SwiftUI

struct ProfilePage: View {
    @State private var showLogoutAlert = false

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
                    
                    Text("Name")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 40)
                
                // Options
                VStack(spacing: 16) {
                    NavigationLink(destination: HomePage()) {
                        MenuItem(icon: "house.fill", label: "Home", iconColor: .purple)
                    }

                    MenuItem(icon: "gearshape.fill", label: "Settings", iconColor: .purple) // You can wrap this in NavigationLink too if needed

                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        MenuItem(icon: "arrow.right.square.fill", label: "Logout", iconColor: .red)
                    }
                }

                .padding()
                
                Spacer()
                
                // Logout
                if showLogoutAlert {
                    VStack(spacing: 12) {
                        Text("Logout?")
                            .font(.headline)
                        
                        Text("Are you sure do you wanna logout?")
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
                                // Perform logout logic here
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
            .background(Color.white.edgesIgnoringSafeArea(.all))
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
