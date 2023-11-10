//
//  DetailPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DetailPersonView: View {
    
    private var dateFormatManager = DateFormatManager()
    private var imageFileManager = ImageFileManager()
    @ObservedObject var repository = RepositoryViewModel.shared
    
    init(person: Person) {
        self.person = person
    }
    
    var person: Person
    
    @State var isPresented = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
        
            VStack {
                
                HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: { dismiss() }, trailingAction: {
                    isPresented = true
                }, isShowLogo: false)
                .tint(.white)
                
                /// アイコンとグループ
                HStack {
                    
                    Spacer()
                        .frame(width: 100)
                    
                    Spacer()
                        
                    PersonImageView(image: imageFileManager.loadImage(name: person.imagePath), size: 100)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Text(person.group)
                        .padding(8)
                        .frame(width: 100)
                        .foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .fontWeight(.bold)
                        
                }
                            
                /// 名前とふりがな
                VStack {
                    Text(person.name)
                        .font(.system(size: 30))
                    Text(person.ruby)
                        .font(.system(size: 15))
                }.fontWeight(.bold)
                        .foregroundStyle(.white)
                
            }.padding(.bottom)
                .background(Asset.Colors.themaGreen.swiftUIColor)
                
            
            
            /// 情報
            ScrollView {
                
                    
                    CustomPersonItemView(label: L10n.personCharacter, value: person.character)
                    
                    CustomPersonItemView(label: L10n.personWork, value: person.work)
                    
                    CustomPersonItemView(label: L10n.personBirthday, value: dateFormatManager.getString(date: person.birthday))
                    
                    CustomPersonItemView(label: L10n.personTell, value: person.tell)
                    CustomPersonItemView(label: L10n.personMail, value: person.mail)
                    CustomPersonItemView(label: L10n.personMemo, value: person.memo)
                    
                    
                    
                    Button {
                        repository.deletePerson(id: person.id)
                    } label: {
                        Image(systemName: "figure.wave")
                        Text("削除")
                    }.padding()
                    .frame(width: 200)
                    .background(Asset.Colors.themaRed.swiftUIColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                    
                    Spacer()
                
            }.padding(20)
                .frame(width: UIScreen.main.bounds.width)
                .background(.white)
                .fontWeight(.bold)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)

            
        }.sheet(isPresented: $isPresented, content: {
            InputPersonView(person: person)
        }).navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

struct CustomPersonItemView: View {
    
    public var label: String
    public var value: String
    
    var body: some View {
        Group {
            if !value.isEmpty {
                HStack {
                    Text(label)
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


#Preview {
    DetailPersonView(person: Person.demoPerson)
}
