//
//  MovieDetail.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case runTime = "Runtime"
        case rated = "Rated"
        case director = "Director"
        case plot = "Plot"
        case posterUrl = "Poster"
    }
    
    var title:String
    var year:String
    var genre:String
    var runTime:String
    var rated:String
    var director:String
    var plot:String
    var posterUrl:String
    
}
