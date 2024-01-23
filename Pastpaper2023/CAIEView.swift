//
//  CAIEView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct CAIEView: View {
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section(header: Text("Cambridge Upper Secondary")) {
                NavigationLink(destination: CaieIGCSEView()) {
                    HStack {
                        Text("IGCSE")
                    }
                }
                NavigationLink(destination: CaieOLView()) {
                    HStack {
                        Text("O Level")
                    }
                }
            }
            
            Section(header: Text("Cambridge Advanced")) {
                NavigationLink(destination: CaieALView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
                Button(action: {
                    self.showingAlert = true
                }) {
                    HStack {
                        Text("Pre-U")
                            .foregroundColor(Color("Color2"))
                        Spacer()
                        DisclosureIndicator()
                    }
                    .alert("Still under development 🚴", isPresented: $showingAlert) {
                        
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("CAIE", displayMode: .inline)
    }
}

struct CaieIGCSEView: View {
    let subjects: [Subject] = [
        Subject(title: "Accounting", code: "(0452)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Accounting"),
        Subject(title: "Biology", code: "(0610)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Biology"),
        Subject(title: "Business Studies", code: "(0450)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Business%20Studies"),
        Subject(title: "Chemistry", code: "(0620)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Chemistry"),
        Subject(title: "Computer Science", code: "(0478)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Computer%20Science"),
        Subject(title: "Drama", code: "(0411)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Drama"),
        Subject(title: "Economics", code: "(0455)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Economics"),
        Subject(title: "English First Language", code: "(0500)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/English%20First%20Language"),
        Subject(title: "History", code: "(0470)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/History"),
        Subject(title: "Mathematics", code: "(0580)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/IGCSE/Mathematics"),
    ]

    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.title) { subject in
                    NavigationLink(destination: YearListView(urlString: subject.urlString, navTitle: "\(subject.title) \(subject.code)")) {
                        Text("\(subject.title) \(subject.code)")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("IGCSE", displayMode: .inline)
    }
}

struct CaieOLView: View {
    let subjects: [Subject] = [
        Subject(title: "Accounting", code: "(7707)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Accounting"),
        Subject(title: "Biology", code: "(5090)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Biology"),
        Subject(title: "Chemistry", code: "(5070)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Chemistry"),
        Subject(title: "Computer Science", code: "(2210)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Computer%20Science"),
        Subject(title: "Economics", code: "(2281)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Economics"),
        Subject(title: "English Language", code: "(1123)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/English%20Language"),
        Subject(title: "Geography", code: "(2217)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Geography"),
        Subject(title: "Mathematics D", code: "(4024)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Mathematics%20D"),
        Subject(title: "Physics", code: "(5054)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Physics"),
    ]

    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.title) { subject in
                    NavigationLink(destination: YearListView(urlString: subject.urlString, navTitle: "\(subject.title) \(subject.code)")) {
                        Text("\(subject.title) \(subject.code)")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("O Level", displayMode: .inline)
    }
}

struct CaieALView: View {
    let subjects: [Subject] = [
        Subject(title: "Accounting", code: "(9706)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Accounting"),
        Subject(title: "Art and Design", code: "(9479)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Art%20&%20Design"),
        Subject(title: "Biology", code: "(9700)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Biology"),
        Subject(title: "Business", code: "(9609)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Business"),
        Subject(title: "Chemistry", code: "(9701)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Chemistry"),
        Subject(title: "Chinese", code: "(9715)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Chinese"),
        Subject(title: "Computer Science", code: "(9608)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Computer%20Science%20(9608)"),
        Subject(title: "Computer Science", code: "(9618)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Computer%20Science%20(9618)"),
        Subject(title: "Economics", code: "(9708)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Economics"),
        Subject(title: "Further Mathematics", code: "(9231)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Mathematics%20Further"),
        Subject(title: "Geography", code: "(9696)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Geography"),
        Subject(title: "History", code: "(9389)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/History%20(9389)"),
        Subject(title: "History", code: "(9489)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/History%20(9489)"),
        Subject(title: "Mathematics", code: "(9709)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Mathematics%20(9709)"),
        Subject(title: "Physics", code: "(9702)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Physics"),
        Subject(title: "Psychology", code: "(9990)", urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Psychology")
        
    ]

    var body: some View {
            List {
                Section(header: Text("Select Subject")) {
                    ForEach(subjects) { subject in  // 使用 id 而不是 title
                        NavigationLink(destination: YearListView(urlString: subject.urlString, navTitle: "\(subject.title) \(subject.code)")) {
                            Text("\(subject.title) \(subject.code)")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("AS & A Levels", displayMode: .inline)
        }
}

