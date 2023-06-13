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
            //.headerProminence(.increased)
            
            Section(header: Text("Cambridge Advanced")) {
                NavigationLink(destination: CaieALView()) {
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
            //.headerProminence(.increased)
        }
        .listStyle(.grouped)
        .navigationBarTitle("CAIE", displayMode: .inline)
    }
}

struct CaieIGCSEView: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("quali")) {
                TitleLabel("Biology", subtitle: "0610")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Chemistry (0620)")
                TitleLabel("Chemistry", subtitle: "0620")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Computer Science (0478)")
                TitleLabel("Computer Science", subtitle: "0478")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Economics (0455)")
                TitleLabel("Economics", subtitle: "0455")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("English as Second Language (0511)")
                TitleLabel("English as Second Language", subtitle: "0511")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("English as First Language (0500)")
                TitleLabel("English as First Language", subtitle: "0500")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Mathematics (0580)")
                TitleLabel("Mathematics", subtitle: "0580")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Additional Mathematics (0606)")
                TitleLabel("Additional Mathematics", subtitle: "0606")
            }
            
            //.headerProminence(.increased)
            
            
        }
        .listStyle(.grouped)
        .navigationBarTitle("IGCSE", displayMode: .inline)
    }
}

struct CaieOLView: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("quali")) {
                //Text("Biology (5090)")
                TitleLabel("Biology", subtitle: "5090")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Chemistry (5070)")
                TitleLabel("Chemistry", subtitle: "5070")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Computer Science (2210)")
                TitleLabel("Computer Science", subtitle: "2210")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Economics (2281)")
                TitleLabel("Economics", subtitle: "2281")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("English Language (1123)")
                TitleLabel("English Language", subtitle: "1123")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Geography (2217)")
                TitleLabel("Geography", subtitle: "2217")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Mathematics D (4024)")
                TitleLabel("Mathematics D", subtitle: "4024")
            }
            NavigationLink(destination: Text("quali")) {
                //Text("Physcis (5054)")
                TitleLabel("Physcis", subtitle: "5054")
            }
            
            //.headerProminence(.increased)
        }
        .listStyle(.grouped)
        .navigationBarTitle("O Level", displayMode: .inline)
    }
}

struct CaieALView: View {
    var body: some View {
        List {
            Section(header: Text("CAIE")) {
               NavigationLink(destination: Text("quali")) {
                    Text("Art & Design (9479)")
                    //TitleLabel("Art & Design", subtitle: "9479")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Biology (9700)")
                    //TitleLabel("Biology", subtitle: "9700")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Business (9609)")
                    //TitleLabel("Business", subtitle: "9609")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chemistry (9701)")
                    //TitleLabel("Chemistry", subtitle: "9701")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Chinese (9715)")
                    //TitleLabel("Chinese", subtitle: "9715")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Computer Science (9608)")
                    //TitleLabel("Computer Science", subtitle: "9608")
                }
                NavigationLink(destination: Text("quali")) {
                    Text("Economics (9708)")
                    //TitleLabel("Economics", subtitle: "9708")
                }
                Group {
                    NavigationLink(destination: Text("quali")) {
                        Text("Further Mathematics (9231)")
                        //TitleLabel("Further Mathematics", subtitle: "9231")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Geography (9696)")
                        //TitleLabel("Geography", subtitle: "9696")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("History (9389)")
                        //TitleLabel("History", subtitle: "9389")
                    }
                    NavigationLink(destination: YearListView1()) {
                        Text("Mathematics (9709)")
                        //TitleLabel("Mathematics", subtitle: "9709")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Physics (9702)")
                        //TitleLabel("Physics", subtitle: "9702")
                    }
                    NavigationLink(destination: Text("quali")) {
                        Text("Psychology (9990)")
                        //TitleLabel("Psychology", subtitle: "9990")
                    }
                }
                
            }
            //.headerProminence(.increased)
        }
        
        .listStyle(.grouped)
        .navigationBarTitle("AS & A Levels", displayMode: .inline)
    }
}
