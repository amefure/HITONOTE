//
//  PersonImageView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/10.
//

import SwiftUI

struct PersonImageView: View {
    
    public var image: UIImage?
    public var size: CGFloat
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size))
                .overlay{
                    RoundedRectangle(cornerRadius: size)
                        .stroke(style: StrokeStyle(lineWidth: size * 0.05))
                            .frame(width: size)
                            .foregroundStyle(Asset.Colors.opacityGray.swiftUIColor)
                }
                
        } else {
            Asset.Images.person.swiftUIImage
                .resizable()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size))
                .overlay{
                    RoundedRectangle(cornerRadius: size)
                            .stroke(style: StrokeStyle(lineWidth: size * 0.05))
                            .frame(width: size)
                            .foregroundStyle(Asset.Colors.opacityGray.swiftUIColor)
                }
        }
    }
}

#Preview {
    PersonImageView(image: nil, size: 100)
}
