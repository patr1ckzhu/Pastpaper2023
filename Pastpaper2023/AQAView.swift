//
//  AQAView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct AQAView: View {
    var body: some View {
        List{
            Section(header: Text("All Qualification")) {
                
                NavigationLink(destination: AqaGCSEView()) {
                    HStack {
                        Text("GCSE")
                    }
                }
                NavigationLink(destination: AqaALView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("AQA", displayMode: .inline)
    }
}

struct AqaALView: View {
    let subjects: [Subject] = [
        Subject(title: "Accounting", code: "(7127)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Accounting%20(7127)"),
        Subject(title: "Biology", code: "(7401 7402)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Biology%20(7401%207402)"),
        Subject(title: "Business", code: "(7131 7132)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Business%20(7131%207132)"),
        Subject(title: "Chemistry", code: "(7404 7405)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Chemistry%20(7404%207405)"),
        Subject(title: "English Language", code: "(7701 7702)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/English%20Language%20(7701%207702)"),
        Subject(title: "Further Mathematics", code: "(7366)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Further%20Mathematics%20(7366)"),
        Subject(title: "Further Mathematics", code: "(7367)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Further%20Mathematics%20(7367)"),
        Subject(title: "Geography", code: "(7036)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Geography%20(7036)"),
        Subject(title: "Geography", code: "(7037)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Geography%20(7037)"),
        Subject(title: "History", code: "(7041)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/History%20(7041)"),
        Subject(title: "History", code: "(7042)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/History%20(7042)"),
        Subject(title: "Mathematics", code: "(7356)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Mathematics%20(7356)"),
        Subject(title: "Mathematics", code: "(7357)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Mathematics%20(7357)"),
        Subject(title: "Physics", code: "(7407 7408)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Physics%20(7407%207408)"),
        
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

struct AqaGCSEView: View {
    let subjects: [Subject] = [
        Subject(title: "Biology", code: "(8461)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Biology%20(8461)"),
        Subject(title: "Business", code: "(8132)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Business%20(8132)"),
        Subject(title: "Chemistry", code: "(8462)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Chemistry%20(8462)"),
        Subject(title: "Computer Science", code: "(8525)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Computer%20Science%20(8525)"),
        Subject(title: "Economics", code: "(8136)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Economics%20(8136)"),
        Subject(title: "English Language", code: "(8700)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/English%20Language%20(8700)"),
        Subject(title: "English Literature", code: "(8702)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/English%20Literature%20(8702)"),
        Subject(title: "Geography", code: "(8035)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Geography%20(8035)"),
        Subject(title: "History", code: "(8145)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/History%20(8145)"),
        Subject(title: "Mathematics", code: "(8300)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Mathematics%20(8300)"),
        Subject(title: "Physics", code: "(8463)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Physics%20(8463)"),
        Subject(title: "Psychology", code: "(8182)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Psychology%20(8182)"),
        Subject(title: "Statistics", code: "(8382)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/GCSE/Statistics%20(8382)"),
    ]
    var body: some View {
            List {
                Section(header: Text("Select Subject")) {
                    ForEach(subjects) { subject in  
                        NavigationLink(destination: YearListView(urlString: subject.urlString, navTitle: "\(subject.title) \(subject.code)")) {
                            Text("\(subject.title) \(subject.code)")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("GCSE", displayMode: .inline)
        }
}
