import SwiftUI
import Vision
import VisionKit
import UIKit

class PhotoSearchService: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var displayText: String = ""  // 新增：用于显示处理后的文本
    @Published var isProcessing = false
    @Published var searchResults: [SearchResult] = []
    @Published var errorMessage: String?
    
    private let searchService = SearchService()
    
    // OCR文字识别
    func recognizeText(from image: UIImage, maxResults: Int = 10) {
        isProcessing = true
        errorMessage = nil
        recognizedText = ""
        displayText = ""
        
        guard let cgImage = image.cgImage else {
            errorMessage = "Invalid image"
            isProcessing = false
            return
        }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            DispatchQueue.main.async {
                self?.processOCRResults(request: request, error: error, maxResults: maxResults)
            }
        }
        
        // 配置OCR参数
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en-US"]
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "OCR failed: \(error.localizedDescription)"
                    self.isProcessing = false
                }
            }
        }
    }
    
    private func processOCRResults(request: VNRequest, error: Error?, maxResults: Int) {
        if let error = error {
            errorMessage = "OCR error: \(error.localizedDescription)"
            isProcessing = false
            return
        }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            errorMessage = "No text found in image"
            isProcessing = false
            return
        }
        
        var recognizedStrings: [String] = []
        
        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { continue }
            recognizedStrings.append(topCandidate.string)
        }
        
        let fullText = recognizedStrings.joined(separator: " ")
        recognizedText = fullText  // 保存原始文本
        
        // 清理文本用于显示
        displayText = cleanTextForDisplay(fullText)
        
        // 预处理文本并搜索
        if !fullText.isEmpty {
            searchWithRecognizedText(fullText, maxResults: maxResults)
        } else {
            errorMessage = "No text recognized from image"
            isProcessing = false
        }
    }
    
    // 清理文本用于显示（移除干扰信息）
    private func cleanTextForDisplay(_ text: String) -> String {
        var cleanedText = text
        
        // 移除版权标记和干扰文字
        let patternsToRemove = [
            "© UCLES.*?\\[Turn over",  // 移除整个版权行
            "©UCLES.*?\\[Turn over",
            "© UCLES \\d{4}.*?\\]",
            "©UCLES \\d{4}.*?\\]",
            "\\[Turn over\\]",
            "Turn over",
            "\\d{4}/\\d{2}/[A-Z]/[A-Z]/\\d{2}",  // 试卷代码
            "Page \\d+"
        ]
        
        for pattern in patternsToRemove {
            cleanedText = cleanedText.replacingOccurrences(
                of: pattern,
                with: "",
                options: [.regularExpression, .caseInsensitive]
            )
        }
        
        // 清理多余的空格和换行
        cleanedText = cleanedText
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleanedText
    }
    
    private func searchWithRecognizedText(_ text: String, maxResults: Int) {
        let processedQuery = preprocessSearchQuery(text)
        
        Task {
            await searchService.search(query: processedQuery, maxResults: maxResults)
            
            DispatchQueue.main.async {
                self.searchResults = self.searchService.results
                self.isProcessing = false
                
                if self.searchResults.isEmpty {
                    self.errorMessage = "No matching questions found"
                }
            }
        }
    }
    
    // 智能文本预处理（用于搜索）
    private func preprocessSearchQuery(_ text: String) -> String {
        var processedText = text
        
        // 1. 移除版权标记和干扰文字
        let copyrightPatterns = [
            "© UCLES.*?\\[Turn over",
            "©UCLES.*?\\[Turn over",
            "© UCLES",
            "©UCLES",
            "UCLES",
            "Cambridge International Examinations",
            "Cambridge Assessment International Education",
            "Page \\d+",
            "Turn over",
            "\\[Turn over\\]",
            "\\d{4}/\\d{2}/[A-Z]/[A-Z]/\\d{2}",  // 完整的试卷代码格式
            "\\d{4}/\\d{2}",  // 年份/试卷代码格式
            "Question \\d+",   // 题号格式
        ]
        
        for pattern in copyrightPatterns {
            processedText = processedText.replacingOccurrences(
                of: pattern,
                with: "",
                options: [.regularExpression, .caseInsensitive]
            )
        }
        
        // 2. 清理常见的OCR错误
        let ocrCorrections = [
            ("@", "a"),
            ("#", ""),
            ("$", "S"),
        ]
        
        for (wrong, correct) in ocrCorrections {
            processedText = processedText.replacingOccurrences(of: wrong, with: correct)
        }
        
        // 3. 提取关键词
        let words = processedText.lowercased().components(separatedBy: .whitespacesAndNewlines)
        
        // 移除常见停用词
        let stopWords = Set(["the", "a", "an", "and", "or", "but", "in", "on", "at", "to", "for", "of", "with", "by", "is", "are", "was", "were", "will", "you", "your"])
        
        // 保留有意义的关键词
        let keywords = words.filter { word in
            !stopWords.contains(word) &&
            word.count > 2 &&
            !word.contains(where: { $0.isNumber && $0.isPunctuation })
        }
        
        // 4. 重新组合关键词（限制数量以提高搜索精度）
        let finalKeywords = Array(keywords.prefix(8))
        processedText = finalKeywords.joined(separator: " ")
        
        return processedText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func clearResults() {
        recognizedText = ""
        displayText = ""
        searchResults = []
        errorMessage = nil
    }
}
