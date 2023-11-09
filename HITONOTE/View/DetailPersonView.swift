//
//  DetailPersonView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct DetailPersonView: View {
    
    private var dateFormatManager = DateFormatManager()
    
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
            Text(person.imagePath)
            Text(person.memo)
        }
    }
}

#Preview {
    DetailPersonView(person: Person.demoPerson)
}
