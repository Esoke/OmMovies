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
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    
    private var timer = Timer()
    private let initialTopConstraint = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityManager.shared.isReachable()
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
    }
    
    //MARK: - Remote Config
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            Constants.RemoteConfigKeys.titleText : "" as NSObject,
            Constants.RemoteConfigKeys.titleTopConstraint: initialTopConstraint as NSObject
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
        if let title = rc.configValue(forKey: Constants.RemoteConfigKeys.titleText).stringValue {
            self.titleLabel.text = title
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.openMovieList), userInfo: nil, repeats: false)
        }
        if let topConstraint = rc.configValue(forKey: Constants.RemoteConfigKeys.titleTopConstraint).numberValue?.doubleValue {
            self.titleTopConstraint.constant = CGFloat(topConstraint)
            self.animateLogo()
        }
    }
    
    @objc func openMovieList() {
        timer.invalidate()
        let vc = Storyboard.Main.instantiateViewController(withIdentifier: ViewController.Identifier.MovieNavigation)
        self.present(vc, animated: false, completion: nil)

    }

    func animateLogo() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 1.0) {
                self.titleLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.titleLabel.shadowColor = .lightGray
                self.titleLabel.shadowOffset = CGSize(width: 1, height: 1)
            }
        }
    }
}
