//
//  MovieDetailViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var plot: UITextView!
    
    var imdbId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func logFirebase(with movie:MovieDetail) {
        Analytics.logEvent("movieDetails", parameters: [
            "title": movie.title as NSObject,
            "genre": movie.genre as NSObject,
            "runTime": movie.runTime as NSObject
            ])
    }
    
    func fetchData() {
        OmService.shared.getMovieDetail(with: imdbId) {[unowned self] (response) in
            switch response {
            case .success(let response):
                let details = response.movieDetail
                self.fillDetails(for: details)
                self.logFirebase(with: details)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fillDetails(for movie:MovieDetail){
        movieTitle.text = movie.title
        genre.text = movie.genre
        runtime.text = movie.runTime
        rated.text = movie.rated
        year.text = movie.year
        director.text = movie.director
        plot.text = movie.plot
        
        if let url = URL(string: movie.posterUrl){
            posterView.af_setImage(withURL: url)
        }
    }
    
}
