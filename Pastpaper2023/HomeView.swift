//
//  TestView1.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/12.
//

import SwiftUI
import PDFKit

struct HomeView: View {
    @ObservedObject var searchService = SearchService()
    @State private var papers: [Paper] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingSettingSheet = false
    @State private var selectedDisplayCount = ListDisplayCount.five
    @Binding var showFeedback: Bool
    @State private var selectedOption: MenuOption? = nil
    
    var displayCount: Int {
        switch selectedDisplayCount {
        case .three:
            return 3
        case .five:
            return 5
        case .ten:
            return 10
        }
    }
    
    var body: some View {
        
        NavigationView {
            Group {
                if isSearching {
                    List {
                        ForEach(searchService.results, id: \.id) { result in
                            if let url = URL(string: result.url) {
                                NavigationLink(destination: WebView(url: url).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(result._formatted.name), displayMode: .inline)) {
                                    HStack {
                                        // Display the PDF thumbnail
                                        PDFThumbnailView(url: url)

                                        // Display the search result text
                                        VStack(alignment: .leading) {
                                            Text("WEC11_01_msc_20210304")
                                                .fontWeight(.semibold)
                                            Text(result._formatted.text.replacingOccurrences(of: "\n", with: "\\n"))
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                else {
                    List {
                        Section(header: Text("Exam Boards").padding(.top, 5)) {
                            NavigationLink(destination: CAIEView()) {
                                HStack {
                                    Image(systemName: "c.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.brown)
                                    Text("CAIE")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: EdexcelView()) {
                                HStack {
                                    Image(systemName: "e.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.mint)
                                    Text("Edexcel")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: AQAView()) {
                                HStack {
                                    Image(systemName: "a.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.red)
                                    Text("AQA")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: EmptyView()) {
                                HStack {
                                    Image(systemName: "o.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.yellow)
                                    Text("OCR")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: EmptyView()) {
                                HStack {
                                    Image(systemName: "i.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.blue)
                                    Text("IBDP")
                                }
                                .offset(x: -8)
                            }
                        }
                        .listSectionSeparator(.visible)
                        .headerProminence(.increased)
                        
                        Section(header: Text("Admissions Tests")) {
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "c.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.orange)
                                    Text("Cambridge admissions")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "o.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.gray)
                                    Text("Oxford admissions")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "m.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.cyan)
                                    Text("MAA AMC")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "u.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(Color("Color2"))
                                    Text("UKMT")
                                }
                                .offset(x: -8)
                            }
                        }
                        .listSectionSeparator(.visible)
                        .headerProminence(.increased)
                    }
                }
            }
            .listStyle(.grouped)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Paper Name, Question...")
            .navigationBarTitle("Home", displayMode: .large)
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    isSearching = false
                    searchService.results = []
                }
            }
            .onSubmit(of: .search) {
                isSearching = true
                searchService.search(query: searchText, maxResults: displayCount)
            }
            
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction){
                    HStack(spacing: -3) {
                        Menu {
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    
                                }
                            }) {
                                Label("Help", systemImage: "questionmark.circle")
                            }
                            
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    
                                }
                            }) {
                                Label("Paper Request", systemImage: "arrowshape.turn.up.forward")
                            }
                            
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    
                                }
                            }) {
                                Label("About PaperHub", systemImage: "info.circle")
                            }
                            
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                        .onTapGesture {
                            if showFeedback {
                                let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                                impactLight.impactOccurred()
                            }
                        }
                        
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                showingSettingSheet.toggle()
                                if showFeedback {
                                    let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                                    impactLight.impactOccurred()
                                }
                            }
                        }) {
                            Image(systemName: "gearshape")
                        }
                        .padding(.leading)
                        .sheet(isPresented: $showingSettingSheet) {
                            SettingView(selectedDisplayCount: $selectedDisplayCount)
                        }
                    }
                }
            })

            CAIEView()
        }
    }
}

enum MenuOption {
    case help, about
}

func thumbnailFromPDF(url: URL) -> UIImage? {
    guard let pdfDocument = PDFDocument(url: url) else { return nil }
    guard let pdfPage = pdfDocument.page(at: 0) else { return nil }

    let pdfPageBounds = pdfPage.bounds(for: .mediaBox)
    let scale = UIScreen.main.scale
    let pageSize = pdfPageBounds.size
    let scaledPageSize = CGSize(width: pageSize.width * scale, height: pageSize.height * scale)
    let renderer = UIGraphicsImageRenderer(size: scaledPageSize)

    let image = renderer.image { (context) in
        UIColor.white.set()
        context.fill(CGRect(origin: .zero, size: scaledPageSize))

        context.cgContext.translateBy(x: 0.0, y: scaledPageSize.height)
        context.cgContext.scaleBy(x: scale, y: -scale)

        pdfPage.draw(with: .mediaBox, to: context.cgContext)
    }

    return image
}

struct PDFThumbnailView: View {
    @StateObject private var loader = PDFThumbnailLoader()
    let url: URL

    var body: some View {
        Group {
            if let image = loader.thumbnail {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 86)  // 设定图片大小
                    .clipShape(RoundedRectangle(cornerRadius: 12))  // 设置圆角
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(UIColor.systemGray3), lineWidth: 1.35))
            } else {
                // Show a placeholder while the PDF thumbnail is loading
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemGray5))
                    .frame(width: 72, height: 86)
            }
        }
        .onAppear {
            loader.loadThumbnail(from: url)
        }
    }
}



class PDFThumbnailLoader: ObservableObject {
    @Published var thumbnail: UIImage?
    
    func loadThumbnail(from url: URL) {
        DispatchQueue.global(qos: .background).async {
            let thumbnail = thumbnailFromPDF(url: url)
            DispatchQueue.main.async {
                self.thumbnail = thumbnail
            }
        }
    }
}
