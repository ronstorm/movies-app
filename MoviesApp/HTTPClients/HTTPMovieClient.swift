//
//  HTTPMovieClient.swift
//  MoviesApp
//
//  Created by Amit Sen on 06.01.23.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation

class HTTPMovieClient: ObservableObject {
    
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
}
