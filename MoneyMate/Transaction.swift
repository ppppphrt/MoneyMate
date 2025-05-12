import SwiftUI
import FirebaseFirestore

struct Transaction: Identifiable {
    let id: String
    let category: String
    let note: String
    let amount: Double
    let time: String
    let color: Color
    let icon: String
    let isIncome: Bool

    var isExpense: Bool {
        !isIncome
    }

    init(id: String, category: String, note: String, amount: Double, time: String, color: Color, icon: String, isIncome: Bool = false) {
        self.id = id
        self.category = category
        self.note = note
        self.amount = amount
        self.time = time
        self.color = color
        self.icon = icon
        self.isIncome = isIncome
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        guard
            let category = data["category"] as? String,
            let note = data["note"] as? String,
            let amount = data["amount"] as? Double,
            let time = data["time"] as? String,
            let colorHex = data["color"] as? String,
            let icon = data["icon"] as? String,
            let isIncome = data["isIncome"] as? Bool
        else {
            return nil
        }

        self.id = document.documentID
        self.category = category
        self.note = note
        self.amount = amount
        self.time = time
        self.color = Color(hex: colorHex)
        self.icon = icon
        self.isIncome = isIncome
    }
}
