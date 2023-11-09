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
    @State var showingAlert: Bool = false
    
    var body: some View {
        ScrollView {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                Text("No Image")
                    .font(Font.system(size: 24).bold())
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 200)
                    .background(Color(UIColor.lightGray))
            }
            
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
                
                
                
            } label: {
                Image(systemName: "plus")
            }
            
            
            Button {
                showingAlert = true
            } label: {
                Text("Select Image")
            }
        }.sheet(isPresented: $showingAlert) {
            
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
        }
    }
}

#Preview {
    InputPersonView(person: nil)
}
