import SwiftUI

struct TransactionsList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.title3)
                    .bold()

                Spacer()

                Button(action: {}) {
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

            ForEach(sampleTransactions) { tx in
                TransactionRow(transaction: tx)
                    .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}
