//
//  ViewController.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers(viewControllerList(), animated: true)
    }

    // MARK: - controller list
    private func viewControllerList() -> Array<UIViewController> {
        let homeViewControl = UINavigationController(rootViewController: HomeViewController())
        let downloadViewControl = UINavigationController(rootViewController: DownloadViewController())
        let searchViewControl = UINavigationController(rootViewController: SearchViewController())
        let upComingViewControl = UINavigationController(rootViewController: UpComingViewController())
        let viewControllerList: Array<UIViewController> = [homeViewControl,upComingViewControl,searchViewControl,downloadViewControl]
        
        homeViewControl.tabBarItem.image = UIImage(systemName: "house")
        upComingViewControl.tabBarItem.image = UIImage(systemName: "play.circle")
        searchViewControl.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadViewControl.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeViewControl.title = "Home"
        upComingViewControl.title = "Coming Soon"
        searchViewControl.title = "Top Search"
        downloadViewControl.title = "Downloads"
        
        tabBar.tintColor = .label
        return viewControllerList
    }

}

