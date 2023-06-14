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
                NavigationLink(destination: EdexcelGCSEView()) {
                    HStack {
                        Text("GCSEs")
                    }
                }
                NavigationLink(destination: EdexcelIGCSEView()) {
                    HStack {
                        Text("International GCSEs")
                    }
                }
                
            }
            Section(header: Text("Pearson Edexcel A Levels")) {
                NavigationLink(destination: EdexcelALView()) {
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
                NavigationLink(destination: Text("quali")) {
                    Text("Geography")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8081/edx-ial-maths", navTitle: "Mathematics")) {
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

struct EdexcelGCSEView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8083/edx-gcse-art", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8084/edx-gcse-business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8085/edx-gcse-eng", navTitle: "English Language")) {
                    Text("English Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8086/edx-gcse-history", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8087/edx-gcse-maths", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8088/edx-gcse-physics", navTitle: "Physics Education")) {
                    Text("Physics Education")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8089/edx-gcse-psychology", navTitle: "Psychology")) {
                    Text("Psychology")
                }
                NavigationLink(destination: YearListView(urlString: "http://13.41.199.9:8090/edx-gcse-statistics", navTitle: "Statistics")) {
                    Text("Statistics")
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("GCSEs", displayMode: .inline)
    }
}

struct EdexcelIGCSEView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: Text("quali")) {
                    Text("Biology")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Computer Science")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Economics")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("History")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Mathematics A")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Mathematics B")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Physics")
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("International GCSEs", displayMode: .inline)
    }
}

struct EdexcelALView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: Text("quali")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Biology")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Business")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chinese")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Computer Science")
                }
                Group {
                    NavigationLink(destination: Text("quali")) {
                        Text("Economics")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("English Language")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("History")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Mathematics")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Physics")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Psychology")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Statistics")
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}

