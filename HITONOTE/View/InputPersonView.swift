//
//  InputPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct InputPersonView: View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // Updateデータ受け取り用
    public var person: Person?
    
    init(person: Person?) {
        self.person = person
    }
    
    // MARK: - View
    @State private var name: String = ""           // 名前
    @State private var ruby: String = ""           // ルビ
    @State private var gender: Gender = .unknown   // 性別
    @State private var work: String = ""           // 職業
    @State private var character: String = ""      // こんな人
    @State private var birthday: Date? = nil       // 誕生日
    @State private var tell: String = ""           // 電話
    @State private var mail: String = ""           // メール
    @State private var url: String = ""            // URL
    @State private var group: String = ""          // グループ
    @State private var memo: String = ""           // メモ
    
    @State private var image: UIImage?                  // 画像表示用
    @State private var isShowImagePicker: Bool = false  // 画像ピッカー表示
    @State private var successAlert: Bool = false       // 登録成功アラート
    @State private var validationAlert: Bool = false    // バリデーションアラート
    
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
//                                print("保存成功")
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
                            url: url,
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
//                                print("保存成功")
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
                            url: url,
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
                        isShowImagePicker = true
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
                    
                    /// URL
                    CustomInputView(label: L10n.personUrl, text: $url, isShow: userDefaultsRepository.isUrl)
                    
                    /// グループ
                    CustomGroupPickerView(group: $group, groups: repository.groups, isShow: true)
                    
                    /// メモ
                    CustomInputEditorView(label: L10n.personMemo, text: $memo, isShow: userDefaultsRepository.isMemo)
                    
                }
            }.padding(20)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
                .fontWeight(.bold)
            
        }.sheet(isPresented: $isShowImagePicker) {
            
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
                url = person.url
                group = person.group
                image = imageFileManager.loadImage(name: person.imagePath)
                memo = person.memo
            }
            
        }.alert(person == nil ? L10n.inputSuccessAlertCreate(name) : L10n.inputSuccessAlertUpdate, isPresented: $successAlert) {
            Button("OK") {
                dismiss()
            }
        }.alert(L10n.inputValidationTitle, isPresented: $validationAlert) {
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
        
    }
}

// MARK: - 入力要素
struct CustomInputView: View {
    
    // MARK: - Receive
    public let label: String    // ラベル
    @Binding var text: String   // 入力値
    public let isShow: Bool     // 表示/非表示フラグ
    
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
    
    // MARK: - Receive
    public let label: String
    @Binding var text: String
    public let isShow: Bool
    
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
    
    // MARK: - Receive
    @Binding var gender: Gender  // 性別情報
    public let isShow: Bool      // 表示/非表示フラグ
    
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
                        Text(item.value)
                    }
                }
            }.tint(Asset.Colors.themaGreen.swiftUIColor)
        }
    }
}

// MARK: - 誕生日ピッカー
struct CustomBirthdayPickerView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    @Binding var birthday: Date? // 誕生日情報
    public let isShow: Bool      // 表示/非表示フラグ
    
    // MARK: - View
    @State private var date: Date = Date()
    @State private var isShowDatePicker: Bool = false
    
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
                        Text(isShowDatePicker ? L10n.inputBirthdayDecision : dateFormatManager.getString(date: birthday))
                    } else {
                        Text(isShowDatePicker ? L10n.inputBirthdayDecision : L10n.inputBirthdaySetting)
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
                               label: { Text(L10n.personBirthday) })
                    .environment(\.locale, Locale(identifier: L10n.dateLocale))
                    .environment(\.calendar, Calendar(identifier: .gregorian))
                    .datePickerStyle(.wheel)
                }
            }
        }
    }
}


// MARK: - グループピッカー
struct CustomGroupPickerView: View {
    
    // MARK: - Receive
    @Binding var group: String        // グループ情報
    public let groups: Array<String>  // 全てのグループ配列
    public let isShow: Bool           // 表示/非表示フラグ
    
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
