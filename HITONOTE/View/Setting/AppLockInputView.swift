//
//  AppLockInputView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/12.
//

import SwiftUI

/// 設定ページからモーダルとして呼び出される
struct AppLockInputView: View {
    
    // MARK: - Receive
    @Binding var isLock: Bool
    
    // MARK: - View
    @State private var password: Array<String> = []
    @State private var entryFlag: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "", leadingAction: {
                dismiss()
            }, trailingAction: {}, isShowLogo: false)
            .padding(.top , 20)
            
            Text(L10n.settingAppLockTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            ZStack {
                
                PasswordBackGroundView()
                
                DisplayPasswordView(password: password)
                
            }
            
            Button {
                if password.count == 4 {
                    entryFlag = true
                    let pass = password.joined(separator: "")
                    KeyChainRepository.sheard.entry(value: pass)
                    dismiss()
                }
            } label: {
                Text(L10n.settingAppLockEntry)
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: 100)
                    .foregroundStyle(password.count != 4 ? Asset.Colors.opacityGray.swiftUIColor : Asset.Colors.themaGreen.swiftUIColor)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(width: 100)
                                .foregroundStyle(password.count != 4 ? Asset.Colors.opacityGray.swiftUIColor : Asset.Colors.themaGreen.swiftUIColor)
                    }.padding(.vertical , 20)
            }.disabled(password.count != 4)

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
