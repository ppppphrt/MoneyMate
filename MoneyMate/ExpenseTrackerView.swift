import SwiftUI

struct ExpenseTrackerView: View {
    @State private var isExpenseSelected = true
    @State private var totalExpense: Double = 0
    @State private var selectedCategory: String?
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    let categories = ["Food", "Transportation", "Entertainment", "Shopping", "Utilities", "Health", "Other"]
    
    var body: some View {
        ZStack {
            Color(hex: "#F85E5E")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Expense/Income Segmented Control
                HStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            HStack(spacing: 0) {
                                Button(action: {
                                    isExpenseSelected = true
                                }) {
                                    Text("Expense")
                                        .fontWeight(.medium)
                                        .foregroundColor(isExpenseSelected ? .white : Color(hex: "#F85E5E"))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(
                                            isExpenseSelected ?
                                            Capsule().fill(Color(hex: "#F85E5E")) :
                                            Capsule().fill(Color.clear)
                                        )
                                }
                                
                                Button(action: {
                                    isExpenseSelected = false
                                }) {
                                    Text("Income")
                                        .fontWeight(.medium)
                                        .foregroundColor(isExpenseSelected ? Color(hex: "#F85E5E") : .white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(
                                            !isExpenseSelected ?
                                            Capsule().fill(Color(hex: "#F85E5E")) :
                                            Capsule().fill(Color.clear)
                                        )
                                }
                            }
                            .padding(3)
                        )
                        .padding(.horizontal)
                }
                
                // Total Expense Display
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total Expense")
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(Int(totalExpense))")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Input Form
                VStack(spacing: 25) {
                    // Category Dropdown
                    Menu {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedCategory ?? "Category")
                                .foregroundColor(selectedCategory == nil ? .gray : .black)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                    }
                    
                    // Title Field
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Description Field
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Amount Field
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Date and Time Selection
                    HStack(spacing: 10) {
                        Button(action: {
                            showDatePicker.toggle()
                        }) {
                            HStack {
                                Image(systemName: "calendar")
                                Text("Select Date")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#4F5E5E"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                        }
                        
                        Button(action: {
                            showTimePicker.toggle()
                        }) {
                            HStack {
                                Image(systemName: "clock")
                                Text("Select Time")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#1F9C9C"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                        }
                    }
                    
                    // Add Button
                    Button(action: {
                        addTransaction()
                    }) {
                        Text("Add")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#F85E5E"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    
                    Spacer(minLength: 5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerView(selectedDate: $selectedDate, isPresented: $showDatePicker)
        }
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(selectedTime: $selectedTime, isPresented: $showTimePicker)
        }
    }
    
    func addTransaction() {
        // Logic to add a transaction
        if let amountValue = Double(amount), !title.isEmpty, selectedCategory != nil {
            if isExpenseSelected {
                totalExpense += amountValue
            } else {
                // Handle income logic
            }
            
            // Clear fields
            title = ""
            description = ""
            amount = ""
            selectedCategory = nil
            
            // Here you would typically save the transaction to your data store
        }
    }
}

// Custom rounded corner modifier
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Helper for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Date Picker View
struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    isPresented = false
                }
                .padding()
            }
            
            DatePicker(
                "Select a date",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            
            Spacer()
        }
    }
}

// Time Picker View
struct TimePickerView: View {
    @Binding var selectedTime: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    isPresented = false
                }
                .padding()
            }
            
            DatePicker(
                "Select a time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .padding()
            
            Spacer()
        }
    }
}

// Preview
struct ExpenseTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTrackerView()
    }
}
