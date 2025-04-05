//
//  FrontPageView.swift
//  MoneyMate
//
//  Created by ppppphrt on 5/4/2568 BE.
//

import SwiftUI

struct FrontPageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // App Icon
            Image("page1") // Replace with your custom image
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
                .padding(.bottom, 20)

            
            Spacer()
            
            // Next Button
            NavigationLink(destination: FirstAdsPage()) {
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

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}

