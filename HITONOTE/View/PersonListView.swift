//
//  ContentView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI
import PhotosUI

struct PersonListView: View {
    
    @ObservedObject var repository = RepositoryViewModel.shared
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(repository.people) { person in
                    NavigationLink {
                        DetailPersonView(person: person)
                        
                    } label: {
                        Text(person.name)
                    }
                    
                }
            }
            
            NavigationLink {
                InputPersonView()
            } label: {
                Text("Input")
            }
            

        }.onAppear {
            repository.readAllPerson()
        }
    }

}

#Preview {
    PersonListView()
}





