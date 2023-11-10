//
//  PersonImageView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/10.
//

import SwiftUI

struct PersonImageView: View {
    
    public var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay{
                    RoundedRectangle(cornerRadius: 100)
                            .stroke(style: StrokeStyle(lineWidth: 5))
                            .frame(width: 100)
                            .foregroundStyle(Asset.Colors.opacityGray.swiftUIColor)
                }.padding(.top, 20)
                
        } else {
            Asset.Images.person.swiftUIImage
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay{
                    RoundedRectangle(cornerRadius: 100)
                            .stroke(style: StrokeStyle(lineWidth: 5))
                            .frame(width: 100)
                            .foregroundStyle(Asset.Colors.opacityGray.swiftUIColor)
                }.padding(.top, 20)
        }
    }
}

#Preview {
    PersonImageView(image: nil)
}
