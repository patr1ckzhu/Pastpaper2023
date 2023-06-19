//
//  Pastpaper2023App.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/7.
//

import SwiftUI

@main
struct Pastpaper2023App: App {
    @AppStorage("Theme") var theme: Theme = .systemDefault
    
    var body: some Scene {
        WindowGroup {
            TestView1()
                .preferredColorScheme(theme.colorScheme)
        }
    }
}
