import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray6))
                .frame(height: 70)
                .edgesIgnoringSafeArea(.bottom)

            HStack(spacing: 0) {
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: "house")
                        .foregroundColor(.gray)
                    Text("Home").font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundColor(.gray)
                    Text("History").font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(lightPurp)
                        .frame(width: 60, height: 60)
                        .offset(y: -15)
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .offset(y: -15)
                }
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: "chart.bar")
                        .foregroundColor(.gray)
                    Text("Report").font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    Text("Profile").font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}
