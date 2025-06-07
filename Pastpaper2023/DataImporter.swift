import Foundation
import CoreData

class DataImporter: ObservableObject {
    @Published var importProgress: Double = 0.0
    @Published var isImporting = false
    @Published var importStatus = "Ready to import"
    @Published var errorMessage: String?
    
    private let searchService: LocalSearchService
    
    init(searchService: LocalSearchService = LocalSearchService()) {
        self.searchService = searchService
    }
    
    // 从你的现有MeiliSearch数据导入
    @MainActor
    func importFromMeiliSearch() async {
        isImporting = true
        importProgress = 0.0
        importStatus = "Connecting to MeiliSearch..."
        errorMessage = nil
        
        guard let url = URL(string: "http://13.250.155.79:7700/indexes/PaperHub1/documents?limit=10000") else {
            errorMessage = "Invalid MeiliSearch URL"
            isImporting = false
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.setValue("Bearer 4B2Pw9qXqviIO_442NlJs-bcZ90U72o6RwTnCEa5Uvg", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(MeiliSearchResponse.self, from: data)
            
            let totalDocuments = response.results.count
            importStatus = "Found \(totalDocuments) documents. Starting import..."
            
            for (index, document) in response.results.enumerated() {
                await importDocument(document)
                
                importProgress = Double(index + 1) / Double(totalDocuments)
                importStatus = "Imported \(index + 1)/\(totalDocuments) documents"
                
                // 每100个文档保存一次，提高性能
                if (index + 1) % 100 == 0 {
                    CoreDataStack.shared.save()
                }
            }
            
            // 最终保存
            CoreDataStack.shared.save()
            
            importStatus = "Import completed successfully!"
            isImporting = false
            
        } catch {
            errorMessage = "Import failed: \(error.localizedDescription)"
            importStatus = "Import failed"
            isImporting = false
        }
    }
    
    private func importDocument(_ document: MeiliSearchDocument) async {
        do {
            // 从文件名解析信息
            let parsedInfo = parseFileName(document.name)
            
            try await searchService.importPaper(
                id: UUID(),
                name: document.name,
                url: document.url,
                content: document.text ?? "",
                examBoard: parsedInfo.examBoard,
                subject: parsedInfo.subject,
                subjectCode: parsedInfo.subjectCode,
                year: parsedInfo.year,
                season: parsedInfo.season,
                paperType: parsedInfo.paperType
            )
        } catch {
            print("Failed to import document \(document.name): \(error)")
        }
    }
    
    // 解析文件名以提取结构化信息
    private func parseFileName(_ fileName: String) -> (examBoard: String, subject: String, subjectCode: String?, year: String, season: String, paperType: String) {
        let components = fileName.components(separatedBy: "/")
        
        var examBoard = "Unknown"
        var subject = "Unknown"
        var subjectCode: String? = nil
        var year = "Unknown"
        var season = "Unknown"
        var paperType = "Unknown"
        
        // 从路径解析考试局
        if components.count > 0 {
            examBoard = components[0]
        }
        
        // 解析科目（通常在文件名中包含括号中的科目代码）
        let nameComponent = components.last ?? fileName
        
        // 提取年份（4位数字）
        let yearRegex = try! NSRegularExpression(pattern: "\\b(20\\d{2})\\b")
        if let yearMatch = yearRegex.firstMatch(in: nameComponent, range: NSRange(nameComponent.startIndex..., in: nameComponent)) {
            year = String(nameComponent[Range(yearMatch.range, in: nameComponent)!])
        }
        
        // 提取季节
        if nameComponent.lowercased().contains("summer") || nameComponent.lowercased().contains("may") || nameComponent.lowercased().contains("jun") {
            season = "Summer"
        } else if nameComponent.lowercased().contains("winter") || nameComponent.lowercased().contains("oct") || nameComponent.lowercased().contains("nov") {
            season = "Winter"
        } else if nameComponent.lowercased().contains("march") || nameComponent.lowercased().contains("mar") {
            season = "March"
        }
        
        // 提取试卷类型
        if nameComponent.lowercased().contains("question") || nameComponent.lowercased().contains("qp") {
            paperType = "Question Paper"
        } else if nameComponent.lowercased().contains("mark") || nameComponent.lowercased().contains("ms") {
            paperType = "Mark Scheme"
        } else if nameComponent.lowercased().contains("examiner") {
            paperType = "Examiner Report"
        } else {
            paperType = "Other File"
        }
        
        // 提取科目代码（括号中的数字）
        let codeRegex = try! NSRegularExpression(pattern: "\\((\\d{4})\\)")
        if let codeMatch = codeRegex.firstMatch(in: nameComponent, range: NSRange(nameComponent.startIndex..., in: nameComponent)) {
            subjectCode = String(nameComponent[Range(codeMatch.range(at: 1), in: nameComponent)!])
        }
        
        // 从路径解析科目名
        if components.count >= 3 {
            subject = components[2].replacingOccurrences(of: "%20", with: " ")
        }
        
        return (examBoard, subject, subjectCode, year, season, paperType)
    }
}

// MeiliSearch响应模型
struct MeiliSearchResponse: Codable {
    let results: [MeiliSearchDocument]
}

struct MeiliSearchDocument: Codable {
    let id: String
    let name: String
    let url: String
    let text: String?
}