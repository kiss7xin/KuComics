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
        
//        let API = RESTful(host: .github)
        
        try await withCheckedThrowingContinuation { continuation in
            KuNet.request(url, parameters: nil) { response in
                if let data = response as? String {
                    let sources = data.kj.modelArray(BookSource.self)
                    print("sources:\(sources)")
                    continuation.resume(with: Result.success(sources))
                    continuation.resume(returning: sources)
                } else {
                    continuation.resume(throwing: ServiceError.jsonDecodeFailure)
                }
            }
        }
    }
}
