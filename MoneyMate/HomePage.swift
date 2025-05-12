import SwiftUI

let lightPurp = Color(red: 196/255, green: 170/255, blue: 247/255)
let lightGreen = Color(red: 48/255, green: 194/255, blue: 133/255)
let lightRed = Color(red: 243/255, green: 93/255, blue: 104/255)

struct HomePage: View {

    // Mock transactions
    let transactions: [Transaction] = [
        Transaction(id: "1", category: "Shopping", note: "Shirt", amount: -200, time: "08:00 AM", color: Color.purple.opacity(0.7), icon: "basket.fill"),
        Transaction(id: "2", category: "Food", note: "Cookies", amount: -100, time: "05:00 PM", color: Color.orange.opacity(0.7), icon: "fork.knife"),
        Transaction(id: "3", category: "Transportation", note: "BTS", amount: -15, time: "07:20 PM", color: Color.blue.opacity(0.7), icon: "car.fill"),
        Transaction(id: "4", category: "Subscription", note: "Youtube", amount: -185, time: "09:30 PM", color: Color.red.opacity(0.7), icon: "doc.text.fill")
    ]

    var body: some View {
        VStack(spacing: 0) {

            // Top Section
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 50)
                    .fill(lightPurp)
                    .frame(height: 250)
                    

                VStack(alignment: .leading, spacing: 20) {
                    // Profile Info
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)

                        Text("Welcome  Boo Boo")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading, 5)

                        Spacer()
                    }
                    .padding(.top, 50)

                    // Income & Expense Cards
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(lightGreen)
                            .frame(width: 170, height: 80)
                            .overlay(
                                VStack {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .foregroundColor(.white)
                                    Text("Income")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                        .bold()
                                    Text("900 ฿")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )

                        RoundedRectangle(cornerRadius: 24)
                            .fill(lightRed)
                            .frame(width: 170, height: 80)
                            .overlay(
                                VStack {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .foregroundColor(.white)
                                    Text("Expenses")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                        .bold()
                                    Text("500 ฿")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                    }
                }
                .padding(.horizontal)
            }

            // Recent Transactions Header
            HStack {
                Text("Recent Transaction")
                    .font(.headline)
                Spacer()
                Text("See All")
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.purple.opacity(0.15))
                    .cornerRadius(16)
            }
            .padding()

            // Transactions List
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(transactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
                .padding(.horizontal)
            }

            Spacer()

            // Tab Bar
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemGray6))
                    .frame(height: 70)
                    .edgesIgnoringSafeArea(.bottom)

                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "house")
                        Text("Home").font(.system(size: 12))
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("History").font(.system(size: 12))
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(lightPurp)
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
                        Text("Report").font(.system(size: 12))
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "person")
                        Text("Profile").font(.system(size: 12))
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
