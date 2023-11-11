//
//  DisplayItemControlView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DisplayItemControlView: View {

    private var viewModel = DisplayItemControlViewModel()
    
    @State private var isGender: Bool = false        // 性別
    @State private var isCharacter: Bool = false     // キャラクター
    @State private var isWork: Bool = false          // 職業
    @State private var isBirthday: Bool = false      // 誕生日
    @State private var isTell: Bool = false          // 電話
    @State private var isMail: Bool = false          // メール
    @State private var isMemo: Bool = false          // メモ
    
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

            }
            
            Spacer()
        }
            .onAppear {
                // 初期値セット
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
