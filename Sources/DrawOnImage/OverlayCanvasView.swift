//
//  File.swift
//  
//
//  Created by Bartolomeo Sorrentino on 06/02/23.
//

import SwiftUI
import PencilKit

public struct OverlayCanvasView {
    @Binding var canvas: PKCanvasView
    @State var toolPicker = PKToolPicker()

    var draw: Bool
    var onChange: () -> Void
    
    public init( _ canvas: Binding<PKCanvasView>, draw: Bool, onChange: @escaping () -> Void ) {
        self._canvas = canvas
        self.draw = draw
        self.onChange = onChange
    }
}

extension OverlayCanvasView: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> PKCanvasView {
        
//        canvas.tool = PKInkingTool(.pen, color: .gray, width: 10)
//        canvas.translatesAutoresizingMaskIntoConstraints = false
//        canvas.maximumZoomScale = 2.0
        #if targetEnvironment(simulator)
        canvas.drawingPolicy = .anyInput
//        canvas.layer.borderColor = UIColor.red.cgColor
//        canvas.layer.borderWidth = 4
        #endif
        canvas.isOpaque = false
        canvas.backgroundColor = UIColor.clear
        canvas.delegate = context.coordinator
        
        return canvas
    }

    public func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
//        print( Self.self, #function, "content offset: \(canvas.contentOffset) size: \(canvas.contentSize) ")
        canvas.drawingGestureRecognizer.isEnabled = draw
        if draw {
            showToolPicker()
        }
        else {
            hideToolPicker()
        }

    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvas, onChange: onChange )
    }
}

extension OverlayCanvasView {
    
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
    }
    
    func hideToolPicker() {
        toolPicker.setVisible(false, forFirstResponder: canvas)
        toolPicker.removeObserver(canvas)
        canvas.resignFirstResponder()
    }
}

public class Coordinator: NSObject {
    
    var canvasView: Binding<PKCanvasView>
    var onChange: () -> Void
    
    init(canvasView: Binding<PKCanvasView>, onChange: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onChange = onChange
    }
}

extension Coordinator: PKCanvasViewDelegate, PKToolPickerObserver {
    
    // MARK: PKCanvasViewDelegate
    
    public func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
        onChange()
    }
    
    public func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    public func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    public func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
    }
    
    // MARK: PKToolPickerObserver
    
    public func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )
    }

    
    public func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )
    }

    
    public func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function, "isVisible: \(toolPicker.isVisible)" )

    }

    
    public func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        print( Self.self, #function )

    }

}
