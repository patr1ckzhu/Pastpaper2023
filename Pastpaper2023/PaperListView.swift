//
//  PaperListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/9.
//

import SwiftUI

struct PaperListView: View {
    var examType: ExamType
    var papers: [Paper]

    var body: some View {
        List(papers) { paper in
            NavigationLink(destination: PaperView(paper: paper)) {
                Text(paper.fileName)
            }
        }
        .navigationBarTitle(examType.id, displayMode: .inline)
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
                let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                impactLight.impactOccurred()
            }) {
                Image(systemName: "square.and.arrow.up")
            })
            .sheet(isPresented: $showShareSheet) {
                if let fileURL = self.downloader.fileURL {
                    ActivityView(activityItems: [fileURL]) { _, _, _, _ in
                        self.showShareSheet = false
                        self.downloader.clearFileURL()
                    }
                }
            }

            .onChange(of: downloader.fileURL) { newValue in
                if newValue != nil {
                    self.showShareSheet = true
                }
            }
    }
}



