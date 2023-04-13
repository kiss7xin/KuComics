//
//  BookshelfAddView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct BookshelfAddView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookShelf.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<BookShelf>
    
    @State var nameField: String = ""
    @State var styleSelected: Int = 1
    @State var sortSelected: Int = 1
    
    var body: some View {
        KuNavigationBar {
            VStack {
                GroupBox{
                    TextField("书架名称", text: $nameField)
                    Divider().padding(.bottom)
                    BookShelfTypeCell(title: "视图", menus: ["列表","网格"], selected: $styleSelected)
                    BookShelfTypeCell(title: "排序", menus: ["时间","拖拽"], selected: $sortSelected)
                }
                .padding()
                Spacer()
                Button{ addShelf() } label: {
                    Text("保存")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, KuHelper.safeAreaInsets.bottom)
                }
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            VStack {
                                Text(item.name ?? "未命名")
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            .background(Color.background)
        }
        .title("新增书架")
        .background(GradientBackgroundView())
        .isBackButtonBlack(false)
        .foreground(.white)

    }
    
    private func addShelf() {
        if nameField.count > 0 {
            debugPrint(nameField)
            withAnimation {
                let shelf = BookShelf(context: viewContext)
                shelf.id = UUID()
                shelf.name = nameField
                shelf.style = Int16(styleSelected)
                shelf.sort = Int16(sortSelected)
                shelf.timestamp = Date()
                shelf.canDelete = true
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct BookshelfAddView_Previews: PreviewProvider {
    static var previews: some View {
        BookshelfAddView()
    }
}
