//
//  MovieDetailViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OmService.shared.getMovieDetail(with: "tt4649466") { (response) in
            print(response)
        }
    }
    
    
}
