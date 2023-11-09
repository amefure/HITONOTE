//
//  DisplayItemControlView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DisplayItemControlView: View {
    
    @State var isName: Bool = false          // 名前
    @State var isRuby: Bool = false          // ルビ
    @State var isWork: Bool = false          // 職業
    @State var isBirthday: Bool = false      // 誕生日
    @State var isTell: Bool = false          // 電話
    @State var isMail: Bool = false          // メール
    @State var isGroup: Bool = false         // グループ
    @State var isMemo: Bool = false          // メモ
    
    
    var body: some View {
        
        HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: {}, trailingAction: {})
        
        Spacer()
        
        
        Toggle(isOn: $isName) {
            Text(L10n.personName)
        }
        
        Toggle(isOn: $isRuby) {
            Text(L10n.personRuby)
        }
        
        Toggle(isOn: $isWork) {
            Text(L10n.personWork)
        }
        
        Toggle(isOn: $isBirthday) {
            Text(L10n.personBirthday)
        }
        
        Toggle(isOn: $isTell) {
            Text(L10n.personTell)
        }
        
        Toggle(isOn: $isMail) {
            Text(L10n.personMail)
        }
        
        Toggle(isOn: $isGroup) {
            Text(L10n.personGroup)
        }
        
        Toggle(isOn: $isMemo) {
            Text(L10n.personMemo)
        }
        
        Spacer()
    }
}

#Preview {
    DisplayItemControlView()
}
