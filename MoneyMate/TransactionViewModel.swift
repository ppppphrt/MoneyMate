import FirebaseFirestore
import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private var db = Firestore.firestore()

    init() {
        fetchTransactions()
    }

    func fetchTransactions() {
        db.collection("transactions")
            .order(by: "date", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents: \(error?.localizedDescription ?? "")")
                    return
                }

                self.transactions = documents.compactMap { Transaction(from: $0) }
            }
    }
}
