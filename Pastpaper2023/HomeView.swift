//
//  HomeView.swift
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
    @State private var selectedDisplayCount = ListDisplayCount.three
    @Binding var showFeedback: Bool
    @State private var selectedOption: MenuOption? = nil
    
    var displayCount: Int {
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
        
        NavigationView {
            Group {
                if isSearching {
                    List {
                        ForEach(searchService.results) { result in
                            if let url = URL(string: result.url) {
                                NavigationLink(destination: WebView(url: url).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(result._formatted.name), displayMode: .inline)) {
                                    VStack(alignment: .leading) {
                                        Text(result._formatted.text.replacingOccurrences(of: "\n", with: "\u{00A0}"))
                                            .foregroundColor(Color.secondary)
                                            .padding(.bottom, 1)
                                        Text(result._formatted.name)
                                            .font(.subheadline)
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
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Questions, File name...")
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
