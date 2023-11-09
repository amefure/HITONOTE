//
//  DetailPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DetailPersonView: View {
    
    var dateFormatManager = DateFormatManager()
    var imageFileManager = ImageFileManager()
    
    public var person: Person
    
    var body: some View {
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

#Preview {
    DetailPersonView(person: Person.demoPerson)
}
