//
//  DisplayItemControlView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DisplayItemControlView: View {

    private let viewModel = DisplayItemControlViewModel()
    
    @State private var isRuby: Bool = true          // ふりがな
    @State private var isGender: Bool = true        // 性別
    @State private var isCharacter: Bool = true     // キャラクター
    @State private var isWork: Bool = true          // 職業
    @State private var isBirthday: Bool = true      // 誕生日
    @State private var isTell: Bool = true          // 電話
    @State private var isMail: Bool = true          // メール
    @State private var isMemo: Bool = true          // メモ
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "", leadingAction: { dismiss() }, trailingAction: {}, isShowLogo: false)
                .padding(.top , 20)
            
            Text(L10n.settingDisplayItemTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            List {
                
                Section(header: Text(L10n.settingDisplayItemLabel), footer: Text(L10n.settingDisplayItemDesc)) {
                    
                    Toggle(isOn: $isRuby) {
                        Text(L10n.personRuby)
                    }.onChange(of: isRuby) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.RUBY_KEY, isOn: newValue)
                    }
                    
                    
                    Toggle(isOn: $isGender) {
                        Text(L10n.personGender)
                    }.onChange(of: isGender) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.GENDER_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isCharacter) {
                        Text(L10n.personCharacter)
                    }.onChange(of: isCharacter) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.CHARACTER_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isWork) {
                        Text(L10n.personWork)
                    }.onChange(of: isWork) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.WORK_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isBirthday) {
                        Text(L10n.personBirthday)
                    }.onChange(of: isBirthday) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.BIRTHDAY_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isTell) {
                        Text(L10n.personTell)
                    }.onChange(of: isTell) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.TELL_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isMail) {
                        Text(L10n.personMail)
                    }.onChange(of: isMail) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.MAIL_KEY, isOn: newValue)
                    }
                    
                    Toggle(isOn: $isMemo) {
                        Text(L10n.personMemo)
                    }.onChange(of: isMemo) { newValue in
                        viewModel.setDisplayItem(key: UserDefaultsKey.MEMO_KEY, isOn: newValue)
                    }

                }

            }.tint(Asset.Colors.themaGreen.swiftUIColor)
            
            Spacer()
        }
            .onAppear {
                // 初期値セット
                isRuby = viewModel.getDisplayItem(key: UserDefaultsKey.RUBY_KEY)
                isGender = viewModel.getDisplayItem(key: UserDefaultsKey.GENDER_KEY)
                isCharacter = viewModel.getDisplayItem(key: UserDefaultsKey.CHARACTER_KEY)
                isWork = viewModel.getDisplayItem(key: UserDefaultsKey.WORK_KEY)
                isBirthday = viewModel.getDisplayItem(key: UserDefaultsKey.BIRTHDAY_KEY)
                isTell = viewModel.getDisplayItem(key: UserDefaultsKey.TELL_KEY)
                isMail = viewModel.getDisplayItem(key: UserDefaultsKey.MAIL_KEY)
                isMemo = viewModel.getDisplayItem(key: UserDefaultsKey.MEMO_KEY)
            }
            .navigationBarBackButtonHidden()
                .navigationBarHidden(true)
    }
}

#Preview {
    DisplayItemControlView()
}
