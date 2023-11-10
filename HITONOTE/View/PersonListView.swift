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
    private var imageFileManager = ImageFileManager()
    @State var selectedGroup: String = ""
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            
            HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: {}, trailingAction: {})
            
            if repository.groups.count != 0 {
                Picker(selection: $selectedGroup, label: Text(L10n.personGroup)) {
                    ForEach(repository.groups, id: \.self) { group in
                        Text(group)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            List {
                ForEach(repository.people) { person in
                    
                    NavigationLink {
                        DetailPersonView(person: person)
                    } label: {
                        HStack {
                            PersonImageView(image: imageFileManager.loadImage(name: person.imagePath), size: 30)
                            Text(person.name)
                        }
                    }
                    
                }
            }
            
            Button {
                isPresented = true
            } label: {
                Text("Input")
            }
            
            NavigationLink {
                SettingView()
            } label: {
                Text("Setting")
            }

            

        }.onAppear {
            repository.readAllPerson()
        }.sheet(isPresented: $isPresented, content: {
            InputPersonView(person: nil)
        }).tint(Asset.Colors.themaGreen.swiftUIColor)
    }

}

#Preview {
    PersonListView()
}
