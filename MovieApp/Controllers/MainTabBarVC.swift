//
//  ViewController.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: UpcomingVC())
        let vc3 = UINavigationController(rootViewController: SearchVC())
        let vc4 = UINavigationController(rootViewController: DownloadsVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Home"
        vc2.title = "Coming soon"
        vc3.title = "Top Sarch"
        vc4.title = "Downloads"
        
        
        tabBar.tintColor = .label
        
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        
        
        
        
        
    }
    
    

}

