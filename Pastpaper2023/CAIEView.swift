//
//  CAIEView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct CAIEView: View {
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section(header: Text("Cambridge Upper Secondary")) {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("International GCSE")
                    }
                }
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("O Level")
                    }
                }
                
            }
            
            Section(header: Text("Cambridge Advanced")) {
                NavigationLink(destination: SubjectListView(urlString: "http://18.143.226.69:8401/caie-al", navTitle: "AS & A Levels")) {
                    HStack {
                        Text("AS & A Levels")
                    }
                    //.offset(x: -8)
                }
                Button(action: {
                    self.showingAlert = true
                }) {
                    HStack {
                        Text("Pre-U")
                            .foregroundColor(Color("Color2"))
                        Spacer()
                        DisclosureIndicator()
                    }
                    .alert("Still under development 🚴", isPresented: $showingAlert) {
                        
                    }
                    
                }
                
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("CAIE", displayMode: .inline)
    }
}


