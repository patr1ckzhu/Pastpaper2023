//
//  EdexcelView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct EdexcelView: View {
    var body: some View {
        List{       
            Section(header: Text("Pearson Edexcel GCSEs")) {
                NavigationLink(destination: EdxGCSEView()) {
                    HStack {
                        Text("GCSEs")
                    }
                }
                NavigationLink(destination: EdxIGCSEView()) {
                    HStack {
                        Text("International GCSEs")
                    }
                }
                
            }
            Section(header: Text("Pearson Edexcel A Levels")) {
                NavigationLink(destination: EdxALView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
                NavigationLink(destination: EdxIALView()) {
                    HStack {
                        Text("International AS & A Levels")
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("Edexcel", displayMode: .inline)
    }
}

struct EdxGCSEView: View {
    let subjects = [
        ("Art and Design", "Art%20and%20Design"),
        ("Business", "Business"),
        ("English Language", "English%20Language"),
        ("History", "History"),
        ("Mathematics", "Mathematics"),
        ("Physics Education", "Physics%20Education"),
        ("Psychology", "Psychology"),
        ("Statistics", "Statistics")
    ]
    
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.0) { subject in
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/\(subject.1)", navTitle: subject.0)) {
                        Text(subject.0)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("GCSEs", displayMode: .inline)
    }
}

struct EdxIGCSEView: View {
    let subjects = [
        ("Biology", "Biology"),
        ("Business", "Business"),
        ("Chemistry", "Chemistry"),
        ("Computer Science", "Computer%20Science"),
        ("Economics", "Economics"),
        ("English Second Language", "English%20Second%20Language"),
        ("History", "History"),
        ("Mathematics A", "Maths%20A"),
        ("Mathematics B", "Maths%20B"),
        ("Physics", "Physics")
    ]
    
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.0) { subject in
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/\(subject.1)", navTitle: subject.0)) {
                        Text(subject.0)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International GCSEs", displayMode: .inline)
    }
}

// 第一个视图
struct EdxALView: View {
    let subjects = [
        ("Art and Design", "Art%20Design"),
        ("Biology A (Salters-Nuffield)", "Biology%20A"),
        ("Biology B", "Biology%20B"),
        ("Business", "Business"),
        ("Chemistry", "Chemistry"),
        ("Chinese", "Chinese"),
        ("Economics A", "Economics%20A"),
        ("Economics B", "Economics%20B"),
        ("English Language", "English%20Language"),
        ("Geography", "Geography"),
        ("History", "History"),
        ("Mathematics", "Mathematics"),
        ("Music", "Music"),
        ("Physics", "Physics"),
        ("Psychology", "Psychology"),
        ("Statistics", "Statistics")
    ]

    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.0) { subject in
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/\(subject.1)", navTitle: subject.0)) {
                        Text(subject.0)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}

struct EdxIALView: View {
    let subjects = [
        ("Accounting", "Accounting"),
        ("Biology", "Biology"),
        ("Business", "Business"),
        ("Chemistry", "Chemistry"),
        ("Economics", "Economics"),
        ("Geography", "Geography"),
        ("Mathematics", "Mathematics"),
        ("Physics", "Physics"),
        ("Psychology", "Psychology")
    ]

    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                ForEach(subjects, id: \.0) { subject in
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/\(subject.1)", navTitle: subject.0)) {
                        Text(subject.0)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International AS & A Levels", displayMode: .inline)
    }
}

