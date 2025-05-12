import SwiftUI

enum Tab {
    case home, history, add, report, profile
}

struct MainView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            switch selectedTab {
            case .home:
                HomePage()
            case .history:
                TransactionHistoryView()
            case .add:
                ExpenseTrackerView()
            case .report:
                FinancialReportView()
            case .profile:
                ProfilePage()
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray6))
                .frame(height: 70)
                .edgesIgnoringSafeArea(.bottom)

            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    selectedTab = .home
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "house")
                            .foregroundColor(selectedTab == .home ? .purple : .gray)
                        Text("Home")
                            .font(.system(size: 12))
                            .foregroundColor(selectedTab == .home ? .purple : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = .history
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(selectedTab == .history ? .purple : .gray)
                        Text("History")
                            .font(.system(size: 12))
                            .foregroundColor(selectedTab == .history ? .purple : .gray)
                    }
                }
                Spacer()
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
                Button(action: {
                    selectedTab = .report
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "chart.bar")
                            .foregroundColor(selectedTab == .report ? .purple : .gray)
                        Text("Report")
                            .font(.system(size: 12))
                            .foregroundColor(selectedTab == .report ? .purple : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = .profile
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "person")
                            .foregroundColor(selectedTab == .profile ? .purple : .gray)
                        Text("Profile")
                            .font(.system(size: 12))
                            .foregroundColor(selectedTab == .profile ? .purple : .gray)
                    }
                }
                Spacer()
            }
        }
    }
}
