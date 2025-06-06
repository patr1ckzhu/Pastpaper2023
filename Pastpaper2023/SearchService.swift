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
    @Published var isLoading = false
    @Published var errorMessage: String?

    @MainActor
    func search(query: String, maxResults: Int) async {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "http://13.250.155.79:7700/indexes/PaperHub1/search?q=\(encodedQuery)&attributesToCrop=*&cropLength=20") else {
            self.errorMessage = "Invalid search URL"
            return
        }

        self.isLoading = true
        self.errorMessage = nil

        var request = URLRequest(url: url)
        request.setValue("Bearer 4B2Pw9qXqviIO_442NlJs-bcZ90U72o6RwTnCEa5Uvg", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.errorMessage = "Invalid response"
                self.isLoading = false
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                self.errorMessage = "Server error: \(httpResponse.statusCode)"
                self.isLoading = false
                return
            }
            
            let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            let limitedResults = searchResponse.hits.prefix(maxResults)
            self.results = Array(limitedResults)
            self.isLoading = false
            
        } catch {
            self.errorMessage = "Search failed: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}







