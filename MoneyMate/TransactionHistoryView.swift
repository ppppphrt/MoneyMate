import SwiftUI


import SwiftUI

struct TransactionHistoryView: View {
    @StateObject private var viewModel = TransactionViewModel()

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
                    TransactionSection(
                        title: "Expense",
                        transactions: viewModel.transactions.filter { !$0.isIncome }
                    )

                    // Income Section
                    TransactionSection(
                        title: "Income",
                        transactions: viewModel.transactions.filter { $0.isIncome }
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
            }

            Spacer()
//            MainView()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
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
