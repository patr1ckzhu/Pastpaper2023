//
//  TestView1.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/12.
//

import SwiftUI

struct TestView1: View {
    @State private var papers: [Paper] = []
    @State private var searchText = ""
    @State private var isSearching = false

    var body: some View {
        NavigationView {
            List {
                if isSearching {
                    let searchKeywords = searchText.lowercased().split(separator: " ")
                    ForEach(papers.filter { paper in
                        searchKeywords.allSatisfy { keyword in
                            paper.name.lowercased().contains(keyword) ||
                            paper.season.lowercased().contains(keyword) ||
                            paper.type.lowercased().contains(keyword) ||
                            paper.year.lowercased().contains(keyword)
                        }
                    }) { paper in
                        // 显示单个试卷的 View
                        NavigationLink(destination: WebView(url: URL(string: paper.url)!)
                            .edgesIgnoringSafeArea(.all)) {
                                Text(paper.name)
                        }
                    }
                } else {
                    Text("hello")
                    Text("hello")
                    Text("hello")
                    Text("hello")
                }
                // 其他部分...
            }
            .listStyle(.plain)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
            }
            .navigationTitle(Text("Home"))
            // 其他代码...
        }
        .onAppear(perform: fetchPapers)
    }

    func fetchPapers() {
        guard let url = URL(string: "http://13.41.199.9:8081/edx-ial-maths") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()

                if let fetchedPapers = try? decoder.decode([Paper].self, from: data) {
                    DispatchQueue.main.async {
                        self.papers = fetchedPapers
                    }
                } else {
                    print("Invalid response from server")
                }
            }
        }

        task.resume()
    }
}
