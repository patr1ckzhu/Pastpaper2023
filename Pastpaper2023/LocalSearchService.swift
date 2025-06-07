import Foundation
import CoreData
import Combine

class LocalSearchService: ObservableObject {
    @Published var results: [SearchResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.viewContext) {
        self.context = context
    }
    
    @MainActor
    func search(query: String, maxResults: Int) async {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.results = []
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let searchResults = try await performSearch(query: query, limit: maxResults)
            self.results = searchResults
        } catch {
            self.errorMessage = "Search failed: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
    
    private func performSearch(query: String, limit: Int) async throws -> [SearchResult] {
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let request: NSFetchRequest<CDPaper> = CDPaper.fetchRequest()
                    
                    // 创建搜索条件
                    let queryWords = query.lowercased().components(separatedBy: .whitespacesAndNewlines)
                        .filter { !$0.isEmpty }
                    
                    var predicates: [NSPredicate] = []
                    
                    for word in queryWords {
                        let contentPredicate = NSPredicate(format: "content CONTAINS[cd] %@", word)
                        let filenamePredicate = NSPredicate(format: "fileName CONTAINS[cd] %@", word)
                        let examBoardPredicate = NSPredicate(format: "examBoard CONTAINS[cd] %@", word)
                        let subjectPredicate = NSPredicate(format: "subject CONTAINS[cd] %@", word)
                        let yearPredicate = NSPredicate(format: "year CONTAINS[cd] %@", word)
                        let seasonPredicate = NSPredicate(format: "season CONTAINS[cd] %@", word)
                        
                        let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                            contentPredicate, filenamePredicate, examBoardPredicate, 
                            subjectPredicate, yearPredicate, seasonPredicate
                        ])
                        
                        predicates.append(orPredicate)
                    }
                    
                    // 所有词必须匹配（AND逻辑）
                    let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                    request.predicate = finalPredicate
                    
                    // 限制结果数量
                    request.fetchLimit = limit
                    
                    // 排序：优先显示文件名匹配的结果
                    request.sortDescriptors = [
                        NSSortDescriptor(keyPath: \CDPaper.fileName, ascending: true)
                    ]
                    
                    let papers = try self.context.fetch(request)
                    
                    let searchResults = papers.compactMap { paper -> SearchResult? in
                        guard let name = paper.fileName,
                              let url = paper.url else { return nil }
                        
                        // 生成摘要文本
                        let summaryText = self.generateSummaryText(for: paper, query: query)
                        
                        return SearchResult(
                            name: name,
                            text: summaryText,
                            url: url,
                            _formatted: FormattedResult(
                                name: name,
                                text: summaryText,
                                url: url
                            )
                        )
                    }
                    
                    continuation.resume(returning: searchResults)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func generateSummaryText(for paper: CDPaper, query: String) -> String {
        var components: [String] = []
        
        if let examBoard = paper.examBoard {
            components.append(examBoard)
        }
        
        if let subject = paper.subject, let subjectCode = paper.subjectCode {
            components.append("\(subject) (\(subjectCode))")
        } else if let subject = paper.subject {
            components.append(subject)
        }
        
        if let year = paper.year {
            components.append(year)
        }
        
        if let season = paper.season {
            components.append(season)
        }
        
        if let paperType = paper.paperType {
            components.append(paperType)
        }
        
        // 如果有内容匹配，添加内容片段
        if let content = paper.content, !content.isEmpty {
            let contentSnippet = extractContentSnippet(from: content, query: query)
            if !contentSnippet.isEmpty {
                components.append("...")
                components.append(contentSnippet)
                components.append("...")
            }
        }
        
        return components.joined(separator: " • ")
    }
    
    private func extractContentSnippet(from content: String, query: String) -> String {
        let queryWords = query.lowercased().components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
        
        for word in queryWords {
            if let range = content.lowercased().range(of: word) {
                let startIndex = max(content.startIndex, content.index(range.lowerBound, offsetBy: -30, limitedBy: content.startIndex) ?? content.startIndex)
                let endIndex = min(content.endIndex, content.index(range.upperBound, offsetBy: 30, limitedBy: content.endIndex) ?? content.endIndex)
                
                return String(content[startIndex..<endIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return ""
    }
}

// 用于数据导入的扩展
extension LocalSearchService {
    func importPaper(
        id: UUID = UUID(),
        name: String,
        url: String,
        content: String,
        examBoard: String,
        subject: String,
        subjectCode: String? = nil,
        year: String,
        season: String,
        paperType: String
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            context.perform {
                do {
                    // 检查是否已存在
                    let fetchRequest: NSFetchRequest<CDPaper> = CDPaper.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "url == %@", url)
                    
                    let existingPapers = try self.context.fetch(fetchRequest)
                    
                    if existingPapers.isEmpty {
                        let paper = CDPaper(context: self.context)
                        paper.id = id
                        paper.name = name
                        paper.fileName = URL(string: url)?.lastPathComponent ?? name
                        paper.url = url
                        paper.content = content
                        paper.examBoard = examBoard
                        paper.subject = subject
                        paper.subjectCode = subjectCode
                        paper.year = year
                        paper.season = season
                        paper.paperType = paperType
                        
                        try self.context.save()
                    }
                    
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getTotalPaperCount() async -> Int {
        return await withCheckedContinuation { continuation in
            context.perform {
                let request: NSFetchRequest<CDPaper> = CDPaper.fetchRequest()
                let count = (try? self.context.count(for: request)) ?? 0
                continuation.resume(returning: count)
            }
        }
    }
}