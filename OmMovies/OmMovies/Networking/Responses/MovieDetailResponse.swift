//
//  MovieDetailResponse.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation

///Response object that decodes the selected movie details fetched from the OMdb.
struct MovieDetailResponse: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case search = ""
    }
    
    let movieDetail: MovieDetail
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    public init(from decoder: Decoder) throws {
        self.movieDetail = try MovieDetail(from: decoder)
    }
    
}
