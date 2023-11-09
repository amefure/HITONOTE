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
    
    var body: some View {
        
        VStack {
            NavigationLink {
                InputPersonView(person: person)
            } label: {
                Text("編集する")
            }
            
            Button {
                repository.deletePerson(id: person.id)
            } label: {
                Text("削除する")
            }

            ScrollView {
                Text(person.name)
                Text(person.ruby)
                Text(person.work)
                Text(dateFormatManager.getString(date: person.birthday))
                Text(person.tell)
                Text(person.mail)
                Text(person.group)
                
                Image(uiImage: imageFileManager.loadImage(name: person.imagePath) ?? UIImage(systemName: "iphone")!)
               
                Text(person.imagePath)
                Text(person.memo)
            }
        }
    }
}

#Preview {
    DetailPersonView(person: Person.demoPerson)
}
