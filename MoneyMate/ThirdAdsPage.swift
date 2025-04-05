//
//  ThirdAdsPage.swift
//  MoneyMate
//
//  Created by ppppphrt on 5/4/2568 BE.
//

import SwiftUI

struct ThirdAdsPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            // App Icon
            Image("page4")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding(.bottom, 40)

            // Add text
            Text("Insight financial")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            Text("habits")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            Text("Setup your budget for each category")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, 10)
            Text("so you in control.")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)
   
            
            Spacer()
            
            // Pagination Dots
            HStack(spacing: 8) {
                
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
            }
            .padding(.bottom, 40)
            
            // Next Button
            NavigationLink(destination: ThirdAdsPage()) {
                               Text("Next")
                                   .foregroundColor(.white)
                                   .fontWeight(.semibold)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                                   .background(Color.purple.opacity(0.8))
                                   .cornerRadius(40)
                                   .padding(.horizontal, 20)
                           }
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ThirdAdsPage()
}
