//
//  AppLockView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/11.
//

import SwiftUI

struct AppLockView: View {
    
    @State private var password: Array<String> = []
    @State private var isShowApp = false             // アプリメイン画面遷移
    @State private var isShowProgress = false        // プログレス表示
    @State private var isShowFailureAlert = false    // パスワード失敗アラート
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: { }, trailingAction: { })
            
            Spacer()
            
            ZStack {
                
                PasswordBackGroundView()
                
                DisplayPasswordView(password: password)
                    .onChange(of: password) { newValue in
                        if newValue.count == 4 {
                            isShowProgress = true
                            let pass = newValue.joined(separator: "")
                            if pass == KeyChainRepository.sheard.getData() {
                                DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 0.5) {
                                    isShowApp = true
                                }
                            } else {
                                DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 0.5) {
                                    isShowProgress = false
                                    isShowFailureAlert = true
                                    password.removeAll()
                                }
                            }
                        }
                    }
                
                if isShowProgress {
                    ProgressView()
                        .offset(y: 60)
                }
            }
            
            
            Spacer()
            
            NumberKeyboardView(password: $password)
                .ignoresSafeArea(.all)
        }.alert(L10n.appLockAlert, isPresented: $isShowFailureAlert) {
            Button("OK") {
            }
        }
        .navigationDestination(isPresented: $isShowApp) {
            PersonListView()
        }
    }
}

struct NumberKeyboardView: View {
    
    @Binding var password: Array<String>
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                
                NumberButton(number: "1", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "2", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "3", password: $password)
            }
            
            Rectangle()
                .frame(width: DeviceSizeManager.deviceWidth, height: 1)
            
            HStack(spacing: 0) {
                
                NumberButton(number: "4", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "5", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "6", password: $password)
                
            }
            
            Rectangle()
                .frame(width: DeviceSizeManager.deviceWidth, height: 1)
            
            HStack(spacing: 0) {
                
                NumberButton(number: "7", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "8", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "9", password: $password)
                
            }
            
            Rectangle()
                .frame(width: DeviceSizeManager.deviceWidth, height: 1)
            
            HStack(spacing: 0) {
                
                NumberButton(number: "-", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                NumberButton(number: "0", password: $password)
                
                Rectangle()
                    .frame(width: 1, height: 80)
                
                Button {
                    password = password.dropLast()
                } label: {
                    Image(systemName: "delete.backward")
                        .frame(width: DeviceSizeManager.deviceWidth / 3, height: 80)
                        .background(Asset.Colors.opacityBlack.swiftUIColor)
                }
            }
        }.foregroundStyle(.white)
            .fontWeight(.bold)
    }
}

/// サークル背景
struct PasswordBackGroundView: View {
    
    var body: some View {
        Path { path in
            path.addArc(center: CGPoint(x: 40, y: 60),
                        radius: 70,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: true)
        }.fill(Asset.Colors.themaRed.swiftUIColor)
            .opacity(0.7)
        
        Path { path in
            path.addArc(center: CGPoint(x: DeviceSizeManager.deviceWidth - 40, y: 250),
                        radius: 60,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: true)
        }.fill(Asset.Colors.themaGreen.swiftUIColor)
            .opacity(0.7)
    }
}

/// 4桁のブラインドパスワードビュー
struct DisplayPasswordView: View {
    
    let password: Array<String>
    
    var body: some View {
        HStack(spacing: 30) {
            Text(password[safe: 0] == nil ? "ー" : "⚫︎")
            Text(password[safe: 1] == nil ? "ー" : "⚫︎")
            Text(password[safe: 2] == nil ? "ー" : "⚫︎")
            Text(password[safe: 3] == nil ? "ー" : "⚫︎")
        }.foregroundStyle(Asset.Colors.textColor.swiftUIColor)
            .fontWeight(.bold)
    }
}


/// 数値入力カスタムキーボード
struct NumberButton: View {
    
    public let number: String
    @Binding var password: Array<String>
    
    var body: some View {
        Button {
            if password.count != 4 && number != "-" {
                password.append(number)
            }
        } label: {
            Text(number)
                .frame(width: DeviceSizeManager.deviceWidth / 3, height: 80)
                .background(Asset.Colors.opacityBlack.swiftUIColor)
        }
    }
}

#Preview {
    AppLockView()
}
