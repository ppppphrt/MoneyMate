import SwiftUI

struct FinancialReportView: View {
    @State private var selectedTab = 0
    @State private var isExpanded = true
    @State private var showIncomeView = false
    @Environment(\.presentationMode) var presentationMode
    
    var totalAmount: Double {
        viewModel.expenses.map(\.amount).reduce(0, +)
    }
    
    @StateObject private var viewModel = ExpenseViewModel()
    
    //    let totalAmount: Double = 500
    //
    //    // Fixed explicit type annotation
    //    let expenses: [(category: String, amount: Double, color: Color)] = [
    //        ("Shopping", 200, Color(red: 0.78, green: 0.49, blue: 0.90)), // Purple
    //        ("Subcription", 185, Color(red: 1.0, green: 0.35, blue: 0.35)), // Red
    //        ("Food", 100, Color(red: 1.0, green: 0.65, blue: 0.24)) // Orange
    //    ]
    
    var body: some View {
        VStack(spacing: 30) {
            // Tab selector
            HStack(spacing: 0) {
                TabButton(title: "Expense", isSelected: selectedTab == 0) {
                    selectedTab = 0
                    showIncomeView = false
                }
                
                TabButton(title: "Income", isSelected: selectedTab == 1) {
                    selectedTab = 1
                    showIncomeView = true
                }
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(25)
            .padding(.horizontal)
            
            // Show appropriate view based on selection
            if showIncomeView {
                // Navigate back and then to Income view
                NavigationLink(destination: FinancialIncomeView(), isActive: $showIncomeView){
                    EmptyView()
                }
                ZStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        EmptyView()
                    }
                    .hidden()
                    .onAppear {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } else {
                // Donut chart - same size as income view
                ZStack {
                    DonutChart(data: viewModel.expenses
                        .map { $0.amount },
                               colors: viewModel.expenses
                        .map { $0.color },
                               centerText: "500 ฿")
                    .frame(width: 200, height: 200)
                }
                .padding(.vertical, 40)
                
                // Categories section
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Category")
                            .fontWeight(.medium)
                        
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
                        ForEach(viewModel.expenses.indices, id: \.self) { index in
                            ExpenseRow(
                                category: viewModel.expenses[index].category,
                                amount: viewModel.expenses[index].amount,
                                color: viewModel.expenses[index].color
                            )
                        }
                    }
                }
            }
            
            Spacer()
//            MainView()
            
            
        }
        
//        .navigationBarTitle("Financial Report", displayMode: .inline)
        
    }
    
    struct TabButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .fontWeight(.medium)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(isSelected ? Color(red: 1.0, green: 0.35, blue: 0.35) : Color.clear)
                    .foregroundColor(isSelected ? .white : .black)
                    .cornerRadius(25)
            }
        }
    }
    
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
                ForEach(0..<data.count, id: \.self) { index in
                    let endAngle = angles[index] + Angle(degrees: 360 * (data[index] / total))
                    
                    Arc(startAngle: angles[index], endAngle: endAngle)
                        .fill(colors[index])
                        .frame(width: 200, height: 200)  // Set consistent size
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
    
    struct ExpenseRow: View {
        let category: String
        let amount: Double
        let color: Color
        
        var body: some View {
            VStack(spacing: 8) {
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 12, height: 12)
                    
                    Text(category)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text("- \(Int(amount)) ฿")
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 1.0, green: 0.35, blue: 0.35)) // Red color
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(UIColor.systemGray6))
                            .frame(width: geometry.size.width, height: 8)
                            .cornerRadius(4)
                        
                        Rectangle()
                            .fill(color)
                            .frame(width: geometry.size.width * CGFloat(amount / 500), height: 8)  // Normalized to total
                            .cornerRadius(4)
                    }
                }
                .frame(height: 8)
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

#Preview {
    FinancialReportView()
}
