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
    
    @ViewBuilder
    var searchResultsView: some View {
        if searchService.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage = searchService.errorMessage {
            searchErrorView(errorMessage)
        } else if searchService.results.isEmpty {
            emptySearchView
        } else {
            searchResultsList
        }
    }
    
    @ViewBuilder
    func searchErrorView(_ errorMessage: String) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Text("Search Error")
                .font(.headline)
            Text(errorMessage)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var emptySearchView: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("No Results")
                .font(.headline)
            Text("Try a different search term")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var searchResultsList: some View {
        List {
            ForEach(searchService.results) { result in
                if let url = URL(string: result.url) {
                    NavigationLink(destination: WebView(url: url).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(result._formatted.name), displayMode: .inline)) {
                        searchResultRow(result)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func searchResultRow(_ result: SearchResult) -> some View {
        VStack(alignment: .leading) {
            Text(result._formatted.text.replacingOccurrences(of: "\n", with: "\u{00A0}"))
                .foregroundColor(Color.secondary)
                .padding(.bottom, 1)
            Text(result._formatted.name)
                .font(.subheadline)
        }
    }
    
    @ViewBuilder
    var mainMenuList: some View {
        List {
            examBoardsSection
            admissionsTestsSection
        }
    }
    
    @ViewBuilder
    var examBoardsSection: some View {
        Section(header: Text("Exam Boards").padding(.top, 5)) {
            examBoardLink("CAIE", icon: "c.square.fill", color: .brown, destination: CAIEView())
            examBoardLink("Edexcel", icon: "e.square.fill", color: .mint, destination: EdexcelView())
            examBoardLink("AQA", icon: "a.square.fill", color: .red, destination: AQAView())
            examBoardLink("OCR", icon: "o.square.fill", color: .yellow, destination: EmptyView())
        }
        .listSectionSeparator(.visible)
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    var admissionsTestsSection: some View {
        Section(header: Text("Admissions Tests")) {
            examBoardLink("Cambridge admissions", icon: "c.square.fill", color: .orange, destination: Text("hello"))
            examBoardLink("Oxford admissions", icon: "o.square.fill", color: .gray, destination: Text("hello"))
            examBoardLink("MAA AMC", icon: "m.square.fill", color: .cyan, destination: Text("hello"))
            examBoardLink("UKMT", icon: "u.square.fill", color: Color("Color2"), destination: Text("hello"))
        }
        .listSectionSeparator(.visible)
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    func examBoardLink<Destination: View>(_ title: String, icon: String, color: Color, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .font(Font.system(.title))
                    .foregroundColor(color)
                Text(title)
            }
            .offset(x: -8)
        }
    }
    
    @ViewBuilder
    var toolbarContent: some View {
        HStack(spacing: -3) {
            menuButton
            settingsButton
        }
    }
    
    @ViewBuilder
    var menuButton: some View {
        Menu {
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    // TODO: Implement help functionality
                }
            }) {
                Label("Help", systemImage: "questionmark.circle")
            }
            
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    // TODO: Implement paper request functionality
                }
            }) {
                Label("Paper Request", systemImage: "arrowshape.turn.up.forward")
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
    }
    
    @ViewBuilder
    var settingsButton: some View {
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
    
    var body: some View {
        
        NavigationStack {
            Group {
                if isSearching {
                    searchResultsView
                }

                else {
                    mainMenuList
                }
            }
            .listStyle(.grouped)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Questions, File name...")
            .navigationTitle("Home")
            .onChange(of: searchText) { _, newValue in
                if newValue.isEmpty {
                    isSearching = false
                    searchService.results = []
                }
            }
            .onSubmit(of: .search) {
                isSearching = true
                Task {
                    await searchService.search(query: searchText, maxResults: displayCount)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    toolbarContent
                }
            }
        }
    }
}

enum MenuOption {
    case help, about
}
