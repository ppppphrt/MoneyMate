import SwiftUI
import FirebaseFirestore

struct IncomeTrackerView: View {
    @State private var isExpenseSelected = false // Income selected by default
    @State private var totalIncome: Double = 0
    @State private var selectedCategory: String?
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    // For navigation between views
    @State private var showExpenseTrackerView = false
    
    let categories = ["Salary", "Investment", "Gift", "Business", "Other"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Green background for Income view
                Color(hex: "#5AB88F")
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
                                        showExpenseTrackerView = true
                                    }) {
                                        Text("Expense")
                                            .fontWeight(.medium)
                                            .foregroundColor(isExpenseSelected ? .white : Color(hex: "#5AB88F"))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 44)
                                            .background(
                                                isExpenseSelected ?
                                                Capsule().fill(Color(hex: "#5AB88F")) :
                                                Capsule().fill(Color.clear)
                                            )
                                    }
                                    
                                    Button(action: {
                                        isExpenseSelected = false
                                    }) {
                                        Text("Income")
                                            .fontWeight(.medium)
                                            .foregroundColor(isExpenseSelected ? Color(hex: "#5AB88F") : .white)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 44)
                                            .background(
                                                !isExpenseSelected ?
                                                Capsule().fill(Color(hex: "#5AB88F")) :
                                                Capsule().fill(Color.clear)
                                            )
                                    }
                                }
                                .padding(3)
                            )
                            .padding(.horizontal)
                    }
                    
                    // Total Income Display
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Total Income")
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("\(Int(totalIncome))")
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
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        // Title Field
                        TextField("Title", text: $title)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        // Description Field
                        TextField("Description", text: $description)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        // Amount Field
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
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
                                .background(Color(hex: "#607277"))
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
                                .background(Color(hex: "#42A1A1"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                            }
                        }
                        
                        // Add Button - green to match design
                        Button(action: {
                            addTransaction()
                        }) {
                            Text("Add")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#5AB88F"))
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
                
                // Navigation link for switching to ExpenseTrackerView
                NavigationLink(destination: ExpenseTrackerView(), isActive: $showExpenseTrackerView) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerView(selectedDate: $selectedDate, isPresented: $showDatePicker)
        }
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(selectedTime: $selectedTime, isPresented: $showTimePicker)
        }
    }
    
    func addTransaction() {
        guard let amountValue = Double(amount),
              !title.isEmpty,
              let category = selectedCategory else {
            print("Validation failed")
            return
        }

        let db = Firestore.firestore()

        // Combine selected date + selected time into one `Date`
        let dateCombined = Calendar.current.date(
            bySettingHour: Calendar.current.component(.hour, from: selectedTime),
            minute: Calendar.current.component(.minute, from: selectedTime),
            second: 0,
            of: selectedDate
        ) ?? Date()

        let data: [String: Any] = [
            "category": category,
            "note": description,
            "amount": amountValue,
            "date": Timestamp(date: dateCombined),
            "type": "Income"
        ]

        db.collection("transactions").addDocument(data: data) { error in
            if let error = error {
                print("Error adding income: \(error.localizedDescription)")
            } else {
                print("Income added!")

                totalIncome += amountValue

                // Reset form
                title = ""
                description = ""
                amount = ""
                selectedCategory = nil
            }
        }
    }

}


// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IncomeTrackerView()
                .previewDisplayName("Income Tracker")
            
            ExpenseTrackerView()
                .previewDisplayName("Expense Tracker")
        }
    }
}
