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
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("GCSEs")
                    }
                }
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("International GCSEs")
                    }
                }
                
            }
            Section(header: Text("Pearson Edexcel A Levels")) {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
                NavigationLink(destination: EmptyView()) {
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

struct EdexcelView_Previews: PreviewProvider {
    static var previews: some View {
        EdexcelView()
    }
}
