//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Amit Sen on 06.01.23.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    @State
    private var reviewTitle: String = ""
    
    @State
    private var reviewBody: String = ""
    
    @Environment(\.presentationMode)
    private var presentationMode
    
    private func deleteMovie() {
        
        HTTPMovieClient().deleteMovie(movie: movie) { _ in
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func saveReview() {
        
        let review = Review(title: self.reviewTitle, body: self.reviewBody, movie: self.movie)
        HTTPMovieClient().saveReview(review: review) { _ in }
    }
    
    var body: some View {
        
        Form {
            
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Section(header: Text("ADD A REVIEW").fontWeight(.bold)) {
                VStack(alignment: .center, spacing: 10) {
                    TextField("Enter Title",text: $reviewTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Body",text: $reviewBody)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {
                        self.saveReview()
                    }
                }
                
            }
            
            Section(header: Text("REVIEWS").fontWeight(.bold)) {
                ForEach(0...20, id: \.self) { index in
                    Text("Review \(index)")
                }
            }
        }
        .navigationBarTitle(movie.title)
        
        .navigationBarItems(trailing: Button(action: {
            self.deleteMovie()
        }) {
            Image(systemName: "trash.fill")
        })
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(title: "Birds of Prey", poster: "birds"))
        
    }
}
