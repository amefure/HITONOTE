//
//  SettingView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct SettingView: View {
    
    private let viewModel = SettingViewModel()
    
    @State var isShow: Bool = false
    
    @State var isLock: Bool = false
    
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        HeaderView(leadingIcon: "chevron.backward", trailingIcon: "", leadingAction: { dismiss() }, trailingAction: {})
        
        List {
            Section(header: Text(L10n.settingAppSetting), footer: Text(L10n.settingDisplayItemDesc)) {
                
                Button {
                    isShow = true
                } label: {
                    HStack {
                        Image(systemName: "switch.2")
                        Text(L10n.settingDisplayItemTitle)
                    }.fontWeight(.bold)
                }.sheet(isPresented: $isShow) {
                    DisplayItemControlView()
                }
                
                HStack {
                    Image(systemName: "lock.iphone")
                    Toggle(isOn: $isLock) {
                        Text(L10n.settingAppLockTitle)
                    }.onChange(of: isLock) { newValue in
                        
                    }
                }
            }
            
            
            Section(header: Text("Link")) {
                // 1:レビューページ
                Link(destination: viewModel.reviewUrl, label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text(L10n.settingReviewTitle)
                    }
                })
                
                // 2:シェアボタン
                Button(action: {
                    viewModel.shareApp()
                }) {
                    HStack {
                        Image(systemName: "star.bubble")
                        Text(L10n.settingRecommendTitle)
                    }
                }
                
                // 3:利用規約とプライバシーポリシー
                Link(destination: viewModel.termsUrl, label: {
                    HStack {
                        Image(systemName: "note.text")
                        Text(L10n.settingTermsOfServiceTitle)
                        Image(systemName: "link").font(.caption)
                    }
                })
                
            }.scrollContentBackground(.hidden)
                .background(.clear)
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
    }
}


#Preview {
    SettingView()
}
