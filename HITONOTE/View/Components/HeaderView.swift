//
//  HeaderView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct HeaderView: View {
    
    public var leadingIcon: String
    public var trailingIcon: String
    public var leadingAction: () -> Void
    public var trailingAction: () -> Void
    
    var body: some View {
        HStack {
            
            if !leadingIcon.isEmpty {
                
                Button {
                    leadingAction()
                } label: {
                    Image(systemName: leadingIcon)
                }.padding(.leading, 20)
            } else if !trailingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
            
            Spacer()
            
            Asset.Images.hitonoteLogo.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Spacer()
            
            if !trailingIcon.isEmpty {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: trailingIcon)
                }.padding(.trailing, 20)
            } else if !leadingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
        }
    }
}

#Preview {
    HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: {}, trailingAction: {})
}
