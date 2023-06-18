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
    @Binding var isPresented: Bool
    @State private var noteText = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    let saveAction: (String, Data?) -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $noteText)
                    .padding()

                Button(action: {
                    PHPhotoLibrary.requestAuthorization { (status) in
                        switch status {
                        case .authorized:
                            showingImagePicker = true
                        case .denied, .restricted:
                            // Handle denied/restricted status
                            print("User denied or restricted access to photo library.")
                        case .notDetermined:
                            // Handle not determined status
                            print("Photo library access not determined.")
                        @unknown default:
                            // Handle any other cases
                            print("Unknown authorization status for photo library.")
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "photo")
                        Text(L10n.addPhoto)
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
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $image)
            }
            .navigationBarTitle(L10n.newNote, displayMode: .inline)
            .navigationBarItems(
                leading: Button(L10n.cancel) {
                    isPresented = false
                },
                trailing: Button(L10n.save) {
                    saveAction(noteText, image?.jpegData(compressionQuality: 0.7))
                    isPresented = false
                }
            )
        }
    }

    func loadImage() {
        guard let image = image else { return }
        self.image = image
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
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

