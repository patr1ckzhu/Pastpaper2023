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
                NavigationLink(destination: EmptyView()) {
                    Text("Art and Design")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Business")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("English Language")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("History")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Mathematics")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Physics Education")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Phychology")
                }
                NavigationLink(destination: EmptyView()) {
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
                NavigationLink(destination: EmptyView()) {
                    Text("Biology")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Business")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Chemistry")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Computer Science")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Economics")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("English Second Language")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("History")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Mathematics A")
                }
                Group {
                    NavigationLink(destination: EmptyView()) {
                        Text("Mathematics B")
                    }
                    NavigationLink(destination: EmptyView()) {
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
                NavigationLink(destination: EmptyView()) {
                    Text("Art and Design")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Biology A (Salters-Nuffield)")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Biology B")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Business")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Chemistry")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Chinese")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Economics A")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Economics B")
                }
                Group {
                    NavigationLink(destination: EmptyView()) {
                        Text("English Language")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Geography")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("History")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Mathematics")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Music")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Physics")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Psychology")
                    }
                    NavigationLink(destination: EmptyView()) {
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
                NavigationLink(destination: EmptyView()) {
                    Text("Accounting")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Biology")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Business")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Chemistry")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Economics")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Geography")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Mathematics")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Physics")
                }
                Group {
                    NavigationLink(destination: EmptyView()) {
                        Text("Psychology")
                    }
                    
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("International AS & A Levels", displayMode: .inline)
    }
}
