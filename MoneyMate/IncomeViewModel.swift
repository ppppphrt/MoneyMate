import FirebaseFirestore
import SwiftUI

class IncomeViewModel: ObservableObject {
    @Published var incomes: [(category: String, amount: Double, color: Color)] = []
    
    private var db = Firestore.firestore()

    init() {
        fetchIncomes()
    }

    func fetchIncomes() {
        db.collection("transactions")
            .whereField("type", isEqualTo: "Income")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No income documents: \(error?.localizedDescription ?? "Unknown error")")
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
                    self.incomes = results.map { (category, amount) in
                        let color = self.colorForCategory(category)
                        return (category: category, amount: amount, color: color)
                    }
                }
            }
    }

    func colorForCategory(_ category: String) -> Color {
        switch category.lowercased() {
        case "salary":
            return Color.green
        case "bonus":
            return Color.blue
        case "freelance":
            return Color.orange
        default:
            return Color.gray
        }
    }
}
