//
//  OmServices.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation
import Alamofire

/// Service singleton, where all the network services are kept.
public final class OmService {
    
    static let shared = OmService()
    private init() { }

    func getMovies(with title:String, completion: @escaping (Result<MovieListResponse>) -> Void) {
        request(OmRouter.movie(title: title)).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MovieListResponse.self, from: data)
                    completion(.success(response))
                }catch {
                     completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }

    func getMovieDetail(with id:String, completion: @escaping (Result<MovieDetailResponse>) -> Void) {
        request(OmRouter.movieDetails(id: id)).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MovieDetailResponse.self, from: data)
                    completion(.success(response))
                }catch {
                     completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        
        }
    }
}

enum Error: Swift.Error {
    case serializationError(internal: Swift.Error)
    case networkError(internal: Swift.Error)
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
