//
//  HomeViewController.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var sectionTitles: [String] = ["Trending Movies","Popular","Trending Tv","Upcoming Movies","Top Rated"];
    
    private let HomeTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure();
    }
    
    private func configure() {
        view.addSubview(HomeTableView)
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        HomeTableView.tableHeaderView = headerView
        
        // header logo
        var logoView =  UIImage(named: "logo")
        logoView = logoView?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoView, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        navigationController?.navigationBar.tintColor = .white
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HomeTableView.frame = view.bounds
    }
    
}
