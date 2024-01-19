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
                
                NavigationLink(destination: EmptyView()) {
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

        
        Subject(title: "Further Mathematics", code: "(7366)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Further%20Mathematics%20(7366)"),
        Subject(title: "Further Mathematics", code: "(7367)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Further%20Mathematics%20(7367)"),
       
        Subject(title: "Mathematics", code: "(7356)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Mathematics%20(7356)"),
        Subject(title: "Mathematics", code: "(7357)", urlString: "http://18.143.226.69:8600/paperhub1/AQA/Alevel/Mathematics%20(7357)"),
        
        
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


