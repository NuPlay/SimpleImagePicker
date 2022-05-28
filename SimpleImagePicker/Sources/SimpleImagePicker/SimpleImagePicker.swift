//
//  SimpleImagePicker.swift
//
//
//  Created by 이웅재(NuPlay) on 2021/07/26.
//  https://github.com/NuPlay/SimpleImagePicker

import SwiftUI
import PhotosUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var showImagePicker: Bool
    let maxCount: Int
    
    let result: ([UIImage]) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = maxCount
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.showImagePicker.toggle()
            var imageSet: [UIImage] = []
            
            for img in results {
                if (img.itemProvider.canLoadObject(ofClass: UIImage.self)) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) {  (rawImageData, err) in
                        guard let imageData = rawImageData else {return}
                        guard let image = imageData as? UIImage else {return}
                        imageSet.append(image)
                    }
                }
                else {
                    print("can't load image")
                }
            }
            
            self.parent.result(imageSet)
        }
    }
}

public enum ImagePickerPresentType {
    case sheet
    case fullScreenCover
}

public struct SimpleImagePicker: ViewModifier {
    @Binding var showImagePicker: Bool
    var maxCount: Int
    var presentType: ImagePickerPresentType
    
    let result: ([UIImage]) -> Void
    
    public init(showImagePicker: Binding<Bool>, maxCount: Int = 5, presentType: ImagePickerPresentType = .sheet, result: @escaping ([UIImage]) -> Void) {
        self._showImagePicker = showImagePicker
        self.maxCount = maxCount
        self.presentType = presentType
        self.result = result
    }
    
    public func body(content: Content) -> some View {
        content
            .if(presentType == .sheet) {
                $0.sheet(isPresented: $showImagePicker) {
                    ImagePicker(showImagePicker: $showImagePicker, maxCount: maxCount) { result in
                        self.result(result)
                    }
                    .ignoresSafeArea(.all)
                }
            }
            .if(presentType == .fullScreenCover) {
                $0.fullScreenCover(isPresented: $showImagePicker) {
                    ImagePicker(showImagePicker: $showImagePicker, maxCount: maxCount) { result in
                        self.result(result)
                    }
                    .ignoresSafeArea(.all)
                }
            }
        
    }
}

extension View {
    public func simpleImagePicker(showImagePicker: Binding<Bool>, maxCount: Int = 5, presentType: ImagePickerPresentType = .sheet, result: @escaping ([UIImage]) -> Void) -> some View {
        self.modifier(SimpleImagePicker(showImagePicker: showImagePicker, maxCount: maxCount, presentType: presentType, result: result))
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
