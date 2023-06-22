//
//  TestView1.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/12.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var searchService = SearchService()
    @State private var papers: [Paper] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingSettingSheet = false
    @State private var selectedDisplayCount = ListDisplayCount.ten
    @Binding var showFeedback: Bool
    
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
                        ForEach(searchService.results) { result in
                            NavigationLink(destination: WebView(url: URL(string: result.url)!).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(result._formatted.name), displayMode: .inline)) {
                                VStack(alignment: .leading) {
                                    Text(result._formatted.name)
                                    Text(result._formatted.text).font(.subheadline).foregroundColor(.gray)
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
                        //.padding(.top, -18)
                    }
                    //.padding(.top, -18)
                }
            }
            .listStyle(.grouped)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle("Home", displayMode: .large)
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
                if isSearching {
                    searchService.search(query: searchText, maxResults: displayCount)
                } else {
                    searchService.results = []
                }
            }
            
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction){
                    HStack {
                        
                        Button(action: {
                            if showFeedback {
                                let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                                impactLight.impactOccurred()
                            }
                        }) {
                            Image(systemName: "ellipsis.circle")
                        }
                        
                        
                        Button(action: {
                            showingSettingSheet.toggle()
                            if showFeedback {
                                let impactLight = UIImpactFeedbackGenerator(style: .rigid)
                                impactLight.impactOccurred()
                            }
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
    }
}


