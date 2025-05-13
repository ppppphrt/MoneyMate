import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct TransactionEntryView: View {
    @State private var selectedTab: Int = 0 // 0 = Expense, 1 = Income
    @State private var selectedCategory: String?
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    private let expenseCategories = ["Shopping", "Food", "Transportation", "Subscription", "Other"]
    private let incomeCategories = ["Salary", "Investment", "Gift", "Business", "Other"]
    
    var backgroundColor: Color {
        selectedTab == 0 ? Color(hex: "#F85E5E") : Color(hex: "#5AB88F")
    }
    
    var tabTitle: String {
        selectedTab == 0 ? "Expense" : "Income"
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Toggle Tabs
                HStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            HStack(spacing: 0) {
                                TabButtonEntry(title: "Expense", selectedTab: $selectedTab, currentIndex: 0, activeColor: Color(hex: "#F85E5E"))
                                TabButtonEntry(title: "Income", selectedTab: $selectedTab, currentIndex: 1, activeColor: Color(hex: "#5AB88F"))
                            }
                                .padding(3)
                        )
                        .padding(.horizontal)
                }
                
                // Display total input
                VStack(alignment: .leading, spacing: 10) {
                    Text("New \(tabTitle)")
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(amount.isEmpty ? "0" : amount) ฿")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Input Form
                VStack(spacing: 25) {
                    // Category Picker
                    Menu {
                        ForEach(selectedTab == 0 ? expenseCategories : incomeCategories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
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
                    
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Date & Time Pickers
                    HStack(spacing: 10) {
                        Button(action: { showDatePicker.toggle() }) {
                            Label("Date", systemImage: "calendar")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "#4F5E5E"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                        
                        Button(action: { showTimePicker.toggle() }) {
                            Label("Time", systemImage: "clock")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "#1F9C9C"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                    }
                    
                    // Add Button
                    Button(action: saveTransaction) {
                        Text("Add \(tabTitle)")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(backgroundColor)
                            .cornerRadius(25)
                    }
                    
                    Spacer(minLength: 5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerView(selectedDate: $selectedDate, isPresented: $showDatePicker)
        }
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(selectedTime: $selectedTime, isPresented: $showTimePicker)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Save Transaction Logic
    func saveTransaction() {
        guard let amountValue = Double(amount),
              let category = selectedCategory,
              !title.isEmpty else {
            return
        }
        
        let combinedDate = Calendar.current.date(
            bySettingHour: Calendar.current.component(.hour, from: selectedTime),
            minute: Calendar.current.component(.minute, from: selectedTime),
            second: 0,
            of: selectedDate
        ) ?? Date()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let data: [String: Any] = [
            "category": category,
            "note": title,
            "description": description,
            "amount": amountValue,
            "date": Timestamp(date: combinedDate),
            "type": selectedTab == 0 ? "Expense" : "Income"
        ]
        
        // Save to user's sub-collection of transactions
        Firestore.firestore()
            .collection("users")
            .document(userID)
            .collection("transactions")
            .addDocument(data: data) { error in
                if let error = error {
                    print("Error saving: \(error.localizedDescription)")
                } else {
                    // Reset inputs after successful save
                    title = ""
                    description = ""
                    amount = ""
                    selectedCategory = nil
                }
            }
    }
    
    
    // MARK: - Tab Button Entry
    struct TabButtonEntry: View {
        let title: String
        @Binding var selectedTab: Int
        let currentIndex: Int
        let activeColor: Color
        
        var body: some View {
            Button(action: {
                selectedTab = currentIndex
            }) {
                Text(title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(selectedTab == currentIndex ? Capsule().fill(activeColor) : Capsule().fill(Color.clear))
                    .foregroundColor(selectedTab == currentIndex ? .white : activeColor)
            }
        }
    }
    
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
    
}

#Preview {
    TransactionEntryView()
}
