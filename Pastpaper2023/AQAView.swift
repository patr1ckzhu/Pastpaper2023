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
                NavigationLink(destination: EmptyView()) {
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

struct AQAView_Previews: PreviewProvider {
    static var previews: some View {
        AQAView()
    }
}
