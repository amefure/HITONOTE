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
    
    public var person: Person
    
    @State var isPresented = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
        
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: { dismiss() }, trailingAction: {
                isPresented = true
            })
            
            ScrollView {
            
                if let image = imageFileManager.loadImage(name: person.imagePath) {
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
                
                VStack {
                    Text(person.name)
                        .font(.system(size: 30))
                    Text(person.ruby)
                        .font(.system(size: 15))
                }.fontWeight(.bold)
                    .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
                    
            
                VStack {
                    HStack {
                        Text(L10n.personWork)
                        Text(person.work)
                    }.padding(.horizontal,20)
                    
                    HStack {
                        Text(L10n.personBirthday)
                        Text(dateFormatManager.getString(date: person.birthday))
                    }.padding(.horizontal,20)
                    
                    HStack {
                        Text(L10n.personTell)
                        Text(person.tell)
                    }.padding(.horizontal,20)
                    
                    HStack {
                        Text(L10n.personMail)
                        Text(person.mail)
                    }.padding(.horizontal,20)
                    
                    HStack {
                        Text(L10n.personMemo)
                        Text(person.memo)
                    }.padding(.horizontal,20)
                    
                    
                    Text(person.group)
                   
                    
                    Button {
                        repository.deletePerson(id: person.id)
                    } label: {
                        Image(systemName: "figure.wave")
                        Text("削除")
                    }
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width)
                .background(Asset.Colors.themaGreen.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
                
            }
        }.navigationDestination(isPresented: $isPresented) {
            InputPersonView(person: person)
        }
        .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

#Preview {
    DetailPersonView(person: Person.demoPerson)
}
