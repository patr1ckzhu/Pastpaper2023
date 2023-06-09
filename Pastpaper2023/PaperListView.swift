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

struct PaperView: View {
    var paper: Paper

    var body: some View {
        PDFKitView(url: URL(string: paper.url)!)
            .navigationBarTitle(Text(paper.fileName), displayMode: .inline)
            .onAppear {
                // 确保 PDF 文件在视图出现时立即加载
                print("PDF will appear.")
            }
    }
}
