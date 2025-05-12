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
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching transactions: \(error?.localizedDescription ?? "")")
                    return
                }

                self.transactions = documents.compactMap { doc in
                    let data = doc.data()
                    
                    guard let category = data["category"] as? String,
                          let note = data["note"] as? String,
                          let baseAmount = data["amount"] as? Double,
                          let type = data["type"] as? String,
                          let date = data["date"] as? Timestamp else {
                        return nil
                    }

                    let isIncome = type.lowercased() == "income"
                    let amount = isIncome ? baseAmount : -baseAmount

                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    let time = formatter.string(from: date.dateValue())

                    let (icon, color) = self.iconAndColor(for: category, isIncome: isIncome)

                    return Transaction(
                        id: doc.documentID,
                        category: category,
                        note: note,
                        amount: amount,
                        time: time,
                        color: color,
                        icon: icon,
                        isIncome: isIncome
                    )
                }
            }
    }


    private func iconAndColor(for category: String, isIncome: Bool) -> (String, Color) {
        switch category.lowercased() {
        case "shopping": return ("basket.fill", Color.purple.opacity(0.7))
        case "food": return ("fork.knife", Color.orange.opacity(0.7))
        case "transportation": return ("car.fill", Color.blue.opacity(0.7))
        case "subscription": return ("doc.text.fill", Color.red.opacity(0.7))
        case "salary": return ("dollarsign.circle.fill", Color.green.opacity(0.7))
        case "investment": return ("chart.bar.fill", Color.blue.opacity(0.7))
        default: return ("questionmark.circle.fill", Color.gray.opacity(0.7))
        }
    }
}
