//
//  ContentView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI
import DrawOnImage



typealias ToggleState = ( on: Image, off: Image)

struct ToggleButton : View {
     
    @Binding var state:Bool
    var images: ( on:Image, off:Image )
    
    var body: some View {
        Button( action: {
            state.toggle()
        }) {
            (state) ? images.on : images.off
        }
    }
    
}

struct ContentView: View {
     
    var image: UIImage?
    @State var fit: Bool = true
    @State var draw: Bool = false

    var BackgroundImage: Image {
        if let image {
            return Image( uiImage: image)
        }
        else {
            return Image("")
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ToggleButton( state: $fit, images: (
                    on: Image(systemName: "arrow.down.right.and.arrow.up.left"),
                    off: Image( systemName: "arrow.up.left.and.arrow.down.right")))
                ToggleButton( state: $draw, images: (
                    on: Image(systemName: "pencil.circle.fill"),
                    off: Image( systemName: "pencil.circle")))
            }
            DrawOnImageView( contentMode: (fit) ? .fit : .fill,
                             allowToDraw: draw ) {
                BackgroundImage
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach( ["001a", "diagram1"], id: \.self ) { imgName in
            Group {
                ContentView( image: UIImage( named: imgName )  )
                    .previewInterfaceOrientation(.portrait)
                ContentView( image: UIImage( named: imgName ) )
                    .previewInterfaceOrientation(.landscapeLeft)
            }
        }
    }
}

