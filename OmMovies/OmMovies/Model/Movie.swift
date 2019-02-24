//
//  Movie.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case imdbID
    }
    
    var title:String
    var year:String
    var type:String
    var imdbID:String
}
