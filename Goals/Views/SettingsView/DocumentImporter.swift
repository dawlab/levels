//
//  DocumentImporter.swift
//  Goals
//
//  Created by Dawid Łabno on 27/06/2023.
//

import Foundation
import SwiftUI
import UIKit

struct DocumentImporter: UIViewControllerRepresentable {
    var url: URL
    @EnvironmentObject var goalViewModel: GoalViewModel

    var temporaryDirectory: URL {
        FileManager.default.temporaryDirectory
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, goalViewModel: goalViewModel)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.init(filenameExtension: "realm")!])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentImporter
        var goalViewModel: GoalViewModel

        init(_ parent: DocumentImporter, goalViewModel: GoalViewModel) {
            self.parent = parent
            self.goalViewModel = goalViewModel
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let sourceURL = urls.first else { return }
            
            // Request access to the resource
            guard sourceURL.startAccessingSecurityScopedResource() else {
                // If the resource cannot be accessed, return
                print("Failed to access the resource at URL: \(sourceURL)")
                return
            }
            
            // Make sure to release the security-scoped resource when you're done
            defer { sourceURL.stopAccessingSecurityScopedResource() }
            
            let temporaryURL = parent.temporaryDirectory.appendingPathComponent(sourceURL.lastPathComponent)

            do {
                if FileManager.default.fileExists(atPath: temporaryURL.path) {
                    try FileManager.default.removeItem(at: temporaryURL)
                }

                try FileManager.default.copyItem(at: sourceURL, to: temporaryURL)

                let destinationURL = parent.url
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                try FileManager.default.copyItem(at: temporaryURL, to: destinationURL)

                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Restart Application", message: "Data imported. Please restart the application to see the changes.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
                          let rootViewController = keyWindow.rootViewController else {
                        return
                    }
                    
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            } catch {
                print("Failed to import Realm database: \(error)")
            }
        }
    }
}
