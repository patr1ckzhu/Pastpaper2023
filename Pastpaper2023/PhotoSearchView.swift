import SwiftUI
import VisionKit

struct PhotoSearchView: View {
    @StateObject private var photoSearchService = PhotoSearchService()
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingDocumentScanner = false
    @State private var showingActionSheet = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .camera
    @State private var scannedImages: [UIImage] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 主要拍照区域
                photoSectionView
                
                // OCR结果和搜索结果
                if photoSearchService.isProcessing {
                    processingView
                } else if !photoSearchService.recognizedText.isEmpty || !photoSearchService.searchResults.isEmpty {
                    resultsView
                } else {
                    instructionsView
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle("Photo Search") // 使用标准的navigationTitle
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    clearButton
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
                .ignoresSafeArea() // 忽略安全区域
                .background(Color.black) // 设置黑色背景
            }
            .fullScreenCover(isPresented: $showingDocumentScanner) {
                DocumentScannerView(recognizedImages: $scannedImages)
                    .edgesIgnoringSafeArea(.all) // 确保完全覆盖
            }
            .onChange(of: selectedImage) { _, newImage in
                if let image = newImage {
                    photoSearchService.recognizeText(from: image)
                }
            }
            .onChange(of: scannedImages) { _, images in
                if let firstImage = images.first {
                    selectedImage = firstImage
                    photoSearchService.recognizeText(from: firstImage)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // 强制使用Stack样式
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var photoSectionView: some View {
        VStack(spacing: 16) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("Take a photo or select from library")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            
            // 拍照按钮
            Button(action: {
                showingActionSheet = true
            }) {
                HStack {
                    Image(systemName: "camera.fill")
                    Text(selectedImage == nil ? "Take Photo" : "Take Another Photo")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var processingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text("Analyzing image...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var resultsView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 识别的文本
                if !photoSearchService.recognizedText.isEmpty {
                    recognizedTextView
                }
                
                // 搜索结果
                if !photoSearchService.searchResults.isEmpty {
                    searchResultsView
                } else if let errorMessage = photoSearchService.errorMessage {
                    errorView(errorMessage)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var recognizedTextView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recognized Text:")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(photoSearchService.recognizedText)
                .font(.body)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .textSelection(.enabled)
        }
    }
    
    @ViewBuilder
    private var searchResultsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Related Questions (\(photoSearchService.searchResults.count)):")
                .font(.headline)
                .foregroundColor(.primary)
            
            ForEach(photoSearchService.searchResults) { result in
                NavigationLink(destination:
                    WebView(url: URL(string: result.url)!)
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarTitle(Text(result._formatted.name), displayMode: .inline)
                ) {
                    searchResultRow(result)
                }
            }
        }
    }
    
    @ViewBuilder
    private func searchResultRow(_ result: SearchResult) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(result._formatted.text.replacingOccurrences(of: "\n", with: " "))
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Text(result._formatted.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
    
    @ViewBuilder
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            
            Text("Search Issue")
                .font(.headline)  // 修复了未终止的字符串
            
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var instructionsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.viewfinder")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            VStack(spacing: 12) {
                Text("How to Search by Photo:")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    instructionRow("1.", "Take a clear photo of the question")
                    instructionRow("2.", "Ensure good lighting and focus")
                    instructionRow("3.", "Wait for text recognition")
                    instructionRow("4.", "Browse matching questions")
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func instructionRow(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(number)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Text(text)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var clearButton: some View {
        if selectedImage != nil || !photoSearchService.searchResults.isEmpty {
            Button(action: {
                selectedImage = nil
                scannedImages = []
                photoSearchService.clearResults()
            }) {
                Image(systemName: "trash")
            }
        }
    }
}


