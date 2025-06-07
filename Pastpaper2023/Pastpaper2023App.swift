//
//  Pastpaper2023App.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/7.
//

import SwiftUI

@main
struct Pastpaper2023App: App {
    @AppStorage("ShowFeedback") var showFeedback = true
    @AppStorage("Theme") var theme: Theme = .systemDefault
    
    let coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView(showFeedback: $showFeedback)
                .preferredColorScheme(theme.colorScheme)
                .environment(\.managedObjectContext, coreDataStack.viewContext)
        }
    }
}
