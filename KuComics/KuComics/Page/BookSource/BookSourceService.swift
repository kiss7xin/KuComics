//
//  BookSourceService.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import Foundation
import KakaJSON

class BookSourceService {
    
    static func fetchBookSourceData(url: String) async throws -> [BookSource] {
        
        return try await withCheckedThrowingContinuation({ continuation in
            KuNet.request(url, parameters: nil) { response in
                guard let data = response as? [Any] else {
                    return continuation.resume(throwing: ServiceError.jsonDecodeFailure)
                }
                let sourceList = data.kj.modelArray(BookSource.self)
                continuation.resume(with: Result.success(sourceList))
            }
        })
    }
}
