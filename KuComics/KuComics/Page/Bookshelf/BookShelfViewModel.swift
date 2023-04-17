//
//  BookShelfViewModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/17.
//

import Foundation

class BookShelfViewModel: ObservableObject {
    @Published var fetchStatus: FetchStatus = .idle
    var bookSources: [BookSource]?
    
    @MainActor
    func fetchData() async {
        if fetchStatus == .fetching {
            return
        }
        do {
            fetchStatus = .fetching
            
            let result = try await BookShelfService.getSourceList(url: "https://www.yckceo.com/yiciyuan/tuyuans/json/id/6.json")
            bookSources = result
            fetchStatus = .idle
        } catch {
            fetchStatus = .failed
        }
    }
    
    func getSourceList() {
        let url = URL(string:"http://127.0.0.1/sourceList.json")!
        var urlRequest = URLRequest(url:url)
        urlRequest.addValue("text/plain",forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let data = data,
        let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode,
        let strData = String(bytes: data, encoding: .utf8)
                {
                    print(strData)
        } }.resume()
    }
}
