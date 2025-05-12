import SwiftUI

struct FinancialIncomeView: View {
    @State private var selectedTab = 1  // Change to 1 for Income tab
    @State private var isExpanded = true
    @State private var showExpenseView = false
    
    var totalAmount: Double {
        viewModel.incomes.map(\.amount).reduce(0, +)
    }
    
    @StateObject private var viewModel = IncomeViewModel()

    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                // Tab selector
                HStack(spacing: 0) {
                    TabButtonIncome(title: "Expense", isSelected: selectedTab == 0) {
                        selectedTab = 0
                        //                        showExpenseView = true
                    }
                    
                    TabButtonIncome(title: "Income", isSelected: selectedTab == 1) {
                        selectedTab = 1
                        //                        showExpenseView = false
                    }
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(25)
                .padding(.horizontal)
                
                // Show appropriate view based on selection
                Group {
                    if selectedTab == 0 {
                        FinancialReportView()
                        NavigationLink(destination: FinancialReportView(), isActive: $showExpenseView) {
                            EmptyView()
                        }
                        .hidden()
                    } else {
                        // Donut chart
                        ZStack {
                            Circle()
                                .stroke(Color(red: 0.4, green: 0.8, blue: 0.6), lineWidth: 15)  // Green circle
                                .frame(width: 200, height: 200)
                            
                            Text("\(Int(totalAmount)) ฿")
                                .font(.system(size: 32, weight: .bold))
                        }
                        .padding(.vertical, 30)
                    }
                    
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
                            ForEach(viewModel.incomes.indices, id: \.self) { index in
                                IncomeRow(
                                    category: viewModel.incomes[index].category,
                                    amount: viewModel.incomes[index].amount,
                                    color: viewModel.incomes[index].color
                                )
                            }

                        }
                    }
                    Spacer()
//                    MainView()
                }
//                .navigationBarTitle("Financial Report", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    struct TabButtonIncome: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .fontWeight(.medium)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(isSelected ?
                                Color(red: 0.4, green: 0.8, blue: 0.6) : Color.clear)  // Green for selected
                    .foregroundColor(isSelected ? .white : .black)
                    .cornerRadius(25)
            }
        }
    }
    
    struct IncomeRow: View {
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
                    
                    Text("+ \(Int(amount)) ฿")  // Changed to plus sign
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 0.6))  // Green color
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(UIColor.systemGray6))
                            .frame(width: geometry.size.width, height: 8)
                            .cornerRadius(4)
                        
                        Rectangle()
                            .fill(color)
                            .frame(width: geometry.size.width * 0.7, height: 8)  // Fixed width proportion
                            .cornerRadius(4)
                    }
                }
                .frame(height: 8)
            }
            .padding(.horizontal)
        }
    }
    
    struct Arcc: Shape {  // Fixed the name to avoid conflict
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
}

#Preview {
    FinancialIncomeView()
}
