//import SwiftUI
//
//struct MainTabController: View {
//    @State private var selectedTab: Tab = .home
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            Group {
//                switch selectedTab {
//                case .home:
//                    HomePage()
//                case .history:
//                    TransactionHistoryView()
//                case .add:
//                    ExpenseTrackerView()
//                case .report:
//                    FinancialReportView()
//                case .profile:
//                    ProfilePage()
//                }
//            }
//
//            CustomTabBar(selectedTab: $selectedTab)
//        }
//        .ignoresSafeArea(.keyboard) // to avoid keyboard pushing views
//    }
//}
//
//
