//
//  SearchViewController.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    public var titleModel : [Movie] = [Movie]()

    public let sTableView : UITableView = {
        let tbl = UITableView();
        tbl.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tbl
    }()
    
    public let searchView : UISearchController = {
       let search  = UISearchController(searchResultsController: SearchResultViewController())
        search.searchBar.placeholder = "Search your favourite movies or Tv shows"
        search.searchBar.searchBarStyle = .minimal
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        sconfigure()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sTableView.frame = view.bounds
    }
    
    private func sconfigure() {
        view.addSubview(sTableView)
        sTableView.delegate = self
        sTableView.dataSource = self
        
        fetchData()
        navigationItem.searchController = searchView
        navigationController?.navigationBar.tintColor = .white
        searchView.searchResultsUpdater = self
    }
    
    private func fetchData() {
        APICaller.share.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let movie) :
                self?.titleModel = movie
                DispatchQueue.main.async {
                    self?.sTableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
