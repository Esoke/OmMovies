//
//  SplashViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReachabilityManager.shared.isReachable()
    }

}
