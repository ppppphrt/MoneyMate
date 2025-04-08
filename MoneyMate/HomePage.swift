import SwiftUI

let lightPurp = Color(red: 196/255, green: 170/255, blue: 247/255)
let lightGreen = Color(red: 48/255, green: 194/255, blue: 133/255)
let lightRed = Color(red: 243/255, green: 93/255, blue: 104/255)

struct HomePage: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .fill(lightPurp)
                    .frame(height: 250)

                VStack(alignment: .leading, spacing: 10) {
                    // Profile Info
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)

                        Text("Hello, Name !")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    .padding(.top, 50)


                    HStack(spacing: 30) {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(lightGreen)
                            .frame(width: 170, height: 80)
                            .overlay(
                                Text("Income")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            )

                        RoundedRectangle(cornerRadius: 24)
                            .fill(lightRed)
                            .frame(width: 170, height: 80)
                            .overlay(
                                Text("Expense")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            )
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomePage()
}
