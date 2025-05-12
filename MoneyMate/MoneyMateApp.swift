import SwiftUI
import FirebaseCore

@main
struct MoneyMateApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
