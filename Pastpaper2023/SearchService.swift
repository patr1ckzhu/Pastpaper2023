//
//  SearchService.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/22.
//

import Foundation
import Combine
import SwiftUI

struct FormattedResult: Codable {
    let name: String
    let text: String
    let url: String
}

struct SearchResult: Codable, Identifiable {
    var id = UUID()
    let name: String
    let text: String
    let url: String
    let _formatted: FormattedResult
}

struct SearchResponse: Codable {
    let hits: [SearchResult]
}

class SearchService: ObservableObject {
    @Published var results = [SearchResult]()

    func search(query: String, maxResults: Int) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://ms-0a4a426b899d-4297.sgp.meilisearch.io/indexes/PaperHub1/search?q=\(encodedQuery)&attributesToCrop=*&cropLength=20") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer 7caaacdf03091ab0357affc290607d0e92bda640", forHTTPHeaderField: "Authorization")

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







