import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [(category: String, amount: Double, color: Color)] = []
    
    private var db = Firestore.firestore()

    init() {
        fetchExpenses()
    }

    func fetchExpenses() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }

       
        db.collection("users")
            .document(userID)
            .collection("transactions")
            .whereField("type", isEqualTo: "Expense")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No expense documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                var results: [String: Double] = [:]

                for doc in documents {
                    let data = doc.data()
                    if let category = data["category"] as? String,
                       let amount = data["amount"] as? Double {
                        results[category, default: 0] += amount
                    }
                }

                DispatchQueue.main.async {
                    self.expenses = results.map { (category, amount) in
                        let color = self.colorForCategory(category)
                        return (category: category, amount: amount, color: color)
                    }
                }
            }
    }

    func colorForCategory(_ category: String) -> Color {
        switch category.lowercased() {
        case "shopping":
            return Color.purple
        case "food":
            return Color.orange
        case "subscription", "subcription":
            return Color.red
        default:
            return Color.gray
        }
    }
}
