import SwiftUI

struct FinancialReportView: View {
    @State private var selectedTab = 0 // 0 = Expense, 1 = Income
    @State private var isExpanded = true

    @StateObject private var incomeViewModel = IncomeViewModel()
    @StateObject private var expenseViewModel = ExpenseViewModel()

    var body: some View {
        VStack(spacing: 30) {
            // Tab selector
            HStack(spacing: 0) {
                TabButton(title: "Expense", isSelected: selectedTab == 0,
                          selectedColor: Color(red: 1.0, green: 0.35, blue: 0.35)) { selectedTab = 0 }
                TabButton(title: "Income", isSelected: selectedTab == 1, selectedColor: Color(red: 0.4, green: 0.8, blue: 0.6)) {
                    selectedTab = 1
                }
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(25)
            .padding(.horizontal)

            // Donut Chart
            ZStack {
                if selectedTab == 0 {
                    DonutChart(data: expenseViewModel.expenses.map { $0.amount },
                               colors: expenseViewModel.expenses.map { $0.color },
                               centerText: "\(Int(expenseViewModel.expenses.map { $0.amount }.reduce(0, +))) ฿")
                } else {
                    DonutChart(data: incomeViewModel.incomes.map { $0.amount },
                               colors: incomeViewModel.incomes.map { $0.color },
                               centerText: "\(Int(incomeViewModel.incomes.map { $0.amount }.reduce(0, +))) ฿")
                }
            }
            .frame(width: 200, height: 200)
            .padding(.vertical, 30)

            // Categories Section
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Category").fontWeight(.medium)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }

                if isExpanded {
                    if selectedTab == 0 {
                        ForEach(expenseViewModel.expenses.indices, id: \ .self) { index in
                            ExpenseRow(category: expenseViewModel.expenses[index].category,
                                       amount: expenseViewModel.expenses[index].amount,
                                       color: expenseViewModel.expenses[index].color,
                                       maxAmount: expenseViewModel.expenses.map { $0.amount }.max() ?? 1)
                        }
                    } else {
                        ForEach(incomeViewModel.incomes.indices, id: \ .self) { index in
                            IncomeRow(category: incomeViewModel.incomes[index].category,
                                      amount: incomeViewModel.incomes[index].amount,
                                      color: incomeViewModel.incomes[index].color,
                                      maxAmount: incomeViewModel.incomes.map { $0.amount }.max() ?? 1)
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Reusable tab button
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let selectedColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.medium)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? selectedColor : Color.clear)
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(25)
        }
    }
}

// Donut Chart View
struct DonutChart: View {
    let data: [Double]
    let colors: [Color]
    let centerText: String

    private var total: Double {
        data.reduce(0, +)
    }

    private var angles: [Angle] {
        var angles: [Angle] = []
        var startAngle = Angle(degrees: 0)

        for value in data {
            let angle = Angle(degrees: 360 * (value / total))
            angles.append(startAngle)
            startAngle += angle
        }

        return angles
    }

    var body: some View {
        ZStack {
            ForEach(0..<data.count, id: \ .self) { index in
                let endAngle = angles[index] + Angle(degrees: 360 * (data[index] / total))

                Arc(startAngle: angles[index], endAngle: endAngle)
                    .fill(colors[index])
                    .frame(width: 200, height: 200)
            }

            Circle()
                .fill(Color.white)
                .frame(width: 120, height: 120)

            Text(centerText)
                .font(.system(size: 32, weight: .bold))
        }
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.6

        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.closeSubpath()

        return path
    }
}

struct IncomeRow: View {
    let category: String
    let amount: Double
    let color: Color
    let maxAmount: Double

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Circle().fill(color).frame(width: 12, height: 12)
                Text(category).fontWeight(.medium)
                Spacer()
                Text("+ \(Int(amount)) ฿")
                    .fontWeight(.medium)
                    .foregroundColor(.green)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(UIColor.systemGray6))
                        .frame(height: 8)
                        .cornerRadius(4)
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(amount / maxAmount), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal)
    }
}

struct ExpenseRow: View {
    let category: String
    let amount: Double
    let color: Color
    let maxAmount: Double

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Circle().fill(color).frame(width: 12, height: 12)
                Text(category).fontWeight(.medium)
                Spacer()
                Text("- \(Int(amount)) ฿")
                    .fontWeight(.medium)
                    .foregroundColor(.red)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(UIColor.systemGray6))
                        .frame(height: 8)
                        .cornerRadius(4)
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(amount / maxAmount), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal)
    }
}


#Preview {
    FinancialReportView()
}
