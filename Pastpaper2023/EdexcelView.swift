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
                NavigationLink(destination: SubjectListView(urlString: "http://18.143.226.69:8200/edx-gcse", navTitle: "GCSEs")) {
                    HStack {
                        Text("GCSEs")
                    }
                }
                NavigationLink(destination: SubjectListView(urlString: "http://18.143.226.69:8302/edx-igcse", navTitle: "International GCSEs")) {
                    HStack {
                        Text("International GCSEs")
                    }
                }
                
            }
            Section(header: Text("Pearson Edexcel A Levels")) {
                NavigationLink(destination: SubjectListView(urlString: "http://18.143.226.69:8301/edx-al", navTitle: "AS & A Levels")) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
                NavigationLink(destination: SubjectListView(urlString: "http://18.143.226.69:8300/edx-ial", navTitle: "International AS & A Levels")) {
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


