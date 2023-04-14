//
//  BookSourcePage.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import SwiftUI

struct BookSourcePage_Previews: PreviewProvider {
    static var previews: some View {
        BookSourcePage()
    }
}

struct BookSourcePage: View {
    @State var searchText = ""
    @State private var showMore = false
    
    @State private var isAddUrlShow = false
    @State private var isDeleteSourceShow = false
    
    @ObservedObject var viewModel = BookSourceViewModel()
    
    var body: some View {
        ZStack {
            KuNavigationBar {
                ZStack {
                    List {
                        BookSourceCell()
                    }
                    .listStyle(.plain)
                }
            }
            .maxWidth(leading: 320 , trailing: 100)
            .background(GradientBackgroundView())
            .isBackButtonBlack(false)
            .foreground(.white)
            .KuNavigationBarItems {
                HStack(spacing: 8) {
                    Image.search
                    searchView
                }
                .font(.system(size: 16))
                .padding(.horizontal)
                .frame(width: 180,height: 30)
                .background(Color.white.opacity(0.3))
                .cornerRadius(15)
                .padding(.horizontal, 30)
                .foregroundColor(.white)
            } trailing: {
                HStack(spacing: 20) {
                    Button {
                        selectAll()
                    } label: {
                        Image.checkmark
                            .font(.system(size: 16))
                            .foregroundColor(Color.text)
                    }
                    Button {
                        withAnimation {
                            showMore = true
                        }
                    } label: {
                        Image.ellipsis
                            .font(.system(size: 16))
                            .foregroundColor(Color.text)
                    }
                }
            }
            
            Group {
                MaskView(bgColor: .black)
                    .onTapGesture {
                        withAnimation {
                            showMore = false
                        }
                    }.opacity(showMore ? 1:0)

                moreFunctionView.opacity(showMore ? 1:0)
                
                addUrlMaskView.opacity(isAddUrlShow ? 1 : 0)
                deleteSourceMaskView.opacity(isDeleteSourceShow ? 1 : 0)
            }
            .animation(.easeInOut(duration: 0.2))
        }
    }
    
    private func selectAll() {
        
    }
    
    // 搜索框
    var searchView: some View {
        ZStack(alignment: .leading) {
            // Only show custom hint text if there is no text entered
            if searchText.isEmpty {
                Text("搜索")
                    .foregroundColor(.text)
            }
            TextField("", text: $searchText)
        }
    }
    
    // 更多功能
    var moreFunctionView: some View {
        HStack {
            Spacer()
            List {
                Button("添加图源") {
                    // push
                }
                Button("本地导入") {
                    showMore = false
                    
                }
                Button("网络导入") {
                    // 弹窗
                    showMore = false
                    isAddUrlShow = true
                }
                Button("扫码导入") {
                    // push
                }
                Button("导出图源") {
                    //
                }
                Button("分享选中源") {
                    // share
                }
                Button("删除图源") {
                    // 事件
                    showMore = false
                    isDeleteSourceShow = true
                }
                Button("校验图源") {
                    // 事件
                }
            }
            .listStyle(.plain)
            .font(.system(size: 14))
            .padding(.top, 44)
            .frame(width: UIScreen.main.bounds.width / 2)
        }
    }
    
    var addUrlMaskView: some View {
        KuAlertView(isShow: $isAddUrlShow) {
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
        .confirm {
            
        }
    }
    
    var deleteSourceMaskView: some View {
        KuAlertView(isShow: $isDeleteSourceShow) {
            VStack(alignment: .leading, spacing: 0) {
                Text("温馨提示").font(.system(size: 18))
                    .padding(.bottom, 30)
                    .foregroundColor(Color.grayText)
                Text("是否批量删除选中的图源？共4个图源！")
                    .font(.system(size: 16))
                    .foregroundColor(Color.grayText)
            }
        }
        .confirm {
            
        }
    }
}

struct BookSourceCell: View {
    
    var body: some View {
        HStack {
            Button{} label: {
                Image.checkmark
                    .foregroundColor(.gray)
            }
            Text("多多漫画")
            Spacer()
            
            HStack(spacing: 16) {
                Button{} label: {
                    Image.shelfEdit
                }
                Button{} label: {
                    Image.arrow_up_line
                }
                Button{} label: {
                    Image.trash
                }
            }
            .foregroundColor(.blue)
        }
        .font(.system(.body))
        .frame(height: 50)
    }
}
