import SwiftUI

struct TabView: View {
    var body: some View {
        HStack(spacing: 40) {
            TabBarItem(icon: "house.fill", label: "Home")
            TabBarItem(icon: "checklist", label: "History")
            TabBarItem(icon: "plus.app.fill", label: "Add")
            TabBarItem(icon: "chart.bar.fill", label: "Report")
            TabBarItem(icon: "person.fill", label: "Profile")
        }
        .padding(.horizontal)
        .frame(height: 79)
        .background(Color.black.opacity(0.05))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}

struct TabBarItem: View {
    var icon: String
    var label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(label)
                .font(.caption2)
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    TabView()
}
