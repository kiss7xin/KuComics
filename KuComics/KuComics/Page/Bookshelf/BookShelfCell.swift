//
//  BookShelfCell.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import SwiftUI
import Kingfisher

struct BookShelfCell: View {
    
    var width: Double?
    
    var body: some View {
        HStack {
            let image = KFImage(URL(string: ""))
                .placeholder{
                    Rectangle().foregroundColor(Color.primary)}
                .resizable()
                .aspectRatio(3/4, contentMode: .fit)
                .clipped()
            if let width = width {
                image.frame(width: width)
            } else {
                image
            }
        }
        .padding()
    }
}

struct BookShelfCell_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfCell()
    }
}


