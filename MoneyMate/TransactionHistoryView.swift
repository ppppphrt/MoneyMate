import SwiftUI


struct TransactionHistoryView: View {
    let transactions: [Transaction] = [
        Transaction(id: "1", category: "Shopping", note: "Shirt", amount: -200, time: "08:00 AM", color: Color(red: 196/255, green: 170/255, blue: 247/255).opacity(0.7), icon: "basket.fill", isIncome: false),
        Transaction(id: "2", category: "Food", note: "Cookies", amount: -100, time: "05:00 PM", color: Color.yellow.opacity(0.7), icon: "fork.knife", isIncome: false),
        Transaction(id: "3", category: "Transportation", note: "BTS", amount: -15, time: "07:20 PM", color: Color.blue.opacity(0.7), icon: "car.fill", isIncome: false),
        Transaction(id: "4", category: "Subscription", note: "Youtube", amount: -185, time: "09:30 PM", color: Color.red.opacity(0.7), icon: "doc.text.fill", isIncome: false),
        Transaction(id: "5", category: "Salary", note: "Salary for July", amount: 900, time: "04:30 PM", color: Color(red: 48/255, green: 194/255, blue: 133/255).opacity(0.7), icon: "dollarsign.circle.fill", isIncome: true)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Title
            HStack {
                Text("History")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(lightPurp)
                Spacer()
            }
            .padding()

            ScrollView {
                VStack(spacing: 25) {
                    // Expense Section
                    TransactionSection(title: "Expense", transactions: transactions.filter { !$0.isIncome })

                    // Income Section
                    TransactionSection(title: "Income", transactions: transactions.filter { $0.isIncome })
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
            }

            Spacer()

            // Tab Bar
            ZStack {
                Rectangle()
                    .fill(Color(UIColor.systemGray6))
                    .frame(height: 70)

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
                            .foregroundColor(lightPurp)
                        Text("History")
                            .font(.system(size: 12))
                            .foregroundColor(lightPurp)
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
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransactionSection: View {
    let title: String
    let transactions: [Transaction]
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "chevron.down")
                    .foregroundColor(lightPurp)
                    .rotationEffect(Angle(degrees: isExpanded ? 0 : -90))
                    .animation(.bouncy, value: isExpanded)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .onTapGesture {
                isExpanded.toggle()
            }

            if isExpanded {
                ForEach(transactions) { transaction in
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(transaction.color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: transaction.icon)
                                    .foregroundColor(.white)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text(transaction.category)
                                .font(.subheadline)
                                .bold()
                            Text(transaction.note)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text("\(transaction.amount > 0 ? "+" : "-") \(abs(Int(transaction.amount))) ฿")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(transaction.amount > 0 ? lightGreen : lightRed)
                            Text(transaction.time)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
            }
        }
    }
}

#Preview {
    TransactionHistoryView()
}
