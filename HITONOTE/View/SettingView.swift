//
//  SettingView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct SettingView: View {
    
    private let viewModel = SettingViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HeaderView(leadingIcon: "chevron.backward", trailingIcon: "", leadingAction: { dismiss() }, trailingAction: {})
        
        Section(header: Text(L10n.settingCapacitySectionTitle), footer: Text(L10n.settingCapacitySectionFooter)) {
            NavigationLink {
                DisplayItemControlView()
            } label: {
                Text("Display")
            }
        }
        
        Section(header: Text(L10n.settingCapacitySectionTitle), footer: Text(L10n.settingCapacitySectionFooter)) {
            //            RewardButtonView()
            HStack {
                Image(systemName: "bag")
                Text(L10n.settingCapacityText(20))
            }
        }
        
        // MARK: - (3)
        
        Section(header: Text("Link")) {
            // 1:レビューページ
            Link(destination: viewModel.reviewUrl, label: {
                HStack {
                    Image(systemName: "hand.thumbsup")
                    Text(L10n.settingReviewTitle)
                }.foregroundColor(.white)
            })
            
            // 2:シェアボタン
            Button(action: {
                viewModel.shareApp()
            }) {
                HStack {
                    Image(systemName: "star.bubble")
                    Text(L10n.settingRecommendTitle)
                }.foregroundColor(.white)
            }
            
            // 3:利用規約とプライバシーポリシー
            Link(destination: viewModel.termsUrl, label: {
                HStack {
                    Image(systemName: "note.text")
                    Text(L10n.settingTermsOfServiceTitle)
                    Image(systemName: "link").font(.caption)
                }.foregroundColor(.white)
            })
            
            Spacer()
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}


#Preview {
    SettingView()
}
