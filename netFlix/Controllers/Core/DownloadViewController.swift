//
//  DownloadViewController.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return table
    }()
    
    public var titleModel : [TitleItem] = [TitleItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource =  self
        fetchData()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchData()
        }
    }

    public func fetchData() {
        DataPersistenceManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let items) :
                self?.titleModel = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
