//
//  YearListView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/8.
//

import SwiftUI

struct YearListView: View {
    @State var years: [String] = []
    
    var body: some View {
            List(years, id: \.self) { year in
                NavigationLink(destination: Text("Details for \(year)")) {
                    Text(year)
                }
            }
            .onAppear(perform: loadYears)
            .listStyle(.plain)
            .navigationBarTitle("Years", displayMode: .inline)
        }
    
    func loadYears() {
        guard let url = URL(string: "http://localhost:3000/pastpapers/years") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([String].self, from: data) {
                    DispatchQueue.main.async {
                        self.years = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


struct YearListView_Previews: PreviewProvider {
    static var previews: some View {
        YearListView()
    }
}
