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
                NavigationLink(destination: EdexcelIALView()) {
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

struct EdexcelIALView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: Text("quali")) {
                    Text("Business")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView()) {
                    Text("Mathematics")
                }
                
                NavigationLink(destination: Text("quali")) {
                    Text("Physics")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Psychology")
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("International AS & A Levels", displayMode: .inline)
    }
}

struct EdexcelView_Previews: PreviewProvider {
    static var previews: some View {
        EdexcelView()
    }
}
