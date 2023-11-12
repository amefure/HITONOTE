//
//  AppLockInputView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/12.
//

import SwiftUI

/// 設定ページからモーダルとして呼び出される
struct AppLockInputView: View {
    
    @Binding var isLock: Bool
    @State var password: Array<String> = []
    @State var entryFlag: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "", leadingAction: {
                dismiss()
            }, trailingAction: {}, isShowLogo: false)
                .padding(.top , 20)
            
            Text("パスワード登録")
                .fontWeight(.bold)
            
            Spacer()
            
            ZStack {
                
                PasswordBackGroundView()
                
                DisplayPasswordView(password: password)
                
            }
            
            Button("登録") {
                if password.count == 4 {
                    entryFlag = true
                    let pass = password.joined(separator: "")
                    KeyChainRepository.sheard.entry(value: pass)
                    dismiss()
                }
            }
            
            
            Spacer()
            
            NumberKeyboardView(password: $password)
                .ignoresSafeArea(.all)
        }.onDisappear {
            if entryFlag {
                isLock = true
            } else {
                isLock = false
            }
        }
    }
}

#Preview {
    AppLockInputView(isLock: Binding.constant(true))
}
