//
//  YearListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct Subject: Identifiable {
    let id = UUID()  // 添加 UUID 作为唯一标识符
    let title: String
    let code: String
    let urlString: String
}

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
    @State var isLoading: Bool = true
    var urlString: String
    var navTitle: String
    @State var loadFailed: Bool = false

    var body: some View {
        ZStack {
            if loadFailed {
                VStack {
                    Spacer()
                }
            } else {
                List {
                    Section(header: Text("Select Exam Year")) {
                        ForEach(years, id: \.year) { year in
                            NavigationLink(destination: SeasonListView(year: year)) {
                                Text(year.year)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle(navTitle, displayMode: .inline)
                .navigationBarItems(trailing: loadingIndicator)
                .opacity(isLoading ? 0 : 1)
            }
        }
        .refreshable {
            await loadYears()
        }
        .task {
            await loadYears()
        }
    }

    var loadingIndicator: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
    
    func loadYears() async {
        guard let url = URL(string: self.urlString) else {
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
                        .sorted { $0.type < $1.type } // 在这里对 examTypes 进行字母排序
                        return Season(season: season, examTypes: examTypes)
                    }.sorted { $0.season < $1.season }

                    return Year(year: year, seasons: seasons)
                }.sorted { $0.year > $1.year }

                DispatchQueue.main.async {
                    self.years = years
                    self.isLoading = false // 科目加载完成，隐藏加载视图
                    self.loadFailed = false // 加载成功，隐藏加载失败界面
                }
            } else {
                self.loadFailed = true // 数据解码失败，显示加载失败界面
                self.isLoading = false // 停止加载动画
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false // 加载出错，隐藏加载视图
                self.loadFailed = true // 加载出错，显示加载失败界面
            }
        }
    }
}

