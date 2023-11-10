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
        
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: { dismiss() }, trailingAction: {
                isPresented = true
            })
                        
            PersonImageView(image: imageFileManager.loadImage(name: person.imagePath))
            
            VStack {
                Text(person.name)
                    .font(.system(size: 30))
                Text(person.ruby)
                    .font(.system(size: 15))
            }.fontWeight(.bold)
                .foregroundStyle(Asset.Colors.textColor.swiftUIColor)
                
            
            ScrollView {
                
                    
                    CustomPersonItemView(label: L10n.personCharacter, value: person.character)
                    
                    CustomPersonItemView(label: L10n.personWork, value: person.work)
                    
                    CustomPersonItemView(label: L10n.personBirthday, value: dateFormatManager.getString(date: person.birthday))
                    
                    CustomPersonItemView(label: L10n.personTell, value: person.tell)
                    CustomPersonItemView(label: L10n.personMail, value: person.mail)
                    CustomPersonItemView(label: L10n.personMemo, value: person.memo)
                    
                    Text(person.group)
                    
                    Button {
                        repository.deletePerson(id: person.id)
                    } label: {
                        Image(systemName: "figure.wave")
                        Text("削除")
                    }
                    
                    Spacer()
                
            }.frame(width: UIScreen.main.bounds.width)
                .padding(20)
                .background(Asset.Colors.themaGreen.swiftUIColor)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                
            
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
            HStack {
                Text(label)
                    .padding(.leading, 5)
                Spacer()
            }
            Divider()
                .padding(.bottom, 5)
            Text(value.isEmpty ? "-" : value)
                .padding(.bottom, 10)
        }
    }
}


#Preview {
    DetailPersonView(person: Person.demoPerson)
}
