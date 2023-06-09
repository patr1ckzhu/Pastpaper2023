//
//  YearListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct Year {
    var id: String { year }
    var year: String
    var seasons: [Season]
}

struct ExamType {
    var id: String { type }
    var type: String
    var papers: [Paper]
}

struct Season {
    var id: String { season }
    var season: String
    var examTypes: [ExamType]
}

struct Paper: Identifiable, Codable {
    let id = UUID()
    let year: String
    let season: String
    let type: String
    let name: String
    let url: String

    var fileName: String {
        return URL(string: url)?.lastPathComponent ?? "Unknown"
    }
    enum CodingKeys: String, CodingKey {
            case year, season, type, name, url
        }
}


struct YearListView: View {
    @State var years: [Year] = []

    var body: some View {
        List(years, id: \.year) { year in
            NavigationLink(destination: SeasonListView(year: year)) {
                Text(year.year)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Years", displayMode: .inline)
        .refreshable {
            await loadYears()
        }
        .task {
            await loadYears()
        }
    }

    func loadYears() async {
        guard let url = URL(string: "http://localhost:3000/pastpapers") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Paper].self, from: data) {
                let groupedPapersByYear = Dictionary(grouping: decodedResponse, by: { $0.year })

                let years = groupedPapersByYear.map { (year, papers) -> Year in
                    let groupedPapersBySeason = Dictionary(grouping: papers, by: { $0.season })
                    
                    let seasons = groupedPapersBySeason.map { (season, papers) -> Season in
                        let groupedPapersByType = Dictionary(grouping: papers, by: { $0.type })
                        let examTypes = groupedPapersByType.map { ExamType(type: $0.key, papers: $0.value) }
                        return Season(season: season, examTypes: examTypes)
                    }

                    return Year(year: year, seasons: seasons)
                }.sorted { $0.year > $1.year }

                DispatchQueue.main.async {
                    self.years = years
                }
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

}


