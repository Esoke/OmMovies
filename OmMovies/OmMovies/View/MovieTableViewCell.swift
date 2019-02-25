//
//  MovieTableViewCell.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

/// TableViewCell to show movie details.
class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with movie:Movie) {
        title.text = movie.title
        year.text = movie.year
        type.text = movie.type
    }
    
}
