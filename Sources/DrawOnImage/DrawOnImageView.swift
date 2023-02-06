//
//  DrawOnImageView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//
// Inspired by : [Background Image and canvas with pencilKit Swiftui](https://stackoverflow.com/a/69298063/521197))
//

import SwiftUI
import PencilKit
import UIKit
import Introspect

//
//  inspired by [How to convert a SwiftUI view to an image](https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image)
//
extension View {
    
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        guard let view = controller.view else {
            return nil
        }

        let targetSize = controller.view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

public extension UIImage {
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)


        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}

public struct DrawOnImageView: View {
    
    @State private var canvas: PKCanvasView = PKCanvasView()
    
    private var contentMode: ContentMode
    private var draw: Bool
    private var content: () -> Image
    
    @Binding private var snapshot: UIImage?
    
    public init( screenshot: Binding<UIImage?>, contentMode: ContentMode, allowToDraw draw: Bool, content: @escaping () -> Image ) {
        self._snapshot = screenshot
        self.contentMode = contentMode
        self.draw = draw
        self.content = content
    }
    
    public func clear() {
        print( Self.self, #function )
        canvas.drawing = PKDrawing()
    }
    
    var CanvasWithImage: some View {
        
        content()
            .resizable()
            .aspectRatio(contentMode: contentMode)
        //  .edgesIgnoringSafeArea(.all)
            .overlay( OverlayCanvasView($canvas, draw: draw, onChange: onChange ), alignment: .bottomLeading )
    }
    
    public var body: some View {
        
        Group {
            if contentMode == .fill {
                
                if #available(iOS 16, *) {
                    ScrollView( [.horizontal, .vertical] ) {
                        CanvasWithImage
                    }
                    .scrollDisabled(draw)
                }
                else {
                    ScrollView( [.horizontal, .vertical] ) {
                        CanvasWithImage
                            .introspectScrollView {
                                $0.isScrollEnabled = !draw
                            }
                    }
                }
            }
            else {
                CanvasWithImage
            }
        }
        .task {
            clear()
            
            self.snapshot = content().asUIImage()
        }
    }
    
    private func onChange() -> Void {
        if let content = content().asUIImage() {
            let img =  canvas.drawing.image(
                from: canvas.bounds, scale: UIScreen.main.scale)
            self.snapshot = content.mergeWith(topImage: img)
        }
    }
}

//struct DrawOnImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawOnImageView()
//    }
//}
