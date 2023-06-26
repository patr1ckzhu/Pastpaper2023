//
//  SubjectListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/19.
//

import SwiftUI

struct Subject {
    var id: String { subject }
    var subject: String
    var years: [Year]
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
    let subject: String
    let year: String
    let season: String
    let type: String
    let name: String
    let url: String

    var fileName: String {
        return URL(string: url)?.lastPathComponent ?? "Unknown"
    }
    enum CodingKeys: String, CodingKey {
            case subject, year, season, type, name, url
        }
}

struct SubjectListView: View {
    @State var subjects: [Subject] = []
    @State var isLoading: Bool = true
    var urlString: String
    var navTitle: String
    @State var errorOccurred: Bool = false

    var body: some View {
        ZStack {
            if errorOccurred {
                EmptyView()
            } else {
                List {
                    Section(header: Text("Select Subject")) {
                        ForEach(subjects, id: \.subject) { subject in
                            NavigationLink(destination: YearListView(subject: subject)) {
                                Text(subject.subject)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle(navTitle, displayMode: .inline)
                .navigationBarItems(trailing: loadingIndicator)
                .opacity(isLoading ? 0 : 1) // 控制列表的透明度，当加载完成后变为不透明
            }
        }
        .refreshable {
            await loadSubjects()
        }
        .task {
            do {
                try await Task.sleep(nanoseconds: 1_000_000_00)
            } catch {
                print("Task cancelled: \(error)")
            }

            await loadSubjects()
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
    
    func loadSubjects() async {
        guard let url = URL(string: self.urlString) else {
            print("Invalid URL")
            return
        }

        do {
            // 创建一个异步任务来获取数据
            let fetchDataTask = Task { () -> Data in
                let (data, _) = try await URLSession.shared.data(from: url)
                return data
            }
            
            // 等待获取数据任务完成
            let data = try await fetchDataTask.value

            // 创建一个异步任务来解析数据
            let parseDataTask = Task { () -> [Subject] in
                if let decodedResponse = try? JSONDecoder().decode([Paper].self, from: data) {
                    let groupedPapersBySubject = Dictionary(grouping: decodedResponse, by: { $0.subject })

                    let subjects = groupedPapersBySubject.map { (subject, papers) -> Subject in
                        let groupedPapersByYear = Dictionary(grouping: papers, by: { $0.year })
                        
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
                        
                        return Subject(subject: subject, years: years)
                    }.sorted { $0.subject < $1.subject }

                    return subjects
                } else {
                    throw NSError(domain: "com.example", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
                }
            }

            // 等待解析数据任务完成
            let subjects = try await parseDataTask.value

            DispatchQueue.main.async {
                self.subjects = subjects
                self.isLoading = false // 科目加载完成，隐藏加载视图
                self.errorOccurred = false
            }

        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false // 加载出错，隐藏加载视图
                self.errorOccurred = true // 加载出错，显示错误消息
            }
        }
    }

}


