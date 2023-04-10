//
//  KuNavigationBarBaseView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct KuBackgroundView: View {
    var content: AnyView?

    var body: some View {
        if content != nil {
            content
        } else {
            Color.clear
        }
    }
}

struct KuTitleView: View {
    var content: AnyView?

    var body: some View {
        if content != nil {
            content
        } else {
            Color.clear
        }
    }
}

struct KuLeadingView: View {

    var content: AnyView?
    
    var body: some View {
        if content != nil {
            content
        } else {
            Color.clear
        }
    }
}

struct KuTrailingView: View {
    
    var content: AnyView?

    var body: some View {
        if content != nil {
            content
        } else {
            Color.clear
        }
    }
}

struct KuDefaultTitleView: View {
    let title: String
    let foreground: Color
    var body: some View {
        Text(title)
            .lineLimit(1)
            .foregroundColor(foreground)
            .font(.system(size: 17))
    }
}

struct KuDefaultTitleView_Previews: PreviewProvider {
    static var previews: some View {
        KuDefaultTitleView(title: "test", foreground: .black)
    }
}

struct KuDefaultBackButton: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var named: String?
    var isBlack: Bool = true
    var foreground: Color = .black
    var action: KuBlock?

    init(named: String? = nil, tapAction: KuBlock? = nil, isBlack: Bool = true, foreground: Color = .black) {
        self.named = named
        self.action = tapAction
        self.isBlack = isBlack
        self.foreground = foreground
    }

    var body: some View {
        Button(action: {
            if let action = action {
                action()
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            backImage()
                .resizable()
                .frame(width: 13, height: 13)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(foreground)
        }
    }

    private func backImage() -> Image {
        if named != nil {
            return Image(named!)
        } else {
            return Image(systemName: "arrow.backward")
            
//            return Image(uiImage: isBlack ? KuImg(name: "back_arrow@2x") : KuImg(name: "back_arrow_white@2x"))
        }
    }

//    private func KuImg(name: String, type: String = "png") -> UIImage {
//        return UIImage(named: name, in: Bundle.KuNavigationBarBundle, compatibleWith: nil) ?? UIImage()
//    }
}

struct KuDefaultBackButton_Previews: PreviewProvider {
    static var previews: some View {
        KuDefaultBackButton(isBlack: true)
    }
}
