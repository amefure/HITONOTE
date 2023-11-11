//
//  InputPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct InputPersonView: View {
    
    @ObservedObject var repository = RealmRepositoryViewModel.shared
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    
    private let imageFileManager = ImageFileManager()
    
    // Updateデータ受け取り用
    public var person: Person?
    
    init(person: Person?) {
        self.person = person
    }
    
    @State var name: String = ""           // 名前
    @State var ruby: String = ""           // ルビ
    @State var gender: Gender = .unknown   // 性別
    @State var work: String = ""           // 職業
    @State var character: String = ""      // こんな人
    @State var birthday: Date? = nil       // 誕生日
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
                            gender: gender,
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
                            gender: gender,
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
                    
                }, isShowLogo: false)
                .padding(.top ,30)
                .tint(.white)
                
                
                ZStack {
                    
                    PersonImageView(image: image, size: 100)
                        .padding(.top, 20)
                    Button {
                        isAlert = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 100, height: 100)
                            .background(Asset.Colors.opacityGray.swiftUIColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                    }.padding(.top, 20)
                }
            }.padding(.bottom)
                .background(Asset.Colors.themaGreen.swiftUIColor)
            
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    /// 名前
                    CustomInputView(label: L10n.personName, text: $name, isShow: true)
                    
                    /// ふりがな
                    CustomInputView(label: L10n.personRuby, text: $ruby, isShow: userDefaultsRepository.isRuby)
                
                    /// 性別
                    CustomGenderPickerView(gender: $gender, isShow: userDefaultsRepository.isGender)
                    
                    ///  こんな人
                    CustomInputEditorView(label: L10n.personCharacter, text: $character, isShow: userDefaultsRepository.isCharacter)
                    
                    /// 職業
                    CustomInputView(label: L10n.personWork, text: $work, isShow: userDefaultsRepository.isWork)
                    
                    /// 誕生日
                    CustomBirthdayPickerView(birthday: $birthday, isShow: userDefaultsRepository.isBirthday)
                    
                    /// 電話
                    CustomInputView(label: L10n.personTell, text: $tell, isShow: userDefaultsRepository.isTell)
                    
                    /// メール
                    CustomInputView(label: L10n.personMail, text: $mail, isShow: userDefaultsRepository.isMail)
                    
                    /// グループ
                    CustomGroupPickerView(group: $group, groups: repository.groups, isShow: true)
                    
                    /// メモ
                    CustomInputEditorView(label: L10n.personMemo, text: $memo, isShow: userDefaultsRepository.isMemo)
                
                }
            }.padding(20)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
                .fontWeight(.bold)
            
        }.sheet(isPresented: $isAlert) {
            
        } content: {
            ImagePickerDialog(image: $image)
        }.onAppear {
            // Update時なら初期値セット
            if let person = person {
                name = person.name
                ruby = person.ruby
                gender = person.gender
                character = person.character
                work = person.work
                birthday = person.birthday
                tell = person.tell
                mail = person.mail
                group = person.group
                image = imageFileManager.loadImage(name: person.imagePath)
                memo = person.memo
            }
            
            userDefaultsRepository.setDisplayAllItem()
        }.alert(person == nil ? "「\(name)」さんを登録しました。" : "データを更新しました。", isPresented: $successAlert) {
            Button("OK") {
                dismiss()
            }
        }.alert("名前は必須入力です。", isPresented: $validationAlert) {
            
        }
        .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            
       
    }
}

// MARK: - 入力要素
struct CustomInputView: View {
    
    public var label: String
    @Binding var text: String
    public var isShow: Bool
    
    var body: some View {
        if isShow {
            VStack {
                HStack {
                    Text(label)
                        .font(.system(size: 13))
                        .fontWeight(.light)
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
}

// MARK: - Editor入力要素
struct CustomInputEditorView: View {
    
    public var label: String
    @Binding var text: String
    public var isShow: Bool
    
    var body: some View {
        if isShow {
            VStack {
                HStack {
                    Text(label)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                        .padding(.leading, 5)
                    Spacer()
                }
                
                Divider()
                    .padding(.bottom, 5)
                
                TextEditor(text: $text)
                    .frame(height: 100)
                    .padding(.bottom, 10)
                    .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(Asset.Colors.opacityGray.swiftUIColor)
                    }
            }
        }
    }
}


// MARK: - 性別ピッカー
struct CustomGenderPickerView: View {
    
    @Binding var gender: Gender
    public var isShow: Bool
    
    var body: some View {
        if isShow {
            VStack {
                HStack {
                    Text(L10n.personGender)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                        .padding(.leading, 5)
                    Spacer()
                }
                Divider()
                    .padding(.bottom, 5)
                
                Picker(selection: $gender, label: Text(L10n.personGender)) {
                    ForEach(Gender.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
            }
        }
    }
}

// MARK: - 誕生日ピッカー
struct CustomBirthdayPickerView: View {
    
    @Binding var birthday: Date?
    @State var date: Date = Date()
    @State var isShowDatePicker: Bool = false
    public var isShow: Bool
    
    private let dateFormatManager = DateFormatManager()
    
    
    var body: some View {
        if isShow {
            VStack {
                HStack {
                    Text(L10n.personBirthday)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                        .padding(.leading, 5)
                    Spacer()
                }
                
                Divider()
                    .padding(.bottom, 5)
                
                Button {
                    /// 決定ボタン押下時
                    if isShowDatePicker {
                        birthday = date
                    }
                    isShowDatePicker.toggle()
                } label: {
                    if let birthday = birthday {
                        Text(isShowDatePicker ? "決定" : dateFormatManager.getString(date: birthday))
                    } else {
                        Text(isShowDatePicker ? "決定" : "誕生日を設定する")
                        if !isShowDatePicker {
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 13))
                        }
                    }
                }.foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                    .fontWeight(.none)
                if isShowDatePicker {
                    DatePicker(selection: $date,
                               displayedComponents: DatePickerComponents.date,
                               label: { Text("誕生日") })
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    .environment(\.calendar, Calendar(identifier: .gregorian))
                    .datePickerStyle(.wheel)
                }
            }
        }
    }
}


// MARK: - グループピッカー
struct CustomGroupPickerView: View {
    
    @Binding var group: String
    let groups: Array<String>
    public var isShow: Bool
    
    var body: some View {
        if isShow {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text(L10n.personGroup)
                                .font(.system(size: 13))
                                .fontWeight(.light)
                                .padding(.leading, 5)
                            
                            Spacer()
                            
                            if groups.count != 0 {
                                
                                HStack {
                                    Menu(L10n.personGroup) {
                                        ForEach(groups, id: \.self) { group in
                                            Button {
                                                self.group = group
                                            } label: {
                                                Text(group)
                                            }
                                        }
                                    }
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 13))
                                }.foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                                    .fontWeight(.none)
                            }
                        }
                        Divider()
                            .padding(.bottom, 5)
                        TextField(L10n.personGroup, text: $group)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    InputPersonView(person: nil)
}
