//
//  swiftui-math-viewer.swift
//  Pastpaper2023
//
//  Created by Patrick on 2025/6/15.
//

import SwiftUI
import WebKit

// MARK: - Data Models
struct MathExam: Codable {
    let exam: ExamInfo
}

struct ExamInfo: Codable {
    let title: String
    let year: String
    let season: String
    let totalMarks: Int
    let questions: [Question]
}

struct Question: Codable, Identifiable {
    let id: Int
    let number: String
    let content: String
    let marks: Int
    let imageUrl: String?
    let parts: [QuestionPart]
}

struct QuestionPart: Codable {
    let partId: String
    let question: String
    let answer: Answer
}

struct Answer: Codable {
    let steps: [Step]
    let finalAnswer: String
}

struct Step: Codable {
    let step: String
    let marks: String
}

// MARK: - Views
struct MathPaperView: View {
    @State private var selectedQuestion: Question?
    @State private var examData: ExamInfo?
    @State private var showingAnswer = false
    
    var body: some View {
        NavigationStack {
            List {
                if let exam = examData {
                    ForEach(Array(exam.questions.enumerated()), id: \.element.id) { index, question in
                        NavigationLink(destination: QuestionDetailView(question: question, allQuestions: exam.questions, currentIndex: index)) {
                            QuestionRow(question: question, isSelected: false)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Maths Viewer")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .onAppear {
            loadExamData()
        }
    }
    
    func loadExamData() {
        guard let url = Bundle.main.url(forResource: "alevel-math-qa-json", withExtension: "json") else {
            print("Could not find alevel-math-qa-json.json file")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let mathExam = try JSONDecoder().decode(MathExam.self, from: data)
            examData = mathExam.exam
            print("Successfully loaded \(mathExam.exam.questions.count) questions")
        } catch {
            print("Error loading exam data: \(error)")
        }
    }
}

struct QuestionRow: View {
    let question: Question
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Question \(question.number)")
                    .font(.headline)
                Text("\(question.marks) marks")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if isSelected {
                Image(systemName: "chevron.right")
                    .foregroundColor(.accentColor)
            }
                
        }
        .padding(.vertical, 4)
        .background(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        
    }
}

struct QuestionDetailView: View {
    @State private var currentQuestion: Question
    let allQuestions: [Question]
    @State private var currentIndex: Int
    @State private var showingAnswer = false
    
    init(question: Question, allQuestions: [Question], currentIndex: Int) {
        self._currentQuestion = State(initialValue: question)
        self.allQuestions = allQuestions
        self._currentIndex = State(initialValue: currentIndex)
    }
    
    var nextQuestion: Question? {
        guard currentIndex + 1 < allQuestions.count else { return nil }
        return allQuestions[currentIndex + 1]
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Question Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Question \(currentQuestion.number)")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("\(currentQuestion.marks) marks")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Question Content
                if let imageUrl = currentQuestion.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                    }
                    .padding()
                }
                
                // Main question content
                if !currentQuestion.content.isEmpty {
                    Text(currentQuestion.content)
                        .padding()
                        .multilineTextAlignment(.leading)
                }
                
                // Show parts questions if there are multiple parts or if main content is empty
                if currentQuestion.parts.count > 1 || (currentQuestion.content.isEmpty && !currentQuestion.parts.isEmpty) {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        ForEach(currentQuestion.parts, id: \.partId) { part in
                            VStack(alignment: .leading, spacing: 8) {
                                if part.partId != "main" {
                                    Text("Part (\(part.partId))")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                Text(part.question)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                        }
                    }
                }
                
                // Show/Hide Answer Button
                Button(action: {
                    withAnimation {
                        showingAnswer.toggle()
                    }
                }) {
                    Label(showingAnswer ? "Hide Answer" : "Show Answer",
                          systemImage: showingAnswer ? "eye.slash" : "eye")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                // Answer Section
                if showingAnswer {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Answer")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ForEach(currentQuestion.parts, id: \.partId) { part in
                            PartAnswerView(part: part)
                        }
                    }
                    .padding(.top)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let next = nextQuestion {
                    Button(action: {
                        withAnimation {
                            currentQuestion = next
                            currentIndex += 1
                            showingAnswer = false
                        }
                    }) {
                        HStack {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct PartAnswerView: View {
    let part: QuestionPart
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if part.partId != "main" {
                Text("Part (\(part.partId))")
                    .font(.headline)
                    .padding(.horizontal)
            }
            
            ForEach(Array(part.answer.steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top) {
                    Text(step.step)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text(step.marks)
                        .font(.caption)
                        .padding(4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            
            // Final Answer
            HStack {
                Text("Final Answer:")
                    .font(.headline)
                Text(part.answer.finalAnswer)
                    .foregroundColor(.green)
                    .fontWeight(.medium)
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Select a question to view")
                .font(.title2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Math Rendering View
struct MathTextView: UIViewRepresentable {
    let text: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
            <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
            <script>
                MathJax = {
                    tex: {
                        inlineMath: [['$', '$'], ['\\\\(', '\\\\)']],
                        displayMath: [['$$', '$$'], ['\\\\[', '\\\\]']]
                    },
                    startup: {
                        ready: () => {
                            MathJax.startup.defaultReady();
                            MathJax.startup.promise.then(() => {
                                window.webkit.messageHandlers.heightUpdate.postMessage(document.body.scrollHeight);
                            });
                        }
                    }
                };
            </script>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                    font-size: 16px;
                    line-height: 1.5;
                    margin: 8px;
                    padding: 0;
                    background-color: transparent;
                }
            </style>
        </head>
        <body>
            \(text.replacingOccurrences(of: "\n", with: "<br>"))
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.configuration.userContentController.add(self, name: "heightUpdate")
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "heightUpdate", let height = message.body as? Double {
                DispatchQueue.main.async {
                    if let webView = message.webView {
                        webView.frame.size.height = CGFloat(height)
                        webView.invalidateIntrinsicContentSize()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct MathPaperView_Previews: PreviewProvider {
    static var previews: some View {
        MathPaperView()
    }
}
