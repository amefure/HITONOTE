//
//  InputPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct InputPersonView: View {
    
    @ObservedObject var repository = RepositoryViewModel.shared
    
    private var imageFileManager = ImageFileManager()
    
    // Updateデータ受け取り用
    public var person: Person?
    
    init(person: Person?) {
        self.person = person
    }
    
    @State var name: String = ""           // 名前
    @State var ruby: String = ""           // ルビ
    @State var work: String = ""           // 職業
    @State var birthday: Date = Date()     // 誕生日
    @State var tell: String = ""           // 電話
    @State var mail: String = ""           // メール
    @State var group: String = ""          // グループ
    @State var memo: String = ""           // メモ
    
    @State var image: UIImage?
    @State var isAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HeaderView(leadingIcon: "chevron.backward", trailingIcon: "figure.run", leadingAction: { dismiss() }, trailingAction: {
        
            if let person = person {
                
                var imgName = person.imagePath
                
                if imgName == "" {
                    imgName = UUID().uuidString   // 画像のファイル名を構築
                }
                
                if let image = image {
                    let result = imageFileManager.saveImage(name: imgName, image: image)
                    if result {
                        print("保存成功")
                    }
                }
                
                /// 更新処理
                repository.updatePerson(
                    id: person.id,
                    name: name,
                    ruby: ruby,
                    work: work,
                    birthday: birthday,
                    tell: tell,
                    mail: mail,
                    group: group,
                    imagePath: imgName,
                    memo: memo)
                
            } else {
                /// 新規登録
                var imgName = ""
                
                /// 画像がセットされていれば画像を表示
                if let image = image {
                    imgName = UUID().uuidString   // 画像のファイル名を構築
                    let result = imageFileManager.saveImage(name: imgName, image: image)
                    if result {
                        print("保存成功")
                    }
                }
                
                repository.createPerson(
                    name: name,
                    ruby: ruby,
                    work: work,
                    birthday: birthday,
                    tell: tell,
                    mail: mail,
                    group: group,
                    imagePath: imgName,
                    memo: memo)
                
            }
            
        })
        
        
        ScrollView {
            
            ZStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    Asset.Images.person.swiftUIImage
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Button {
                    isAlert = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            
            HStack {
                Text(L10n.personName)
                    .frame(width: 70)
                TextField("名前", text: $name)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
            HStack {
                Text(L10n.personRuby)
                    .frame(width: 70)
                TextField("ふりがな", text: $ruby)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
            HStack {
                Text(L10n.personWork)
                    .frame(width: 70)
                TextField("職業", text: $work)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
            
            DatePicker(selection: $birthday,
                       displayedComponents: DatePickerComponents.date,
                       label: { Text("誕生日") })
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .environment(\.calendar, Calendar(identifier: .gregorian))
            
            HStack {
                Text(L10n.personTell)
                    .frame(width: 70)
                TextField("電話番号", text: $tell)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
            HStack {
                Text(L10n.personMail)
                    .frame(width: 70)
                TextField("メールアドレス", text: $mail)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
            HStack {
                Text(L10n.personGroup)
                    .frame(width: 70)
                TextField("グループ", text: $group)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
           
            HStack {
                Text(L10n.personMemo)
                    .frame(width: 70)
                TextField("MEMO", text: $memo)
                    .textFieldStyle(.roundedBorder)
            }.padding(.trailing, 20)
            
        }.sheet(isPresented: $isAlert) {
            
        } content: {
            ImagePickerDialog(image: $image)
        }.onAppear {
            // Update時なら初期値セット
            if let person = person {
                name = person.name
                ruby = person.ruby
                work = person.work
                birthday = person.birthday
                tell = person.tell
                mail = person.mail
                group = person.group
                image = imageFileManager.loadImage(name: person.imagePath)
                memo = person.memo
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    InputPersonView(person: nil)
}
