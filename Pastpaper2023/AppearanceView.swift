//
//  AppearanceView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct AppearanceView: View {
    @AppStorage("Theme") var theme: Theme = .systemDefault

    var body: some View {
        List {
            Section(header: Text("Theme")) {
                ForEach(Theme.allCases, id: \.self) { themeOption in
                    HStack {
                        Text(themeOption.rawValue)
                        Spacer()
                        if themeOption == theme {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        theme = themeOption
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum Theme: String, CaseIterable {
    case systemDefault = "System Default"
    case light = "Light Mode"
    case dark = "Dark Mode"

    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}


struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}
