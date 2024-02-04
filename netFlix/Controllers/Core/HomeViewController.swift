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
    
    public var headerTitle: Movie?
    public var headerView: HeaderView?
    
    enum Sections : Int {
        case TrendingMovie = 0
        case TrendingTv = 1
        case Popular = 2
        case Upcoming = 3
        case TopRated = 4
    }
    
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
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        HomeTableView.tableHeaderView = headerView
        configureHeaderTitle()
        // header logo
        var logoView =  UIImage(named: "logo")
        logoView = logoView?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoView, style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureHeaderTitle() {
        APICaller.share.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movie) :
                let title = movie.randomElement()
                self?.headerTitle = title
                self?.headerView?.configureHeaderView(with: MovieViewModel(titleName: title?.original_title ?? "", imagePath: title?.poster_path ?? ""))
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HomeTableView.frame = view.bounds
    }
    
}
