import SwiftUI
import Vision
import VisionKit
import UIKit

class PhotoSearchService: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isProcessing = false
    @Published var searchResults: [SearchResult] = []
    @Published var errorMessage: String?
    
    private let searchService = SearchService()
    
    // OCR文字识别
    func recognizeText(from image: UIImage) {
        isProcessing = true
        errorMessage = nil
        recognizedText = ""
        
        guard let cgImage = image.cgImage else {
            errorMessage = "Invalid image"
            isProcessing = false
            return
        }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            DispatchQueue.main.async {
                self?.processOCRResults(request: request, error: error)
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
    
    private func processOCRResults(request: VNRequest, error: Error?) {
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
        recognizedText = fullText
        
        // 预处理文本并搜索
        if !fullText.isEmpty {
            searchWithRecognizedText(fullText)
        } else {
            errorMessage = "No text recognized from image"
            isProcessing = false
        }
    }
    
    private func searchWithRecognizedText(_ text: String) {
        let processedQuery = preprocessSearchQuery(text)
        
        Task {
            await searchService.search(query: processedQuery, maxResults: 10)
            
            DispatchQueue.main.async {
                self.searchResults = self.searchService.results
                self.isProcessing = false
                
                if self.searchResults.isEmpty {
                    self.errorMessage = "No matching questions found"
                }
            }
        }
    }
    
    // 智能文本预处理
    private func preprocessSearchQuery(_ text: String) -> String {
        var processedText = text
        
        // 1. 移除版权标记和干扰文字
        let copyrightPatterns = [
            "© UCLES",
            "©UCLES",
            "UCLES",
            "Cambridge International Examinations",
            "Cambridge Assessment International Education",
            "Page \\d+",
            "Turn over",
            "\\[Turn over\\]",
            "\\d{4}/\\d{2}",  // 年份/试卷代码格式
            "Question \\d+",   // 题号格式
        ]
        
        for pattern in copyrightPatterns {
            processedText = processedText.replacingOccurrences(of: pattern, with: "", options: [.regularExpression, .caseInsensitive])
        }
        
        // 2. 清理常见的OCR错误（简化版本）
        let ocrCorrections = [
            ("@", "a"), // 特殊字符误识别
            ("#", ""), // 移除井号
            ("$", "S"), // 美元符号误识别
        ]
        
        for (wrong, correct) in ocrCorrections {
            processedText = processedText.replacingOccurrences(of: wrong, with: correct)
        }
        
        // 3. 移除常见的干扰词
        let stopWords = ["the", "a", "an", "and", "or", "but", "in", "on", "at", "to", "for", "of", "with", "by"]
        let words = processedText.lowercased().components(separatedBy: .whitespacesAndNewlines)
        let filteredWords = words.filter { word in
            !stopWords.contains(word) && word.count > 1
        }
        
        // 4. 重新组合关键词
        let keyWords = filteredWords.prefix(10) // 限制关键词数量
        processedText = Array(keyWords).joined(separator: " ")
        
        return processedText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func clearResults() {
        recognizedText = ""
        searchResults = []
        errorMessage = nil
    }
}

// MARK: - 文档扫描支持
struct DocumentScannerView: UIViewControllerRepresentable {
    @Binding var recognizedImages: [UIImage]
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = context.coordinator
        
        // 设置状态栏样式
        scanner.modalPresentationStyle = .fullScreen
        scanner.modalPresentationCapturesStatusBarAppearance = true
        
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let parent: DocumentScannerView
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var images: [UIImage] = []
            
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                images.append(image)
            }
            
            parent.recognizedImages = images
            parent.dismiss()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            parent.dismiss()
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.dismiss()
        }
    }
}

// MARK: - 图片选择器
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        // 设置全屏显示，避免安全区域问题
        picker.modalPresentationStyle = .fullScreen
        picker.modalPresentationCapturesStatusBarAppearance = true
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}
