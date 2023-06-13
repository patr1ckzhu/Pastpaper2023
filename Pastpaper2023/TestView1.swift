//
//  TestView1.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/12.
//

import SwiftUI

struct TestView1: View {
    @State private var papers: [Paper] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingSettingSheet = false
    @State private var selectedDisplayCount = ListDisplayCount.ten

        var displayCount: Int {
            switch selectedDisplayCount {
            case .ten:
                return 10
            case .twenty:
                return 20
            case .all:
                return papers.count
            }
        }

    var body: some View {
        
        NavigationView {
            Group {
                if isSearching {
                    List {
                        let searchKeywords = searchText.lowercased().split(separator: " ")
                        ForEach(papers.filter { paper in
                            searchKeywords.allSatisfy { keyword in
                                paper.name.lowercased().contains(keyword) ||
                                paper.season.lowercased().contains(keyword) ||
                                paper.type.lowercased().contains(keyword) ||
                                paper.year.lowercased().contains(keyword)
                            }
                        }.prefix(displayCount)) { paper in  //只显示前10个元素
                            // 显示单个试卷的 View
                            NavigationLink(destination: WebView(url: URL(string: paper.url)!)
                                .edgesIgnoringSafeArea(.all)
                                .navigationBarTitle(Text(paper.fileName), displayMode: .inline)) {
                                    Text(paper.name)
                                }
                        }
                    }
                } else {
                    List {
                        Section(header: Text("Qualifications").padding(.top, 18)) {
                            NavigationLink(destination: ALView()) {
                                HStack {
                                    Image(systemName: "a.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.green)
                                    Text("AS & A Levels")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: IALView()) {
                                    HStack {
                                        Image(systemName: "i.square.fill")
                                            .font(Font.system(.title))
                                            .foregroundColor(.indigo)
                                        Text("International AS & A Levels")
                                    }
                                    .offset(x: -8)
                                }

                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "i.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.blue)
                                    Text("International GCSE")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "i.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.yellow)
                                    Text("IBDP")
                                }
                                .offset(x: -8)
                            }

                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "o.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.purple)
                                    Text("O Level")
                                }
                                .offset(x: -8)
                            }
                        }
                        .headerProminence(.increased)
                        Section(header: Text("Examination Bureau")) {
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "c.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.brown)
                                    Text("CAIE")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "e.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.mint)
                                    Text("Edexcel")
                                }
                                .offset(x: -8)
                            }
                            NavigationLink(destination: Text("hello")) {
                                HStack {
                                    Image(systemName: "a.square.fill")
                                        .font(Font.system(.title))
                                        .foregroundColor(.red)
                                    Text("AQA")
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
                    .padding(.top, -18)
                }
            }
            .listStyle(.grouped)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle("Home", displayMode: .large)
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
            }
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction){
                    HStack {
                       
                        Button(action: {
                            let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                            impactLight.impactOccurred()
                        }) {
                            Image(systemName: "ellipsis.circle")
                        }
                        
                        
                        Button(action: {
                            showingSettingSheet.toggle()
                            let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                            impactLight.impactOccurred()
                        }) {
                            Image(systemName: "gearshape")
                        }
                        .sheet(isPresented: $showingSettingSheet) {
                            SettingView(selectedDisplayCount: $selectedDisplayCount)
                        }
                    }
                }
            })
        }
        .onAppear(perform: fetchPapers)
    }

    func fetchPapers() {
        guard let url = URL(string: "http://13.41.199.9:8081/edx-ial-maths") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                
                if let fetchedPapers = try? decoder.decode([Paper].self, from: data) {
                    DispatchQueue.main.async {
                        self.papers = fetchedPapers
                    }
                } else {
                    print("Invalid response from server")
                }
            }
        }
        
        task.resume()
    }
}

