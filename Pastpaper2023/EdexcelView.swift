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
                NavigationLink(destination: edx_gcseView()) {
                    HStack {
                        Text("GCSEs")
                    }
                }
                NavigationLink(destination: edx_igcseView()) {
                    HStack {
                        Text("International GCSEs")
                    }
                }
                
            }
            Section(header: Text("Pearson Edexcel A Levels")) {
                NavigationLink(destination: edx_alView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
                }
                NavigationLink(destination: edx_ialView()) {
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

struct edx_gcseView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Art%20and%20Design", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/English%20Language", navTitle: "English Language")) {
                    Text("English Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/History", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Mathematics", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Physics%20Education", navTitle: "Physics Education")) {
                    Text("Physics Education")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Psychology", navTitle: "Psychology")) {
                    Text("Phychology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8501/edx-gcse/subject/Statistics", navTitle: "Statistics")) {
                    Text("Statistics")
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("GCSEs", displayMode: .inline)
    }
}

struct edx_igcseView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Computer%20Science", navTitle: "Computer Science")) {
                    Text("Computer Science")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Economics", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/English%20Second%20Language", navTitle: "English Second Language")) {
                    Text("English Second Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/History", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Maths%20A", navTitle: "Mathematics A")) {
                    Text("Mathematics A")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Maths%20B", navTitle: "Mathematics B")) {
                        Text("Mathematics B")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8503/edx-igcse/subject/Physics", navTitle: "Physics")) {
                        Text("Physics")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International GCSEs", displayMode: .inline)
    }
}

struct edx_alView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Art%20Design", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Biology%20A", navTitle: "Biology A (Salters-Nuffield)")) {
                    Text("Biology A (Salters-Nuffield)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Biology%20B", navTitle: "Biology B")) {
                    Text("Biology B")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Chinese", navTitle: "Chinese")) {
                    Text("Chinese")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Economics%20A", navTitle: "Economics A")) {
                    Text("Economics A")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Economics%20B", navTitle: "Economics B")) {
                    Text("Economics B")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/English%20Language", navTitle: "English Language")) {
                        Text("English Language")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Geography", navTitle: "Geography")) {
                        Text("Geography")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/History", navTitle: "History")) {
                        Text("History")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Mathematics", navTitle: "Mathematics")) {
                        Text("Mathematics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Music", navTitle: "Music")) {
                        Text("Music")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Physics", navTitle: "Physics")) {
                        Text("Physics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Psychology", navTitle: "Psychology")) {
                        Text("Psychology")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8500/edx-al/subject/Statistics", navTitle: "Statistics")) {
                        Text("Statistics")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}

struct edx_ialView: View {
    var body: some View {
        List{
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Accounting", navTitle: "Accounting")) {
                    Text("Accounting")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Economics", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Geography", navTitle: "Geography")) {
                    Text("Geography")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Mathematics", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Physics", navTitle: "Physics")) {
                    Text("Physics")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8502/edx-ial/subject/Psychology", navTitle: "Psychology")) {
                        Text("Psychology")
                    }
                    
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International AS & A Levels", displayMode: .inline)
    }
}
