# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PaperHub (Pastpaper2023) is a SwiftUI iOS app for browsing and searching past papers from various exam boards. The app features a hierarchical navigation system for browsing papers by exam board, year, season, and exam type, plus smart search functionality including photo-based search.

## Development Commands

**Build & Run:**
- Open `Pastpaper2023.xcodeproj` in Xcode
- Use Xcode's built-in build (⌘B) and run (⌘R) commands
- No external package manager dependencies

**Testing:**
- Unit tests: `Pastpaper2023Tests` target in Xcode
- UI tests: `Pastpaper2023UITests` target in Xcode

## Architecture

### Navigation Flow
The app uses a hierarchical navigation pattern:
- `HomeView` → Exam board selection (CAIE, Edexcel, AQA)
- Exam board view → `YearListView` → `SeasonListView` → `ExamTypeListView` → `PaperListView`

### Search System
- **Text Search**: `SearchService` handles API calls to Meilisearch instance for document search
- **Photo Search**: `PhotoSearchService` and `PhotoSearchView` provide image-based question matching

### Key Components
- **WebView Integration**: `Modifier.swift` contains `WebView` UIViewControllerRepresentable for displaying PDFs
- **Theme System**: `Theme` enum in `AppearanceView.swift` handles light/dark/system themes via AppStorage
- **Settings**: User preferences stored via `@AppStorage` for persistence

### Data Models
- `SearchResult` and `SearchResponse` for search API responses
- `ListDisplayCount` enum for configuring search result limits
- Theme and appearance settings via enums

## Configuration Notes
- App display name: "PaperHub" 
- Bundle ID: `patrick.Pastpaper2023`
- Deployment targets: iOS 17.0+, macOS 13.3+
- Search API endpoint configured in `SearchService.swift` (contains hardcoded URL and auth token)
- App icons support multiple variants (Light, Grey, Dark) configured in Assets.xcassets

## Backend Infrastructure
- **API Implementation**: `/Users/patrick/Documents/pastpaper-api`
- **Search Implementation**: `/Users/patrick/Documents/test-search1` (Meilisearch testing and debugging)
- **Cloud Infrastructure**: AWS S3 (file storage) and EC2 (hosting)

## Development Notes
- All SwiftUI views follow consistent `@ViewBuilder` pattern for complex view composition
- Uses `@AppStorage` for user preferences persistence
- Haptic feedback controlled by `showFeedback` binding throughout the app
- Navigation uses SwiftUI's `NavigationStack` and `NavigationLink`