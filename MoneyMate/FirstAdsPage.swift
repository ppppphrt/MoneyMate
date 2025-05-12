//
//  FirstAdsPage.swift
//  MoneyMate
//
//  Created by ppppphrt on 5/4/2568 BE.
//

import SwiftUI

struct FirstAdsPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            // App Icon
            Image("page2")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 60)

            // Add text
            Text("Racord Your")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            Text("Transaction")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            Text("Mange your financial easily.")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Spacer()
            
            // Pagination Dots
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 10, height: 10)
            }
            .padding(.bottom, 40)
            
            // Next Button
            NavigationLink(destination: SecondAdsPage()) {
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
        .navigationBarBackButtonHidden(true)
    }
}

struct FirstAdsPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstAdsPage()
    }
}

