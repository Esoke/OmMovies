//
//  SplashViewController.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var timer = Timer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityManager.shared.isReachable()
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
    }
    
    //MARK: - Remote Config
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            Constants.LabelKeys.titleText : "" as NSObject,
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    
    func fetchRemoteConfig() {
        //Debug settings must be removed before production.
        let debugSettings = RemoteConfigSettings.init(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) {[unowned self] (status, error) in
            guard error == nil else {print ("error fetching remote config"); return}
            RemoteConfig.remoteConfig().activateFetched()
            self.updateUIWithRemoteConfigValues()
        }
        
    }
    
    func updateUIWithRemoteConfigValues() {
        let rc = RemoteConfig.remoteConfig()
        if let title = rc.configValue(forKey: Constants.LabelKeys.titleText).stringValue {
            self.titleLabel.text = title
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.openMovieList), userInfo: nil, repeats: false)

        }
    }
    
    @objc func openMovieList() {
        timer.invalidate()
        let vc = Storyboard.Main.instantiateViewController(withIdentifier: ViewController.Identifier.MovieNavigation)
        self.present(vc, animated: false, completion: nil)

    }

}
