//
//  KuAlertView.swift
//  KuComics
//
//  Created by weixin on 2023/4/12.
//

import SwiftUI

public struct KuAlertView<Content>: View where Content: View {
    
    private let content: Content
    // 点击确定回调
    private var confirmAction: () -> Void = {}
    
    private var onTapBackgroundDismiss: Bool = true
    
    private var isShow: Binding<Bool>
    
    public var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .opacity(0.5)
            .onTapGesture {
                if onTapBackgroundDismiss {
                    self.isShow.wrappedValue = false
                }
            }
            
            VStack(spacing: 0) {
                content
                HStack(spacing: 0) {
                    Button {cancel()} label: {
                        Text("取消")
                            .foregroundColor(Color.grayText)
                            .frame(maxWidth: .infinity,maxHeight: 40)
                            .background(Color.buttonBackground)
                            .cornerRadius(4)
                    }
                    
                    Spacer().frame(width: 16)
                    
                    Button {confirm()} label: {
                        Text("确认")
                            .foregroundColor(Color.text)
                            .frame(maxWidth: .infinity,maxHeight: 40)
                            .background(Color.navbarbackgroundleft)
                            .cornerRadius(4)
                    }
                }
                .padding(.top,30)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal,30)
        }
    }
    
    private func cancel() {
        self.isShow.wrappedValue = false
    }
    
    private func confirm() {
        self.confirmAction()
        self.isShow.wrappedValue = false
    }
    
    public init(isShow: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isShow = isShow
        self.content = content()
    }
}

extension KuAlertView {
    
    public func onTapBackgroundDismiss(_ miss: Bool) -> KuAlertView {
        var result = self
        result.onTapBackgroundDismiss = miss
        return result
    }
    
    // 点击确定回调
    public func confirm(action: @escaping () -> Void) -> KuAlertView {
        var result = self
        result.confirmAction = action
        return result
    }
}

struct KuAlertView_Previews: PreviewProvider {
    static var previews: some View {
        KuAlertView (isShow: .constant(true)){
            VStack(alignment:.leading, spacing: 0) {
                Text("输入网址").font(.system(size: 18))
                    .padding(.bottom, 30)
                TextField("text", text: .constant("11"))
                    .textFieldStyle(.plain)
                    .font(.system(size: 16))
                    .foregroundColor(.grayText)
                Divider()
            }
        }
    }
}
