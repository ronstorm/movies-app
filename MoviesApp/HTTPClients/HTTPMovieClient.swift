//
//  HTTPMovieClient.swift
//  MoviesApp
//
//  Created by Amit Sen on 06.01.23.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation

class HTTPMovieClient: ObservableObject {
    
    @Published var movies = [Movie]()
    
    func deleteMovie(movie: Movie, completion: @escaping (Bool) -> Void) {
        
        guard let uuid = movie.id?.uuidString, let url = URL(string: "http://localhost:8080/movies/\(uuid)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func getAllMovies() {
        
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self, let data, error == nil else { return }
            
            if let movies = try? JSONDecoder().decode([Movie].self, from: data) {
                DispatchQueue.main.async {
                    self.movies = movies
                }
            }
        }.resume()
    }
    
    func saveMovie(name: String, poster: String, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined!")
        }
        
        let movie = Movie(title: name, poster: poster)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
        }.resume()
    }
    
    func saveReview(review: Review, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://localhost:8080/reviews") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(review)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
}
