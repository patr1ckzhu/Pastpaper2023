//
//  PaperListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/9.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFKit.PDFView, context: Context) {
        pdfView.document = PDFKit.PDFDocument(url: self.url)
    }
}

struct PaperListView: View {
    var papers: [Paper]

    var body: some View {
        List(papers) { paper in
            NavigationLink(destination: PaperView(paper: paper)) {
                Text(paper.fileName)
            }
        }
        .navigationBarTitle("Papers", displayMode: .inline)
        .listStyle(.plain)
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {

    }
}

struct PaperView: View {
    @StateObject private var downloader = RemoteURLDownloader()
    @State private var showShareSheet = false
    var paper: Paper

    var body: some View {
        WebView(url: URL(string: paper.url)!)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text(paper.fileName), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.downloader.download(url: URL(string: paper.url)!)
            }) {
                Image(systemName: "square.and.arrow.up")
            })
            .sheet(isPresented: $showShareSheet) {
                if let fileURL = self.downloader.fileURL {
                    ActivityView(activityItems: [fileURL])
                }
            }
            .onChange(of: downloader.fileURL) { newValue in
                if newValue != nil {
                    self.showShareSheet = true
                }
            }
    }
}



