//
//  IALView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/9.
//

import SwiftUI

struct IALView: View {
   
    var body: some View {
         List {
                Section(header: Text("Edexcel")) {
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
                .headerProminence(.increased)
                
                Section(header: Text("AQA")) {
                    
                    NavigationLink(destination: Text("quali")) {
                        Text("Biology")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Chemistry")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Physics")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Psychology")
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Subjects", displayMode: .inline)
    }
}

struct IALView_Previews: PreviewProvider {
    static var previews: some View {
        IALView()
    }
}
