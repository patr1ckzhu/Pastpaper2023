//
//  SearchService.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/22.
//

import Foundation
import Combine
import SwiftUI

struct SearchResult: Codable, Identifiable {
    var id = UUID()
    let name: String
    let text: String
    let url: String
}

struct SearchResponse: Codable {
    let hits: [SearchResult]
}

class SearchService: ObservableObject {
    @Published var results = [SearchResult]()

    func search(query: String, maxResults: Int) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "http://localhost:7700/indexes/movies/search?q=\(encodedQuery)") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer GDOWstuVp573dEvQELKLvEuh3fsPtlsjhSxhb1W4ufc", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    let limitedResults = searchResponse.hits.prefix(maxResults)  // 限制结果数量
                    DispatchQueue.main.async {
                        self.results = Array(limitedResults)  // 转换为数组赋值给 results
                    }
                } catch let error {
                    print("Parsing Error: \(error)")
                }
            }
        }.resume()
    }

}




