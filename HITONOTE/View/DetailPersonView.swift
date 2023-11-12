//
//  DetailPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DetailPersonView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    @ObservedObject private var interstitial = AdmobInterstitialView()
    
    init(person: Person) {
        self.person = person
    }
    
    // MARK: - Receive
    var person: Person
    
    // MARK: - View
    @State private var isShowInput = false
    @State private var isDeleteDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            VStack {
                HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: {
                    // 3回に1回インタースティシャル広告を表示する
                    userDefaultsRepository.incrementCount()
                    if userDefaultsRepository.isCount == 3 {
                        interstitial.presentInterstitial()
                        userDefaultsRepository.resetCount()
                    }
                    dismiss()
                }, trailingAction: {
                    isShowInput = true
                }, isShowLogo: false)
                .tint(.white)
                
                /// アイコンとグループ
                HStack {
                    
                    if !person.group.isEmpty {
                        Spacer()
                            .frame(width: 100)
                    }
                    
                    Spacer()
                    
                    PersonImageView(image: imageFileManager.loadImage(name: person.imagePath), size: 100)
                    
                    Spacer()
                    
                    if !person.group.isEmpty {
                        Text(person.group)
                            .padding(8)
                            .frame(width: 100)
                            .foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius:  8))
                            .fontWeight(.bold)
                            .shadow(color: Asset.Colors.opacityGray.swiftUIColor, radius: 3, x: 2, y: 3)
                    }
                    
                }.padding()
                
                /// 名前とふりがな
                VStack {
                    Text(person.name)
                        .font(.system(size: 30))
                    if userDefaultsRepository.isRuby {
                        Text(person.ruby)
                            .font(.system(size: 15))
                    }
                }.fontWeight(.bold)
                    .foregroundStyle(.white)
                
            }.padding(.bottom)
                .background(Asset.Colors.themaGreen.swiftUIColor)
            
            
            
            /// 情報
            ScrollView(showsIndicators: false) {
                
                CustomPersonItemView(label: L10n.personGender, value: person.gender.rawValue, isShow: userDefaultsRepository.isGender)
                
                CustomPersonItemView(label: L10n.personCharacter, value: person.character, isShow: userDefaultsRepository.isCharacter)
                
                CustomPersonItemView(label: L10n.personWork, value: person.work, isShow: userDefaultsRepository.isWork)
                
                if let birthday = person.birthday, let currentAge = person.currentAge {
                    CustomPersonItemView(label: L10n.personBirthday, value: dateFormatManager.getString(date: birthday), isShow: userDefaultsRepository.isBirthday)
                    
                    CustomPersonItemView(label: L10n.personAge, value: L10n.personAgeView(currentAge), isShow: userDefaultsRepository.isBirthday)
                }
                
                CustomPersonItemView(label: L10n.personTell, value: person.tell, isShow: userDefaultsRepository.isTell)
                
                CustomPersonItemView(label: L10n.personMail, value: person.mail, isShow: userDefaultsRepository.isMail)
                
                CustomPersonItemView(label: L10n.personMemo, value: person.memo, isShow: userDefaultsRepository.isMemo)
                
                
                Spacer()
                
                
                Button {
                    isDeleteDialog = true
                } label: {
                    Text(L10n.deleteButtonTitle)
                        .padding(.vertical, 7)
                        .frame(width: 100)
                        .foregroundStyle(Asset.Colors.themaRed.swiftUIColor)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .frame(width: 100)
                                .foregroundStyle(Asset.Colors.themaRed.swiftUIColor)
                        }.padding(.top , 20)
                }
                
            }.padding(20)
                .frame(width: UIScreen.main.bounds.width)
                .background(.white)
                .fontWeight(.bold)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
            
            AdMobBannerView()
                .frame(height: 60)
            
        }.alert(L10n.deleteButtonAlertTitle(person.name), isPresented: $isDeleteDialog) {
            Button(role: .destructive) {
                repository.deletePerson(id: person.id)
                dismiss()
            } label: {
                Text(L10n.deleteButtonTitle)
            }
        }.onAppear {
            interstitial.loadInterstitial()
        }.sheet(isPresented: $isShowInput, content: {
            InputPersonView(person: person)
        }).navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

struct CustomPersonItemView: View {
    
    public let label: String
    public let value: String
    public let isShow: Bool
    
    var body: some View {
        if isShow {
            Group {
                if !value.isEmpty {
                    HStack {
                        Text(label)
                            .font(.system(size: 13))
                            .fontWeight(.light)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    Divider()
                        .padding(.bottom, 5)
                    Text(value)
                        .font(.system(size: 18))
                        .padding(.bottom, 10)
                        .textSelection(.enabled)
                }
            }
        }
    }
}


#Preview {
    DetailPersonView(person: Person.demoPerson)
}
