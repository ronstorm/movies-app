//
//  Review.swift
//  MoviesApp
//
//  Created by Amit Sen on 07.01.23.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation

struct Review: Codable {
    var id: UUID?
    var title: String
    var body: String
    var movie: Movie
}
