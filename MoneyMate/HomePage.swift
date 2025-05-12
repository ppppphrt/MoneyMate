import Firebase
import SwiftUI
import FirebaseFirestore

struct Transaction: Identifiable {
    let id: String
    let category: String
    let note: String
    let amount: Double
    let time: String
    let color: Color
    let icon: String

    init?(from document: DocumentSnapshot) {
        let data = document.data()
        guard let category = data?["category"] as? String,
              let note = data?["note"] as? String,
              let amount = data?["amount"] as? Double,
              let date = data?["date"] as? Timestamp else {
            return nil
        }

        self.id = document.documentID
        self.category = category
        self.note = note
        self.amount = amount

        // Format date to a readable time string
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        self.time = formatter.string(from: date.dateValue())

        // Assign icon & color based on category
        switch category.lowercased() {
        case "shopping":
            self.icon = "basket.fill"
            self.color = Color.purple.opacity(0.7)
        case "food":
            self.icon = "fork.knife"
            self.color = Color.orange.opacity(0.7)
        case "transportation":
            self.icon = "car.fill"
            self.color = Color.blue.opacity(0.7)
        case "subscription":
            self.icon = "doc.text.fill"
            self.color = Color.red.opacity(0.7)
        default:
            self.icon = "questionmark.circle"
            self.color = Color.gray
        }
    }
}

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
                                    .bold()
                            )

                        RoundedRectangle(cornerRadius: 24)
                            .fill(lightRed)
                            .frame(width: 170, height: 80)
                            .overlay(
                                Text("Expense")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .bold()
                            )
                    }
                }
                .padding(.horizontal)
            }
            TransactionsList()
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemGray6))
                    .frame(height: 70)
                    .edgesIgnoringSafeArea(.bottom)
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Image(systemName: "house")
                            .foregroundColor(.gray)
                        Text("Home")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.gray)
                        Text("History")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.6, green: 0.4, blue: 0.8))  // Purple button
                            .frame(width: 60, height: 60)
                            .offset(y: -15)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .offset(y: -15)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Image(systemName: "chart.bar")
                            .foregroundColor(.gray)
                        Text("Report")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        Text("Profile")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomePage()
}
