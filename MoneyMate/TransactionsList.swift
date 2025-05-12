import SwiftUI

struct TransactionsList: View {
    @StateObject private var viewModel = TransactionViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.title3)
                    .bold()

                Spacer()

                Button(action: {
                    // Optional: Add action to see all
                }) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.purple.opacity(0.15))
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal)

            if viewModel.transactions.isEmpty {
                Text("No transactions yet.")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ForEach(viewModel.transactions) { tx in
                    TransactionRow(transaction: tx)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TransactionsList()
}
