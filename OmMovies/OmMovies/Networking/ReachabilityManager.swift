//
//  ReachabilityManager.swift
//  OmMovies
//
//  Created by Esma on 2/24/19.
//  Copyright © 2019 Esma Goktekin Ornek. All rights reserved.
//

import Foundation
import Alamofire

public final class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    private init() { }

    private let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    func isReachable() {
        self.networkReachabilityManager?.listener = { status in
            print("Network Status: \(status)")
            switch status {
            case .notReachable:
                let alert = UIAlertController(title: "Ops!", message: "Please check your internet connection.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                print("not reachable")
            case .reachable(_), .unknown:
                print("reachable")
            }
        }
        
        self.networkReachabilityManager?.startListening()
    }
}
