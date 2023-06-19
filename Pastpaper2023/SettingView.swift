//
//  SettingView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/7.
//

import SwiftUI
import WebKit
import Foundation

struct SettingView: View {
    @AppStorage("Theme") var theme: Theme = .systemDefault
    @State private var showFeedback = true
    @State private var showingAlert = false
    @Binding var selectedDisplayCount: ListDisplayCount
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("PREFERENCE")) {
                        NavigationLink(destination: AppearanceView().preferredColorScheme(theme.colorScheme)) {
                            Text("Appearance")
                        }
                        Picker("Search Result Count", selection: $selectedDisplayCount) {
                                ForEach(ListDisplayCount.allCases) { count in
                                    Text(count.rawValue).tag(count)
                                }
                            }
                        Toggle("Taptic Engine Feedback", isOn: $showFeedback)

                    }
                    
                    Section(header: Text("MISC")) {
                        Button("Clear Cached Data") {
                            self.showingAlert = true
                            
                            deleteCache()
                        }.alert("All cache being removed", isPresented: $showingAlert) {
                            
                        }
                        
                        NavigationLink(destination: EmptyView()) {
                            Text("Rate PaperHub")
                        }
                        NavigationLink(destination: EmptyView()) {
                            Text("Share with Friends")
                        }
                        NavigationLink(destination: EmptyView()) {
                            Text("About PaperHub")
                        }
                    }
                    Section(header: Text("FEEDBACK")) {
                        NavigationLink(destination: EmptyView()) {
                            Text("Email")
                        }
                        NavigationLink(destination: EmptyView()) {
                            Text("Twitter")
                        }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                
                Text("Version 0.0.5(114)\n © 2023 Patrick Zhu")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 5)
                    .font(.footnote)
            }
            .background(Color("Color3"))
            
        }
    }
    private func deleteCache(){
        if #available(iOS 9.0, *) {
            let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
            let date = NSDate(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
        } else {
            var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
            libraryPath += "/Cookies"
            
            do {
                try FileManager.default.removeItem(atPath: libraryPath)
            } catch {
                print("error")
            }
            URLCache.shared.removeAllCachedResponses()
        }
    }
}



