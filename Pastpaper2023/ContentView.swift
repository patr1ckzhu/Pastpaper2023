//
//  ContentView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/7.
//

import SwiftUI

struct Quali {
  let image: String
  let name: String
  let color: Color
}

struct Exam {
  let image: String
  let name: String
  let color: Color
}

struct Contest {
  let image: String
  let name: String
  let color: Color
}

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var showingSettingSheet = false
    @State private var showingInfoSheet = false
    
    var qualiList = [
      Quali(image: "i.square.fill", name: "IGCSE", color: .blue),
      Quali(image: "a.square.fill", name: "Advanced Level", color: .purple),
      Quali(image: "i.square.fill", name: "International Advanced Level", color: .indigo),
      Quali(image: "o.square.fill", name: "OLevel", color: .purple),
      Quali(image: "i.square.fill", name: "IBDP", color: .yellow),
    ]
    
    var examList = [
      Exam(image: "c.square.fill", name: "CAIE", color: .brown),
      Exam(image: "e.square.fill", name: "Edexcel", color: .mint),
      Exam(image: "a.square.fill", name: "AQA", color: .red),
      ]
    
    var contestList = [
      Contest(image: "c.square.fill", name: "Oxford admissions", color: .gray),
      Contest(image: "e.square.fill", name: "Cambridge admissions", color: .orange),
      Contest(image: "a.square.fill", name: "MAA AMC", color: .cyan),
      Contest(image: "a.square.fill", name: "UKMT", color: .black),
        ]
    
    let qualifications = ["IGCSE", "Advanced Level", "International Advanced Level", "OLevel", "IBDP"]
    let bureaus = ["CAIE", "Edexcel", "AQA"]
    let extraTests = ["Oxford admissions", "Cambridge admissions", "MAA AMC", "UKMT"]
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Qualification")) {
                    ForEach(qualiList, id: \.name) { quali in
                        NavigationLink(destination: Text("test")) {
                            HStack {
                                Image(systemName: quali.image)
                                    .font(Font.system(.title))
                                    .foregroundColor(quali.color)
                                Text(quali.name)
                                
                            }
                            .offset(x: -12)
                        }
                    }
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)
                
                Section(header: Text("Examination Bureau")) {
                    ForEach(examList, id: \.name) { exam in
                        NavigationLink(destination: Text("quali")) {
                            HStack {
                                Image(systemName: exam.image)
                                     .font(Font.system(.title))
                                     .foregroundColor(exam.color)
                                Text(exam.name)
                               
                              }
                            .offset(x: -12)
                        }
                        
                    }
                    
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)
                Section(header: Text("Contest/Extra Tests")) {
                    ForEach(contestList, id: \.name) { contest in
                        NavigationLink(destination: Text("quali")) {
                            HStack {
                                Image(systemName: contest.image)
                                     .font(Font.system(.title))
                                     .foregroundColor(contest.color)
                                Text(contest.name)
                               
                              }
                            .offset(x: -12)
                        }
                        
                    }
                    
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)
            }
            //.listRowInsets(EdgeInsets())
            //.padding(.vertical, -10)
            .listStyle(.insetGrouped)
            .navigationBarTitle("Pastpaper", displayMode: .large)
            //.navigationBarHidden(false)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
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
                            SettingView()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    HStack {
                        Button {
                            
                        }label: {
                            Text("Edit")
                       }
                    }
                }
            })
            .padding(.top, -18)
            
        }
        
        
    }
    
    var searchResults1: [String] {
        if searchText.isEmpty {
            return qualifications
        } else {
            return qualifications.filter {
                $0.localizedCaseInsensitiveContains(searchText)}
            
        }
    }

    var searchResults2: [String] {
        if searchText.isEmpty {
            return bureaus
        } else {
            return bureaus.filter { $0.localizedCaseInsensitiveContains(searchText)}
            
        }
    }
    
    var searchResults3: [String] {
        if searchText.isEmpty {
            return extraTests
        } else {
            return extraTests.filter { $0.localizedCaseInsensitiveContains(searchText.lowercased()) }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
