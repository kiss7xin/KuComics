//
//  BookSourceViewModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/13.
//

import Foundation

class BookSourceViewModel: ObservableObject {
    @Published var fetchStatus: FetchStatus = .fetching
    
    var bookSources: [BookSource]?
    
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
}
