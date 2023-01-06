//
//  Movie.swift
//  MoviesApp
//
//  Created by Amit Sen on 06.01.23.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: UUID?
    var title: String
    var poster: String
    
    private enum MovieKeys: String, CodingKey {
        case id, title, poster
    }
}

extension Movie {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: MovieKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.poster = try container.decode(String.self, forKey: .poster)
    }
}
