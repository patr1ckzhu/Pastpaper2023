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
                NavigationLink(destination: CaieIGCSEView()) {
                    HStack {
                        Text("International GCSE")
                    }
                }
                NavigationLink(destination: CaieOLView()) {
                    HStack {
                        Text("O Level")
                    }
                }
            }
            
            Section(header: Text("Cambridge Advanced")) {
                NavigationLink(destination: CaieALView()) {
                    HStack {
                        Text("AS & A Levels")
                    }
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

struct CaieIGCSEView: View {
    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: Text("quali")) {
                    Text("Biology (0610)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chemistry (0620)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Computer Science (0478)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Economics (0455)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("English Second Language (0511)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("English First Language (0500)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Mathematics (0580)")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Additional Mathematics (0606)")
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("IGCSE", displayMode: .inline)
    }
}

struct CaieOLView: View {
    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Accounting", navTitle: "Accounting (7707)")) {
                     Text("Accounting (7707)")
                 }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Biology", navTitle: "Biology (5090)")) {
                    Text("Biology (5090)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Chemistry", navTitle: "Chemistry (5070)")) {
                    Text("Chemistry (5070)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Computer%20Science", navTitle: "Computer Science (2210)")) {
                    Text("Computer Science (2210)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Economics", navTitle: "Economics (2281)")) {
                    Text("Economics (2281)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/English%20Language", navTitle: "English Language (1123)")) {
                    Text("English Language (1123)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Geography", navTitle: "Geography (2217)")) {
                    Text("Geography (2217)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Mathematics%20D", navTitle: "Mathematics D (4024)")) {
                    Text("Mathematics D (4024)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Olevel/Physics", navTitle: "Physics (5054)")) {
                    Text("Physics (5054)")
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("O Level", displayMode: .inline)
    }
}

struct CaieALView: View {
    var body: some View {
        List {
            Section(header: Text("Select Subject")) {
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Accounting", navTitle: "Accounting (9706)")) {
                     Text("Accounting (9706)")
                 }
               NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Art%20&%20Design", navTitle: "Art and Design (9479)")) {
                    Text("Art and Design (9479)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Biology", navTitle: "Biology")) {
                    Text("Biology (9700)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Business", navTitle: "Business (9609)")) {
                    Text("Business (9609)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Chemistry", navTitle: "Chemistry (9701)")) {
                    Text("Chemistry (9701)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Chinese", navTitle: "Chinese (9715)")) {
                    Text("Chinese (9715)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Computer%20Science%20(9608)", navTitle: "Computer Science (9608)")) {
                    Text("Computer Science (9608)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Computer%20Science%20(9618)", navTitle: "Computer Science (9618)")) {
                    Text("Computer Science (9618)")
                }
                NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Economics", navTitle: "Economics (9708)")) {
                    Text("Economics (9708)")
                }
                Group {
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Mathematics%20Further", navTitle: "Mathematics Further (9231)")) {
                        Text("Further Mathematics (9231)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Geography", navTitle: "Geography")) {
                        Text("Geography (9696)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/History%20(9389)", navTitle: "History")) {
                        Text("History (9389)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/History%20(9489)", navTitle: "History")) {
                        Text("History (9489)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Mathematics%20(9709)", navTitle: "Mathematics")) {
                        Text("Mathematics (9709)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Physics", navTitle: "Physics (9702)")) {
                        Text("Physics (9702)")
                    }
                    NavigationLink(destination: YearListView(urlString: "http://18.143.226.69:8600/paperhub1/CAIE/Alevel/Psychology", navTitle: "Psychology (9990)")) {
                        Text("Psychology (9990)")
                    }
                }
                
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}
