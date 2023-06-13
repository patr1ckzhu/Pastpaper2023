//
//  ExamTypeListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct ExamTypeListView: View {
    var season: Season

    var body: some View {
        List {
            Section(header: Text("Select Exam Type")) {
                ForEach(season.examTypes, id: \.id) { examType in
                    NavigationLink(destination: PaperListView(examType: examType, papers: examType.papers)) {
                        Text(examType.id)
                    }
                }
            }
        }
        .navigationBarTitle(season.season, displayMode: .inline)
        .listStyle(.plain)
    }
}





