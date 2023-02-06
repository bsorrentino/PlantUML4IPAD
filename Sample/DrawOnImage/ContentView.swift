//
//  ContentView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI
import DrawOnImage
import PencilKit


struct ToggleButton<Label> : View where Label : View  {
     
    @Binding var state:Bool
    var content: ( Bool ) -> Label

    init( _ state: Binding<Bool>, content: @escaping ( Bool ) -> Label ) {
        self._state = state
        self.content = content
    }
    
    var body: some View {
        Button {
            state.toggle()
        } label: {
            content( state )
        }
    }
    
}

struct ContentView: View {
    var image: UIImage?
    @State var fit: Bool = true
    @State var draw: Bool = false
    @State private var snapshot: UIImage?
    
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
                ToggleButton( $fit ) {
                    ($0 ?
                     Label( "", systemImage: "arrow.down.right.and.arrow.up.left" ) :
                        Label( "", systemImage: "arrow.up.left.and.arrow.down.right") )
                    .labelStyle(.iconOnly)
                }
                ToggleButton( $draw ) {
                    ($0 ?
                     Label( "", systemImage: "pencil.circle.fill" ) :
                        Label( "", systemImage: "pencil.circle") )
                    .labelStyle(.iconOnly)
                }
            }
            if let snapshot {
                Image( uiImage: snapshot )
                    .border(.red, width: 4)
                    .aspectRatio(contentMode: (fit) ? .fit : .fill)
            }
            DrawOnImageView(snapshot: $snapshot,
                             contentMode: (fit) ? .fit : .fill,
                             allowToDraw: draw ) {
                BackgroundImage
            }
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

