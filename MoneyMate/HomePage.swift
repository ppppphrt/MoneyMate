import SwiftUI
import Firebase
import FirebaseAuth


struct HomePage: View {

    @StateObject private var viewModel = TransactionViewModel()
    
    var totalIncome: Double {
        viewModel.transactions.filter { $0.amount > 0 }.map(\.amount).reduce(0, +)
    }

    var totalExpense: Double {
        viewModel.transactions.filter { $0.amount < 0 }.map(\.amount).reduce(0, +)
    }

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

                        Text("Welcome \(Auth.auth().currentUser?.displayName ?? "User")")
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
                                    Text("\(Int(totalIncome)) ฿")
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
                                    Text("\(abs(Int(totalExpense))) ฿")
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
                    ForEach(viewModel.transactions.prefix(5)) { transaction in
                        TransactionRow(transaction: transaction)
                    }

                }
                .padding(.horizontal)
            }
            Spacer()
            MainView()
        }
//        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomePage()
}
