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

    public init( _ canvas: Binding<PKCanvasView>, draw: Bool) {
        self._canvas = canvas
        self.draw = draw
    }
}

extension OverlayCanvasView: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> PKCanvasView {
        
//        canvas.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvas.drawingPolicy = .anyInput
        #endif
        canvas.isOpaque = false
        canvas.backgroundColor = UIColor.clear
        canvas.delegate = context.coordinator
        return canvas
    }

    public func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        canvas.drawingGestureRecognizer.isEnabled = draw
        if draw {
            showToolPicker()
        }
        else {
            hideToolPicker()
        }

    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvas)
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

    init(canvasView: Binding<PKCanvasView>) {
        self.canvasView = canvasView
    }
}

extension Coordinator: PKCanvasViewDelegate, PKToolPickerObserver {
    
    // MARK: PKCanvasViewDelegate
    
    public func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print( Self.self, #function )
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
