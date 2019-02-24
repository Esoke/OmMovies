//
//  MovieListViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchMovies(with title:String) {
        OmService.shared.getMovies(with: title) { (movies) in
            
        }
    }

}
