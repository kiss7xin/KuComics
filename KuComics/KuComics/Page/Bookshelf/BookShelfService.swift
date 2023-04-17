//
//  BookShelfService.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import Foundation

class BookShelfService {
    
    /// 保存书架分类
    /// - Parameter item: 书架分类对象
    static func saveBookShelfItem(item :BookShelfItem) {
        
    }
    
    static func getSourceList(url: String) async throws -> [BookSource] {
        
        return try await withCheckedThrowingContinuation({ continuation in
            
            guard let data = try? Data(contentsOf: URL(string: url)!),
                  let json = try? JSONSerialization.jsonObject(with: data) as? [Any]
            else {
                return
            }
            
            let sources = json.kj.modelArray(BookSource.self)
            print("sources:\(sources)")
            continuation.resume(with: Result.success(sources))
        })
    }
}
