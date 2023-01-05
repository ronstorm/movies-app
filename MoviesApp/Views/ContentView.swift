//
//  ContentView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/14/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let screenSize = UIScreen.main.bounds

    var body: some View {
        
        NavigationView {
            VStack {
                Text("ss")
                }.fullscreen()
            .background(Color.black)
                
                
        .navigationBarTitle("Movies")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })
        }.sheet(isPresented: $isPresented) {
            AddMovieView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
