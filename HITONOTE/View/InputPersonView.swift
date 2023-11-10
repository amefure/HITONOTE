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
    @State var character: String = ""      // こんな人
    @State var birthday: Date = Date()     // 誕生日
    @State var tell: String = ""           // 電話
    @State var mail: String = ""           // メール
    @State var group: String = ""          // グループ
    @State var memo: String = ""           // メモ
    
    @State var image: UIImage?
    @State var isAlert: Bool = false
    @State var successAlert: Bool = false
    @State var validationAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "figure.run", leadingAction: { dismiss() }, trailingAction: {
                
                guard !name.isEmpty else {
                    validationAlert = true
                    return
                }
            
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
                        character: character,
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
                        character: character,
                        work: work,
                        birthday: birthday,
                        tell: tell,
                        mail: mail,
                        group: group,
                        imagePath: imgName,
                        memo: memo)
                    
                }
                
                successAlert = true
                
            })
            
            
            ZStack {
                
                PersonImageView(image: image)
                
                Button {
                    isAlert = true
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 100, height: 100)
                        .background(Asset.Colors.opacityGray.swiftUIColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .padding(.top, 20)
                }
                
            }
            
            
            ScrollView {
                
                VStack {
                    
                    CustomInputView(label: L10n.personName, text: $name)
                    
                    CustomInputView(label: L10n.personRuby, text: $ruby)
                    
                    CustomInputView(label: L10n.personCharacter, text: $character)
                    
                    CustomInputView(label: L10n.personWork, text: $work)
                    
                    CustomInputView(label: L10n.personTell, text: $tell)
                    
                    DatePicker(selection: $birthday,
                               displayedComponents: DatePickerComponents.date,
                               label: { Text("誕生日") })
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    .environment(\.calendar, Calendar(identifier: .gregorian))

                    CustomInputView(label: L10n.personMail, text: $mail)
                    
                    CustomInputView(label: L10n.personGroup, text: $group)
                    
                    CustomInputView(label: L10n.personMemo, text: $memo)
                
                }
            }.padding(20)
            .background(Asset.Colors.themaGreen.swiftUIColor)
                .foregroundStyle(.white)
                .fontWeight(.bold)
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
        }.alert("「\(name)」さんを登録しました。", isPresented: $successAlert) {
            Button("OK") {
                dismiss()
            }
        }.alert("名前は必須入力です。", isPresented: $validationAlert) {
            
        }
        .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            
       
    }
}


struct CustomInputView: View {
    
    public var label: String
    @Binding var text: String
    
    var body: some View {
        Group {
            HStack {
                Text(label)
                    .padding(.leading, 5)
                Spacer()
            }
            Divider()
                .padding(.bottom, 5)
            TextField(label, text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 10)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
        }
    }
}



#Preview {
    InputPersonView(person: nil)
}
