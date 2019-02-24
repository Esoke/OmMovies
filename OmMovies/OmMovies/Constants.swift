//
//  Constants.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

enum Constants {
    
    enum LabelKeys {
        static var titleText:String {
            return "titleText"
        }
    }

}

enum Storyboard {
    static var Main:UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
   
    static var Splash:UIStoryboard {
        return UIStoryboard(name:"Splash", bundle:Bundle.main)
    }
    
    enum Name {
        static var Main:String {
            return "Main"
        }
        static var Profile:String {
            return "Splash"
        }
    }
}

enum Cell {
    enum NibName {
        static var Movie:String{
            return "MovieTableViewCell"
        }
    }
    enum Identifier {
        static var Movie:String {
            return "MovieTableViewCell"
        }
    }
}

enum ViewController {
    enum Identifier {
        static var MovieNavigation:String {
            return "MovieNavigation"
        }
        static var MovieList:String {
            return "MovieListViewController"
        }
        static var MovieDetail:String {
            return "MovieDetailViewController"
        }
    }
}


