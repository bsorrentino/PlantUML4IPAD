//
//  ContentView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI
import DrawOnImage
import PencilKit

private var isInPreviewMode:Bool {
    (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil)
}

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
    @State var preview: Bool = false
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
        ZStack {
            VStack(alignment: .leading) {
                DrawOnImageView(snapshot: $snapshot,
                                contentMode: (fit) ? .fit : .fill,
                                allowToDraw: draw ) {
                    BackgroundImage
                }
                if isInPreviewMode, preview, let snapshot {
                    Image( uiImage: snapshot )
                        .resizable()
                        .border(.red, width: 4)
                        .aspectRatio(contentMode: (fit) ? .fit : .fill)
                }
            }
            VStack {
                HStack(alignment: .top ) {
                    ToggleButton( $fit ) {
                        ($0 ?
                         Label( "fit", systemImage: "arrow.down.right.and.arrow.up.left" ) :
                            Label( "fill", systemImage: "arrow.up.left.and.arrow.down.right") )
                        .labelStyle(.titleAndIcon)
                    }
                    ToggleButton( $draw ) {
                        ($0 ?
                         Label( "", systemImage: "pencil.circle.fill" ) :
                            Label( "", systemImage: "pencil.circle") )
                        .labelStyle(.iconOnly)
                    }
                    if isInPreviewMode {
                        ToggleButton( $preview ) {
                            ($0 ?
                             Label( "preview on", systemImage: "pencil.circle.fill" ) :
                                Label( "preview off", systemImage: "pencil.circle") )
                            .labelStyle(.titleOnly)
                        }
                    }
                }
                Spacer()
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

