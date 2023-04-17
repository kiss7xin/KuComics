//
//  BookSourceViewModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/13.
//

import Foundation

class BookSourceViewModel: ObservableObject {
    @Published var fetchStatus: FetchStatus = .idle
    
    @Published var bookSources: [BookSource] = []
    
    @MainActor
    func fetchData(url: String) async {
        if fetchStatus == .fetching {
            return
        }
        do {
            fetchStatus = .fetching
            
            let result = try await BookSourceService.fetchBookSourceData(url: url)
            bookSources = result
            fetchStatus = .idle
        } catch {
            fetchStatus = .failed
        }
    }
    
    // 加载本地书源列表
    func loadLocalBookSources() {
        
    }
    
    // 批量导入列表到本地数据
    func insertBookSources(sources: [BookSource]) {
        
    }
    
    // 删除图源
    @MainActor
    func deleteBookSource(source: BookSource) {
        bookSources.removeAll(where: {
            $0.bookSourceUrl == source.bookSourceUrl && $0.bookSourceName == source.bookSourceName
        })
    }
    
    // 置顶图源
    @MainActor
    func toppingBookSource(source: BookSource) {
        if let index = bookSources.firstIndex(where: { $0.bookSourceUrl == source.bookSourceUrl}) {
            bookSources.remove(at: index)
            bookSources.insert(source, at: 0)
        }
    }
}
