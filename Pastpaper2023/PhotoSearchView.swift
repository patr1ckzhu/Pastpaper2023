import SwiftUI
import Vision
import VisionKit
import UIKit

// MARK: - PhotoSearchView
struct PhotoSearchView: View {
    @StateObject private var photoSearchService = PhotoSearchService()
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingDocumentScanner = false
    @State private var showingActionSheet = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .camera
    @State private var scannedImages: [UIImage] = []
    @State private var showRecognizedText = false
    @State private var showImagePreview = false  // 新增：控制图片预览的显示
    @AppStorage("SelectedDisplayCount") private var selectedDisplayCount = ListDisplayCount.three
    
    // 计算属性来获取显示数量
    private var displayCount: Int {
        switch selectedDisplayCount {
        case .three:
            return 3
        case .five:
            return 5
        case .eight:
            return 8
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 主要内容区域
            if photoSearchService.isProcessing {
                processingView
            } else if selectedImage != nil {
                resultsView
            } else {
                emptyStateView
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Photo Search")
        .navigationBarTitleDisplayMode(selectedImage != nil ? .inline : .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if selectedImage != nil {
                    Button(action: clearAll) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Select Image Source"),
                buttons: [
                    .default(Text("Camera")) {
                        imagePickerSourceType = .camera
                        showingImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        imagePickerSourceType = .photoLibrary
                        showingImagePicker = true
                    },
                    .default(Text("Document Scanner")) {
                        showingDocumentScanner = true
                    },
                    .cancel()
                ]
            )
        }
        .fullScreenCover(isPresented: $showingImagePicker) {
            ImagePicker(
                selectedImage: $selectedImage,
                isPresented: $showingImagePicker,
                sourceType: imagePickerSourceType
            )
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showingDocumentScanner) {
            DocumentScannerView(recognizedImages: $scannedImages)
                .ignoresSafeArea()
        }
        .onChange(of: selectedImage) { _, newImage in
            if let image = newImage {
                photoSearchService.recognizeText(from: image, maxResults: displayCount)
                showRecognizedText = false  // 默认折叠
                showImagePreview = false    // 默认折叠
            }
        }
        .onChange(of: scannedImages) { _, images in
            if let firstImage = images.first {
                selectedImage = firstImage
                photoSearchService.recognizeText(from: firstImage, maxResults: displayCount)
                showRecognizedText = false  // 默认折叠
                showImagePreview = false    // 默认折叠
            }
        }
    }
    
    // MARK: - Empty State View
    @ViewBuilder
    private var emptyStateView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // 图标和说明
            VStack(spacing: 20) {
                Image(systemName: "doc.text.viewfinder")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .symbolRenderingMode(.hierarchical)
                
                VStack(spacing: 8) {
                    Text("Snap & Search")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Take a photo of any question to find similar problems")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            // 主操作按钮
            Button(action: { showingActionSheet = true }) {
                Label("Take Photo", systemImage: "camera.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
    }
    
    // MARK: - Processing View
    @ViewBuilder
    private var processingView: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 30) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                }
                
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.2)
                    
                    Text("Analyzing image...")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
    }
    
    // MARK: - Results View
    @ViewBuilder
    private var resultsView: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 图片预览卡片（可折叠）
                if let image = selectedImage {
                    collapsibleImagePreviewCard(image)
                }
                
                // 识别的文本（可折叠）
                if !photoSearchService.displayText.isEmpty {
                    recognizedTextCard
                }
                
                // 搜索结果或错误信息
                if !photoSearchService.searchResults.isEmpty {
                    searchResultsSection
                } else if let error = photoSearchService.errorMessage {
                    errorCard(error)
                }
                
                // 底部操作按钮
                takeAnotherPhotoButton
                    .padding(.top, 10)
            }
            .padding()
        }
    }
    
    // MARK: - Components
    @ViewBuilder
    private func collapsibleImagePreviewCard(_ image: UIImage) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: { showImagePreview.toggle() }) {
                HStack {
                    Text("Captured Image")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: showImagePreview ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if showImagePreview {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 0.5)
                    )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, y: 1)
    }
    
    @ViewBuilder
    private var recognizedTextCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: { showRecognizedText.toggle() }) {
                HStack {
                    Text("Recognized Text")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: showRecognizedText ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if showRecognizedText {
                Text(photoSearchService.displayText)
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .textSelection(.enabled)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, y: 1)
    }
    
    @ViewBuilder
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Related Questions")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("(\(photoSearchService.searchResults.count))")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            ForEach(photoSearchService.searchResults) { result in
                NavigationLink(destination:
                    WebView(url: URL(string: result.url)!)
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarTitle(Text(result._formatted.name), displayMode: .inline)
                ) {
                    searchResultCard(result)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    @ViewBuilder
    private func searchResultCard(_ result: SearchResult) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(result._formatted.text.replacingOccurrences(of: "\n", with: " "))
                    .font(.callout)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 4) {
                    Image(systemName: "doc.text")
                        .font(.caption2)
                    Text(result._formatted.name)
                        .font(.caption)
                        .lineLimit(1)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 3, y: 1)
    }
    
    @ViewBuilder
    private func errorCard(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.circle")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .symbolRenderingMode(.hierarchical)
            
            Text("No Results Found")
                .font(.headline)
            
            Text(message)
                .font(.callout)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, y: 1)
    }
    
    @ViewBuilder
    private var takeAnotherPhotoButton: some View {
        Button(action: { showingActionSheet = true }) {
            Label("Take Another Photo", systemImage: "camera.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    // MARK: - Actions
    private func clearAll() {
        withAnimation {
            selectedImage = nil
            scannedImages = []
            photoSearchService.clearResults()
            showRecognizedText = false
            showImagePreview = false
        }
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
        
        // 根据源类型设置不同的展示模式
        if sourceType == .camera {
            picker.modalPresentationStyle = .fullScreen
            picker.modalPresentationCapturesStatusBarAppearance = true
            picker.cameraViewTransform = CGAffineTransform.identity
            picker.view.backgroundColor = .black
            picker.showsCameraControls = true
        } else {
            // 照片库使用默认的模态展示
            picker.modalPresentationStyle = .automatic
        }
        
        picker.allowsEditing = false
        
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

