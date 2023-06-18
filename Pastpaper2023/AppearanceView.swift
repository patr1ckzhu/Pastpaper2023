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
                                .font(.system(size: 15))
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        theme = themeOption
                        UserDefaults.standard.set(theme.rawValue, forKey: "Theme")
                        for scene in UIApplication.shared.connectedScenes {
                            if let windowScene = scene as? UIWindowScene {
                                windowScene.windows.forEach { window in
                                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                        window.overrideUserInterfaceStyle = themeOption.userInterfaceStyle
                                    }, completion: nil)
                                }
                            }
                        }
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

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .systemDefault:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}


