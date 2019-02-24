//
//  MovieListResponse.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case search = "Search"
    }
    
    let movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.movies = try rootContainer.decode([Movie].self, forKey: .search)
    }
    
}
