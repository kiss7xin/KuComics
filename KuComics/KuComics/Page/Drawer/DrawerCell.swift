//
//  DrawerCell.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import SwiftUI

struct DrawerCell<Destination: View>: View {
    @State private var isLinkActive: Bool = false
    var name: String
    var iconName: String
    let destination: () -> Destination
    var action: () -> Void = {}
    
    var body: some View {
        Group {
            Button {
                isLinkActive = true
                action()
            } label: {
                HStack {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30,height: 30)
                    Text(name)
                        .foregroundColor(Color.grayText)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            NavigationLink(isActive: $isLinkActive, destination: destination, label: {})
        }
    }
}

struct DrawerCell_Previews: PreviewProvider {
    static var previews: some View {
        DrawerCell(name: "图源", iconName: "drawer_source") {
            Text("123")
        }
    }
}

