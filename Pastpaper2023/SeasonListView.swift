//
//  SeasonListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct SeasonListView: View {
    var year: Year

    var body: some View {
        List(year.seasons, id: \.id) { season in
            NavigationLink(destination: ExamTypeListView(season: season)) {
                Text(season.id)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Seasons", displayMode: .inline)
    }
}

