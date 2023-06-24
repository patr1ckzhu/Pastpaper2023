//
//  AcknowledgeView.swift
//  Pastpaper2023
//
//  Created by Patrick on 2023/6/24.
//

import SwiftUI

struct AcknowledgeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Acknowledgment")
                    .font(.title)
                    .bold()
                
                Text("I would like to express my sincere appreciation and gratitude to the developers and contributors of the following third-party libraries and tools, which have been instrumental in the development of my app:")
                
                LibraryView(index: 1, name: "MeiliSearch", homepage: "https://www.meilisearch.com/", description: "MeiliSearch is an open-source search engine that has greatly enhanced the search functionality of my application. I am grateful to the MeiliSearch team for providing an efficient and versatile search solution.")
                
                LibraryView(index: 2, name: "PDFMiner", homepage: "https://github.com/pdfminer/pdfminer.six", description: "PDFMiner has been an invaluable tool for extracting text and metadata from PDF documents in my software. I extend my appreciation to the PDFMiner developers for their efforts in creating such a reliable and feature-rich library.")
                
                LibraryView(index: 3, name: "boto3", homepage: "https://boto3.amazonaws.com/v1/documentation/api/latest/index.html", description: "I would like to thank the developers of boto3, the Amazon Web Services (AWS) SDK for Python, for enabling seamless integration with AWS services in my application. The comprehensive functionality and ease of use provided by boto3 have significantly contributed to the success of my software.")
                
                LibraryView(index: 4, name: "DynamoDB", homepage: "https://aws.amazon.com/dynamodb", description: "A highly scalable and fully managed NoSQL database service provided by Amazon Web Services (AWS). DynamoDB has been a critical component in the development of my software, and I am incredibly grateful for the robust features and capabilities it offers.")
                
                Text("I would also like to express my heartfelt gratitude and appreciation to the examination boards, including CAIE (Cambridge Assessment International Education), AQA (Assessment and Qualifications Alliance), Edexcel, OCR (Oxford, Cambridge, and RSA Examinations), and other organizations, for their publicly available question banks. These question banks have played a vital role in the development of my software.")
                
                Text("Once again, I express my sincerest gratitude to the examination boards and the developers of the third-party libraries for their invaluable contributions. The collaboration with these esteemed organizations and the utilization of their resources have been pivotal in the success and effectiveness of my software.")
            }
            .padding()
        }
    }
}

struct LibraryView: View {
    let index: Int
    let name: String
    let homepage: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(index). \(name)")
                .font(.headline)
                .bold()
            
            Text("Project Homepage: ")
                .font(.subheadline)
                .foregroundColor(.gray)
                + Text(homepage)
                .font(.subheadline)
                .foregroundColor(.blue)
                .underline()
            
            Text(description)
                .font(.body)
        }
    }
}
