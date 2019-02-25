//
//  OmRouter.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation
import Alamofire

public enum OmRouter: URLRequestConvertible {
    
    enum Constants {
        static let baseURLPath = "http://www.omdbapi.com/"
        static let apiKey = "7ef7d212"
    }
    
    case movie(title:String)
    case movieDetails(id:String)
    
    
    var method:HTTPMethod {
        switch self {
        case .movie, .movieDetails:
            return .get
        }
    }
    
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    var parameters:[String: Any] {
        var params = ["apiKey" : Constants.apiKey as Any]
        
        switch self {
        case .movie(let title):
            params["s"] = title as Any
        case .movieDetails(let id):
            params["i"] = id as Any
        }
        
        return params
    }
    
    //    var responseType:Decodable.Type {
    //        switch self {
    //        case .movie:
    //            return MovieListResponse.self
    //        case .movieDetails:
    //            return MovieDetailResponse.self
    //        }
    //    }

    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}


