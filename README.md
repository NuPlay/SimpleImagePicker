# SimpleImagePicker
## You don't have to get Photo Permission
![iMac - 2](https://user-images.githubusercontent.com/73557895/170827414-fd6d9d9c-3f06-44b6-b518-9295b0191aa7.png)


<p align="center">
    <a href="https://swift.org/">
        <img src="https://img.shields.io/badge/Swift-5.1+-F05138?labelColor=303840" alt="Swift: 5.1+">
    </a>
    <a href="https://www.apple.com/ios/">
        <img src="https://img.shields.io/badge/iOS-14.0+-007AFF?labelColor=303840" alt="iOS: 14.0+">
    </a>
</p>

## Code
```swift
import SwiftUI
import SimpleImagePicker

struct SimpleImagePickerTest: View {
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        Button(action: {
            self.showImagePicker.toggle()
        }, label: {
                           Text("GetImage")
                       })
        .simpleImagePicker(showImagePicker: $showImagePicker) { result in
         // result == [UIImage]
            print(result)
        }
    }
}

```
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding SimpleImagePicker as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/NuPlay/SimpleImagePicker.git", .upToNextMajor(from: "1.0.0"))
]
```

## More

```swift
import SwiftUI
import SimpleImagePicker

struct SimpleImagePickerTest: View {
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        Button(action: {
            self.showImagePicker.toggle()
        }, label: {
                           Text("GetImage")
                       })
        .simpleImagePicker(showImagePicker: $showImagePicker, maxCount: 5, presentType: .sheet) { result in
         // result == [UIImage]
            print(result)
        }
    }
}
    
```

### Parameter
Parameter | Default
--- | ---
`showImagePicker: Binding<Bool>` | 
`maxCount: Int` | `5(0 means Unlimited Photos)`
`presentType: ImagePickerPresentType(sheet, fullScreenCover)` | `.sheet`
`result: @escaping ([UIImage]) -> Void` | 
