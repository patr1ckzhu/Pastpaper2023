//
//  Modifier.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/9.
//

import Foundation
import WebKit
import SwiftUI
import SafariServices

class WebviewController: UIViewController {
    
    lazy var webview: WKWebView = WKWebView()
    lazy var progressbar: UIProgressView = UIProgressView()
    var preferredFrameRateRange = CAFrameRateRange(minimum:120, maximum:120, preferred:120)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webview.frame = self.view.frame
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.webview.allowsBackForwardNavigationGestures = true
        self.view.addSubview(self.webview)

        self.view.addSubview(self.progressbar)
        self.progressbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
        self.progressbar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.progressbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.progressbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
        self.webview.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
        
//        NSLayoutConstraint.activate([
//            progressbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        ])

        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressbar.alpha = 0.0
                }, completion: { finished in
                    self.progressbar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressbar.isHidden = false
                self.progressbar.alpha = 1.0
                progressbar.setProgress(Float(self.webview.estimatedProgress), animated: true)
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> WebviewController {
        let webviewController = WebviewController()

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)

        return webviewController
    }

    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)
    }
}

class RemoteURLDownloader: ObservableObject {
    @Published var fileURL: URL?
    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func download(url: URL) {
        self.session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  error == nil
            else {
                print("Download error: \(String(describing: error))")
                return
            }

            let pathComponent = url.lastPathComponent
            let tempDirectoryURL = FileManager.default.temporaryDirectory
            let targetURL = tempDirectoryURL.appendingPathComponent("\(pathComponent).pdf")

            do {
                try data.write(to: targetURL, options: .atomicWrite)
                DispatchQueue.main.async {
                    self.fileURL = targetURL
                }
            } catch {
                print("File Error: \(error)")
            }
        }.resume()
    }
    func clearFileURL() {
        DispatchQueue.main.async {
            self.fileURL = nil
        }
    }

}



struct ActivityView: UIViewControllerRepresentable {
    typealias CompletionWithItemsHandler = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]?
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    var completion: CompletionWithItemsHandler?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = completion
        return controller
    }

    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // no-op
    }
}

struct DisclosureIndicator: View {
    
    @ScaledMetric private var size: CGFloat = 13.5
    
    var body: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(Color(.tertiaryLabel))
            .font(.system(size: size, weight: .semibold))
    }
}

enum ListDisplayCount: String, CaseIterable, Identifiable {
    case ten = "10"
    case twenty = "20"
    case all = "All"
    
    var id: String { self.rawValue }
}
