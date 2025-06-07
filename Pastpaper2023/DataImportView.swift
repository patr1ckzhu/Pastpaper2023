import SwiftUI

struct DataImportView: View {
    @ObservedObject var dataImporter: DataImporter
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Local Search Setup")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Import your existing exam papers data to enable fast local search. This is a one-time setup process.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                if dataImporter.isImporting {
                    VStack(spacing: 15) {
                        ProgressView(value: dataImporter.importProgress)
                            .progressViewStyle(LinearProgressViewStyle())
                        
                        Text(dataImporter.importStatus)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(Int(dataImporter.importProgress * 100))%")
                            .font(.headline)
                            .monospacedDigit()
                    }
                    .padding()
                } else {
                    VStack(spacing: 15) {
                        Button(action: {
                            Task {
                                await dataImporter.importFromMeiliSearch()
                            }
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Import from MeiliSearch")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        if let errorMessage = dataImporter.errorMessage {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Benefits of Local Search:")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Works offline")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Faster search results")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("No server costs")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Better privacy")
                        }
                    }
                    .font(.body)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Data Import")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    dismiss()
                }
                .disabled(dataImporter.isImporting)
            )
        }
    }
}