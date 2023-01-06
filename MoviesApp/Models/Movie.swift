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
}
