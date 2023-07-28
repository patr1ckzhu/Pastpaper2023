//
//  ExamTypeListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct ExamTypeListView: View {
    var season: Season
    var order: [String] = ["Question Paper", "Mark Scheme", "Other File"]
    
    var examTypesOrdered: [ExamType] {
        season.examTypes.sorted { (a, b) -> Bool in
            if let firstIndex = order.firstIndex(of: a.id), let secondIndex = order.firstIndex(of: b.id) {
                return firstIndex < secondIndex
            }
            return a.id < b.id
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Select Exam Type")) {
                ForEach(examTypesOrdered, id: \.id) { examType in
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






