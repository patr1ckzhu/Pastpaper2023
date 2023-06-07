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
    
    func moveQuali(from source: IndexSet, to destination: Int) {
      qualiList.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveExam(from source: IndexSet, to destination: Int) {
      examList.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveContest(from source: IndexSet, to destination: Int) {
      contestList.move(fromOffsets: source, toOffset: destination)
    }
    
    @State private var editMode: EditMode = .inactive
    @State private var showingAlert = false
    @State private var showingSettingSheet = false
    @State private var showingInfoSheet = false
    
    @State var qualiList = [
      Quali(image: "i.square.fill", name: "AS & A Level", color: .green),
      Quali(image: "a.square.fill", name: "International AS & A Level", color: .indigo),
      Quali(image: "i.square.fill", name: "International GCSE", color: .blue),
      Quali(image: "o.square.fill", name: "IBDP", color: .yellow),
      Quali(image: "i.square.fill", name: "O Level", color: .purple),
    ]
    
    @State var examList = [
      Exam(image: "c.square.fill", name: "CAIE", color: .brown),
      Exam(image: "e.square.fill", name: "Edexcel", color: .mint),
      Exam(image: "a.square.fill", name: "AQA", color: .red),
      ]
    
    @State var contestList = [
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
                Section(header: Text("Qualification").padding(.top, 17).padding(.leading, -10)) {
                    ForEach(qualiList.filter { quali in
                        searchText.isEmpty || quali.name.localizedStandardContains(searchText)
                    }, id: \.name) { quali in
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
                    .onMove(perform: moveQuali)
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)
                
                Section(header: Text("Examination Bureau").padding(.leading, -10)) {
                    ForEach(examList.filter { exam in
                        searchText.isEmpty || exam.name.localizedStandardContains(searchText)
                    }, id: \.name) { exam in
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
                    .onMove(perform: moveExam)
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)

                Section(header: Text("Admission Tests").padding(.leading, -10)) {
                    ForEach(contestList.filter { contest in
                        searchText.isEmpty || contest.name.localizedStandardContains(searchText)
                    }, id: \.name) { contest in
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
                    .onMove(perform: moveContest)
                }
                .listSectionSeparator(.visible)
                .headerProminence(.increased)

            }
            .environment(\.editMode, $editMode)
            .listStyle(.insetGrouped)
            .navigationBarTitle("Pastpaper", displayMode: .large)
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
                          withAnimation {
                            if editMode == .inactive {
                              editMode = .active
                            } else {
                              editMode = .inactive
                            }
                          }
                        } label: {
                          Text(editMode == .inactive ? "Edit" : "Done")
                        }

                    }
                }
            })
            .padding(.top, -18)
        }
        
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
