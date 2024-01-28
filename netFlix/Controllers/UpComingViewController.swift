//
//  UpComingViewController.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class UpComingViewController: UIViewController {
    
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return table
    }()
    
    public var titleModel : [Movie] = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        ucConfigure()
        fetchData()
    }

    private func ucConfigure() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchData() {
        APICaller.share.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let model):
                self?.titleModel = model
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
