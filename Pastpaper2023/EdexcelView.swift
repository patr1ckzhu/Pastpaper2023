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
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8118/edx-ial-acc", navTitle: "Accounting")) {
                    Text("Accounting")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8120/edx-ial-biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8121/edx-ial-business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8122/edx-ial-chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8123/edx-ial-eco", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8124/edx-ial-geo", navTitle: "Geography")) {
                    Text("Geography")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8119/edx-ial-maths2", navTitle: "Mathematics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8083/edx-gcse-art", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8084/edx-gcse-business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8085/edx-gcse-eng", navTitle: "English Language")) {
                    Text("English Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8086/edx-gcse-history", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8087/edx-gcse-maths", navTitle: "Mathematics")) {
                    Text("Mathematics")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8088/edx-gcse-physics", navTitle: "Physics Education")) {
                    Text("Physics Education")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8089/edx-gcse-psychology", navTitle: "Psychology")) {
                    Text("Psychology")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8090/edx-gcse-statistics", navTitle: "Statistics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8091/edx-igcse-biology", navTitle: "Biology")) {
                    Text("Biology")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8092/edx-igcse-business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8093/edx-igcse-chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8094/edx-igcse-cs", navTitle: "Computer Science")) {
                    Text("Computer Science")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8095/edx-igcse-eco", navTitle: "Economics")) {
                    Text("Economics")
                }
                NavigationLink(destination: YearListView(urlString: "http://54.151.228.139:8096/edx-igcse-esl", navTitle: "English as Second Language")) {
                    Text("English as a Second Language")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8098/edx-igcse-history", navTitle: "History")) {
                    Text("History")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8099/edx-igcse-matha", navTitle: "Mathematics A")) {
                    Text("Mathematics A")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8100/edx-igcse-mathb", navTitle: "Mathematics B")) {
                    Text("Mathematics B")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8101/edx-igcse-physics", navTitle: "Physics")) {
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
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8102/edx-al-art", navTitle: "Art and Design")) {
                    Text("Art and Design")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8103/edx-al-biologya", navTitle: "Biology A")) {
                    Text("Biology A (Salters-Nuffield)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8104/edx-al-biologyb", navTitle: "Biology B")) {
                    Text("Biology B")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8105/edx-al-business", navTitle: "Business")) {
                    Text("Business")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8106/edx-al-chemistry", navTitle: "Chemistry")) {
                    Text("Chemistry")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8107/edx-al-chinese", navTitle: "Chinese")) {
                    Text("Chinese")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8108/edx-al-ecoa", navTitle: "Economics A")) {
                        Text("Economics A")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8109/edx-al-ecob", navTitle: "Economics B")) {
                        Text("Economics B")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8110/edx-al-eng", navTitle: "English Language")) {
                        Text("English Language")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8111/edx-al-geo", navTitle: "Geography")) {
                        Text("Geography")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8112/edx-al-history", navTitle: "History")) {
                        Text("History")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.140.169.240:8113/edx-al-maths", navTitle: "Mathematics")) {
                        Text("Mathematics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8114/edx-al-music", navTitle: "Music")) {
                        Text("Music")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8115/edx-al-physics", navTitle: "Physics")) {
                        Text("Physics")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8116/edx-al-psychology", navTitle: "Psychology")) {
                        Text("Psychology")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8117/edx-al-statistics", navTitle: "Statistics")) {
                        Text("Statistics")
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}

