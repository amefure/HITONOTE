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
    private let imageFileManager = ImageFileManager()
    @State var selectedGroup: String = ""
    @State var isShowInput = false
    @State var isShowSetting = false
    
    var body: some View {
        NavigationStack {
            
            HeaderView(leadingIcon: "gearshape.fill", trailingIcon: "plus", leadingAction: { isShowSetting = true }, trailingAction: { isShowInput = true })
                .navigationDestination(isPresented: $isShowSetting) {
                    SettingView()
                }
            
            if repository.groups.count != 0 {                
                CustomSegmentedPicker(groups: repository.groups, selectedSegment: $selectedGroup)
                
            }
            
            List {
                ForEach(repository.people) { person in
                    
                    NavigationLink {
                        DetailPersonView(person: person)
                    } label: {
                        HStack {
                            PersonImageView(image: imageFileManager.loadImage(name: person.imagePath), size: 30)
                            Text(person.name)
                                .fontWeight(.bold)
                        }
                    }
                    
                }
            }.listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(.clear)
                    

        }.onAppear {
            repository.readAllPerson()
        }.sheet(isPresented: $isShowInput, content: {
            InputPersonView(person: nil)
        }).tint(Asset.Colors.themaGreen.swiftUIColor)
    }

}


struct CustomSegmentedPicker: View {
    
    var groups: Array<String>
    @Binding var selectedSegment: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(groups, id: \.self) { group in
                    Button {
                        withAnimation {
                            print(group)
                            selectedSegment = group
                            print(selectedSegment)
                        }
                    } label: {
                        Text(group)
                    }.padding(10)
                        .background(selectedSegment == group ? Asset.Colors.themaGreen.swiftUIColor : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(.white)
                }
            }
        }.padding(5)
            .background(Asset.Colors.opacityGray.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .transition(.scale)
            .padding(.horizontal, 5)
    }
}


#Preview {
    PersonListView()
}
