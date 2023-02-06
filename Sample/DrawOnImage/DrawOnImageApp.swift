//
//  DrawOnImageApp.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI

@main
struct DrawOnImageApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView( image: UIImage(named: "001a"))
                    .tabItem {
                        Label("001a", systemImage: "")
                    }
                
                ContentView( image: UIImage(named: "diagram1"))
                    .tabItem {
                        Label("diagram1", systemImage: "")
                    }
            }
        }
        
    }
}
