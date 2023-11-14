//
//  SplashView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/14.
//

import SwiftUI

struct SplashView: View {
    @State private var isPresented: Bool = false
    @State private var opacity: Double = 0
    var body: some View {
        ZStack {
            PasswordBackGroundView()
            
            Asset.Images.hitonoteLogo.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .opacity(opacity)
        }.navigationDestination(isPresented: $isPresented) {
            Onboarding1View()
        }.onAppear {
            withAnimation(Animation.linear(duration: 2)) {
                opacity = 1
            }
            DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 4) {
                isPresented = true
            }
        }
    }
}

#Preview {
    SplashView()
}
