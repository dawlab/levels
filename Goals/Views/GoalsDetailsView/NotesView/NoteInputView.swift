//
//  NoteInputView.swift
//  Goals
//
//  Created by Dawid Łabno on 05/06/2023.
//
import SwiftUI
import UIKit
import Photos

struct NoteInputView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var noteText = ""
    @State private var image: UIImage?
    
    var onSave: (String, Data?) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $noteText)
                    .padding()
                
                Button(action: {
                    // Add photo handling logic here
                }) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Add Photo")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                image.map {
                    Image(uiImage: $0)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("New Note", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    onSave(noteText, image?.jpegData(compressionQuality: 0.7))
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}





