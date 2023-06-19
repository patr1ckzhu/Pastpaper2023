//
//  YearListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct YearListView: View {
    var subject: Subject
    
    var body: some View {
        List {
            Section(header: Text("Select Exam Year")) {
                ForEach(subject.years, id: \.id) { year in
                    NavigationLink(destination: SeasonListView(year: year)) {
                        Text(year.id)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle(subject.subject, displayMode: .inline)
    }
}



