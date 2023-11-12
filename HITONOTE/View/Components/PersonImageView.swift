//
//  PersonImageView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/10.
//

import SwiftUI

struct PersonImageView: View {
    
    // MARK: - Receive
    public var image: UIImage?
    public var size: CGFloat
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .background(.white)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size))
                .overlay{
                    RoundedRectangle(cornerRadius: size)
                        .stroke(style: StrokeStyle(lineWidth: size * 0.05))
                        .frame(width: size)
                        .foregroundStyle(.white)
                }.shadow(color: size == 100 ? Asset.Colors.opacityGray.swiftUIColor : .clear, radius: 3, x: 2, y: 3)
            
        } else {
            Asset.Images.person.swiftUIImage
                .resizable()
                .background(.white)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size))
                .overlay{
                    RoundedRectangle(cornerRadius: size)
                        .stroke(style: StrokeStyle(lineWidth: size * 0.05))
                        .frame(width: size)
                        .foregroundStyle(.white)
                }.shadow(color: size == 100 ? Asset.Colors.opacityGray.swiftUIColor : .clear, radius: 3, x: 2, y: 3)
        }
    }
}

#Preview {
    PersonImageView(image: nil, size: 100)
}
