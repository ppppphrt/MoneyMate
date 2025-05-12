import SwiftUI

// MARK: - Tab Enum
enum Tab {
    case home, history, add, report, profile
}

// MARK: - MainView
struct MainView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                TabView(selection: $selectedTab) {
                    HomePage()
                        .tag(Tab.home)
                    
                    TransactionHistoryView()
                        .tag(Tab.history)
                    
                    TransactionEntryView()
                        .tag(Tab.add)
                    
                    FinancialReportView()
                        .tag(Tab.report)
                    
                    ProfilePage()
                        .tag(Tab.profile)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Custom Tab Bar
                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 70)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()

            // Home Tab
            TabBarButton(
                imageName: "house",
                title: "Home",
                isSelected: selectedTab == .home
            ) {
                selectedTab = .home
            }
            
            Spacer()
            
            // History Tab
            TabBarButton(
                imageName: "clock.arrow.circlepath",
                title: "History",
                isSelected: selectedTab == .history
            ) {
                selectedTab = .history
            }
            
            Spacer()
            
            // Add Button (Centered)
            Button(action: {
                selectedTab = .add
            }) {
                ZStack {
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 60, height: 60)
                        .offset(y: -15)
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .offset(y: -15)
                }
            }
            
            Spacer()
            
            // Report Tab
            TabBarButton(
                imageName: "chart.bar",
                title: "Report",
                isSelected: selectedTab == .report
            ) {
                selectedTab = .report
            }
            
            Spacer()
            
            // Profile Tab
            TabBarButton(
                imageName: "person",
                title: "Profile",
                isSelected: selectedTab == .profile
            ) {
                selectedTab = .profile
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemGray6))
    }
}

// MARK: - Helper View for Tab Bar Buttons
struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .foregroundColor(isSelected ? .purple : .gray)
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? .purple : .gray)
            }
        }
    }
}

// MARK: - Preview
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
