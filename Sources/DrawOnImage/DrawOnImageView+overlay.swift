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
    
    private var image: UIImage?
    private var contentMode: ContentMode
    private var draw: Bool
    
//    @State private var drawingOnImage: UIImage = UIImage()

//    @Binding var image: UIImage
//    let onSave: (UIImage) -> Void

//    init(image: Binding<UIImage>, onSave: @escaping (UIImage) -> Void) {
//        self._image = image
//        self.onSave = onSave
//    }

    public init(image: UIImage?, contentMode: ContentMode, allowDraw draw: Bool ) {
        self.image = image
        self.contentMode = contentMode
        self.draw = draw
        
        clear()
    }
    
    public func clear() {
        print( Self.self, #function )
        canvas.drawing = PKDrawing()
    }
    
    func CanvasWithImage( _ image: UIImage ) -> some View {
        Image( uiImage: image )
            .resizable()
            .aspectRatio(contentMode: contentMode)
        //  .edgesIgnoringSafeArea(.all)
            .overlay( CanvasView(canvasView: $canvas,
                                 draw: draw,
                                 onSaved: onChanged ), alignment: .bottomLeading )
    }
    
    public var body: some View {
        if let image  {
            
            if contentMode == .fill {
                
                if #available(iOS 16, *) {
                    ScrollView( [.horizontal, .vertical] ) {
                        CanvasWithImage(image)
                            .scrollDisabled(draw)
                    }
                }
                else {
                    ScrollView( [.horizontal, .vertical] ) {
                        CanvasWithImage(image)
                            .introspectScrollView {
                                $0.isScrollEnabled = !draw
                            }
                    }
                }
            }
            else {
                CanvasWithImage(image)
            }

        }
        else {
            EmptyView()
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

private struct CanvasView {
    @Binding var canvasView: PKCanvasView
    @State var toolPicker = PKToolPicker()

    var draw: Bool
    
    let onSaved: () -> Void

}

extension CanvasView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvas.drawingPolicy = .anyInput
        #endif
        canvasView.isOpaque = false
        canvasView.backgroundColor = UIColor.clear
        canvasView.delegate = context.coordinator
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        canvasView.drawingGestureRecognizer.isEnabled = draw
        if draw {
            showToolPicker( observer: canvasView )
        }
        else {
            hideToolPicker( observer: canvasView )
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvasView, onSaved: onSaved)
    }
}

private extension CanvasView {
    
    func showToolPicker<Observer : PKToolPickerObserver>( observer: Observer) {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(observer)
        canvasView.becomeFirstResponder()
    }
    
    func hideToolPicker<Observer : PKToolPickerObserver>( observer: Observer) {
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        toolPicker.removeObserver(observer)
        canvasView.resignFirstResponder()
    }
}

class Coordinator: NSObject {
    
    var canvasView: Binding<PKCanvasView>
    let onSaved: () -> Void

    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onSaved = onSaved
    }
}

extension Coordinator: PKCanvasViewDelegate, PKToolPickerObserver {
    
    // MARK: PKCanvasViewDelegate
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
        if !canvasView.drawing.bounds.isEmpty {
            onSaved()
        }
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    // MARK: PKToolPickerObserver
    
    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )
    }

    
    func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )
    }

    
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function, "isVisible: \(toolPicker.isVisible)" )

    }

    
    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )

    }

}

//struct DrawOnImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawOnImageView()
//    }
//}
