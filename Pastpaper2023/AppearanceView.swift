//
//  AppearanceView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/13.
//

import SwiftUI

struct AppearanceView: View {
    @AppStorage("Theme") var theme: Theme = .systemDefault
    @AppStorage("appIcon") var appIcon: String?
    @Binding var showFeedback: Bool
        
    let appIcons = ["Light", "Grey", "Dark"]

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
                    }
                    
                }
            }
            Section(header: Text("App Icon")) {
                ForEach(appIcons, id: \.self) { icon in
                    HStack {
                        Text(icon.capitalized)
                        Spacer()
                        if icon == appIcon {
                            Image(systemName: "checkmark")
                                .font(.system(size: 15))
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appIcon = icon
                        UIApplication.shared.setAlternateIconName(icon == "Light" ? nil : icon) { error in
                            if let error = error {
                                print("App icon failed to due to \(error.localizedDescription)")
                            } else {
                                print("App icon changed successfully")
                            }
                        }
                        if showFeedback {
                            let notificationGenerator = UINotificationFeedbackGenerator()
                            notificationGenerator.notificationOccurred(.success)
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



