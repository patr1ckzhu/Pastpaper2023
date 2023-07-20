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
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Art%20and%20Design", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/English%20Language", navTitle: "English Language")) {
                    Text("English Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/History", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Mathematics", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Physics%20Education", navTitle: "Physics Education")) {
                    Text("Physics Education")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Psychology", navTitle: "Psychology")) {
                    Text("Phychology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/GCSE/Statistics", navTitle: "Statistics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Computer%20Science", navTitle: "Computer Science")) {
                    Text("Computer Science")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Economics", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/English%20Second%20Language", navTitle: "English Second Language")) {
                    Text("English Second Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/History", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Maths%20A", navTitle: "Mathematics A")) {
                    Text("Mathematics A")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Maths%20B", navTitle: "Mathematics B")) {
                        Text("Mathematics B")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IGCSE/Physics", navTitle: "Physics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Art%20Design", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Biology%20A", navTitle: "Biology A (Salters-Nuffield)")) {
                    Text("Biology A (Salters-Nuffield)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Biology%20B", navTitle: "Biology B")) {
                    Text("Biology B")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Chinese", navTitle: "Chinese")) {
                    Text("Chinese")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Economics%20A", navTitle: "Economics A")) {
                    Text("Economics A")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Economics%20B", navTitle: "Economics B")) {
                    Text("Economics B")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/English%20Language", navTitle: "English Language")) {
                        Text("English Language")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Geography", navTitle: "Geography")) {
                        Text("Geography")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/History", navTitle: "History")) {
                        Text("History")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Mathematics", navTitle: "Mathematics")) {
                        Text("Mathematics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Music", navTitle: "Music")) {
                        Text("Music")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Physics", navTitle: "Physics")) {
                        Text("Physics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Psychology", navTitle: "Psychology")) {
                        Text("Psychology")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/Alevel/Statistics", navTitle: "Statistics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Accounting", navTitle: "Accounting")) {
                    Text("Accounting")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Economics", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Geography", navTitle: "Geography")) {
                    Text("Geography")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Mathematics", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Physics", navTitle: "Physics")) {
                    Text("Physics")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/Edexcel/IAL/Psychology", navTitle: "Psychology")) {
                        Text("Psychology")
                    }
                    
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International AS & A Levels", displayMode: .inline)
    }
}
