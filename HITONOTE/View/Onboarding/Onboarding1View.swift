//
//  Onboarding1View.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/14.
//

import SwiftUI

struct Onboarding1View: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                PasswordBackGroundView()
                
                Text(L10n.onboarding1Title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18))
                    .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
            }
            
            if Locale.current.identifier.hasPrefix(Locale(identifier: "ja_JP").identifier) {
                Asset.Images.onboarding1Jp.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            } else {
                Asset.Images.onboarding1En.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            }
            
            
            VStack {
                NavigationLink {
                    Onboarding2View()
                } label: {
                    Text(L10n.onboardingNext)
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 200)
                        .background(Asset.Colors.themaGreen.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                HStack {
                    Image(systemName: "circle.fill")
                    Image(systemName: "circle")
                    Image(systemName: "circle")
                }.font(.system(size: 10))
                    .foregroundStyle(.white)
                    .padding(10)
                
            }.padding(10)
                .frame(width: DeviceSizeManager.deviceWidth)
                .background(Asset.Colors.opacityGray.swiftUIColor)
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

#Preview {
    Onboarding1View()
}
