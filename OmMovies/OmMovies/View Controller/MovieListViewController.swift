//
//  MovieListViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var movieList:[Movie] = []
    
    ///The bar button item to search albums.
    fileprivate var searchItem: UIBarButtonItem?
    ///The search bar item where search phrases are entered.
    fileprivate var searchBar:UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBarCancelButtonClicked(searchBar!)
    }
    
    func setup() {
        searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(MovieListViewController.searchButtonTapped))
        navigationItem.setRightBarButtonItems([searchItem!], animated: true)
        
        searchBar = UISearchBar(frame: CGRect(x: 0.0, y: -80.0, width: self.view.frame.size.width, height: 44.0))
        self.navigationController?.navigationBar.addSubview(searchBar!)
        self.searchBar?.delegate = self
        searchButtonTapped()
        
        navigationItem.title = "OM Database"
        
        self.tableView.register((UINib(nibName: Cell.NibName.Movie, bundle: nil)), forCellReuseIdentifier: Cell.Identifier.Movie)
    }
    
    ///Handles the search button click.
    @objc func searchButtonTapped() {
        searchBar?.frame = CGRect(x: 5.0, y: 0.0, width: self.view.frame.size.width, height: 44.0)
        searchBar?.showsCancelButton = true
        searchBar?.placeholder = "Search for movies"
        searchBar?.becomeFirstResponder()
        navigationItem.setRightBarButtonItems(nil, animated: false)
    }
    
    func fetchMovies(with title:String) {
        OmService.shared.getMovies(with: title) {[unowned self] (response) in
            switch response {
            case .success(let response):
                self.movieList = response.movies
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Ops!", message: "Movie cannot be found", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }

    func openMovieDetails(with imdbId:String){
        guard let movieDetailsVC = Storyboard.Main.instantiateViewController(withIdentifier: ViewController.Identifier.MovieDetail) as? MovieDetailViewController else { return }
        movieDetailsVC.imdbId = imdbId
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}


extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.Identifier.Movie, for: indexPath)
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.setup(with: self.movieList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var message = ""
        if  self.movieList.count == 0 {
            message = "Search movies."
        }
        return message
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.movieList[indexPath.row].imdbID
        openMovieDetails(with: id)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.frame = CGRect(x: 0.0, y: -80.0, width: 0.0, height: 44.0)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
        movieList = []
        tableView.reloadData()
        navigationItem.setRightBarButtonItems([searchItem!], animated: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let title = searchBar.text {
            fetchMovies(with: title)
        }
        searchBar.resignFirstResponder()
    }
    
}
