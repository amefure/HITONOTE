//
//  InputPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct InputPersonView: View {
    
    @ObservedObject var repository = RepositoryViewModel.shared
    
    @State var name: String = ""           // 名前
    @State var ruby: String = ""           // ルビ
    @State var work: String = ""           // 職業
    @State var birthday: Date = Date()     // 誕生日
    @State var tell: String = ""           // 電話
    @State var mail: String = ""           // メール
    @State var group: String = ""          // グループ
    @State var image: String = ""          // 画像
    @State var memo: String = ""           // メモ
    
    var body: some View {
        ScrollView {
            TextField("名前", text: $name)
            TextField("ふりがな", text: $ruby)
            TextField("職業", text: $work)
            
            DatePicker(selection: $birthday,
                       displayedComponents: DatePickerComponents.date,
                       label: { Text("誕生日") })
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .environment(\.calendar, Calendar(identifier: .gregorian))
            
            TextField("電話番号", text: $tell)
            TextField("メールアドレス", text: $mail)
            TextField("グループ", text: $group)
            TextField("MEMO", text: $memo)
            
            Button {
                repository.createPerson(
                    name: name,
                    ruby: ruby,
                    work: work,
                    birthday: birthday,
                    tell: tell,
                    mail: mail,
                    image: image,
                    memo: memo)
            } label: {
                Image(systemName: "plus")
            }

        }
    }
}

#Preview {
    InputPersonView()
}
