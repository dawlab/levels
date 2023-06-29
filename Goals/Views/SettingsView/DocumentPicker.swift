//
//  DocumentPicker.swift
//  Goals
//
//  Created by Dawid Łabno on 27/06/2023.
//

import Foundation
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    var url: URL
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [url])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let alert = UIAlertController(title: "Wyeksportowano dane", message: "Wyeksportowany plik z bazą danych znajdziesz w aplikacji Pliki. Zapisz go w bezpiecznym miejscu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            }))
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
                  let rootViewController = keyWindow.rootViewController else {
                return
            }
            
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}
