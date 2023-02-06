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

public struct DrawOnImageView: View {

    @State private var canvas: PKCanvasView = PKCanvasView()
    
//    private var image: UIImage?
    private var contentMode: ContentMode
    private var draw: Bool
    private var content: () -> Image
    
//    @State private var drawingOnImage: UIImage = UIImage()

//    @Binding var image: UIImage
//    let onSave: (UIImage) -> Void

//    init(image: Binding<UIImage>, onSave: @escaping (UIImage) -> Void) {
//        self._image = image
//        self.onSave = onSave
//    }

    public init(contentMode: ContentMode, allowDraw draw: Bool, content: @escaping () -> Image ) {
//        self.image = image
        self.contentMode = contentMode
        self.draw = draw
        self.content = content
        clear()
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
            .overlay( OverlayCanvasView($canvas, draw: draw ), alignment: .bottomLeading )
    }
    
    public var body: some View {
        
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

    private func onChanged() -> Void {
//        self.drawingOnImage = canvasView.drawing.image(
//            from: canvasView.bounds, scale: UIScreen.main.scale)
    }

//    private func initCanvas() -> Void {
//        self.canvasView = PKCanvasView();
//        self.canvasView.isOpaque = false
//        self.canvasView.backgroundColor = UIColor.clear
//        self.canvasView.becomeFirstResponder()
//    }

    private func save() -> Void {
//        onSave(self.image.mergeWith(topImage: drawingOnImage))
    }
}


//struct DrawOnImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawOnImageView()
//    }
//}
