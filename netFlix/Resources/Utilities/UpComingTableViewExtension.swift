//
//  UpComingTableViewExtension.swift
//  netFlix
//
//  Created by Daniel on 1/28/24.
//

import UIKit

extension UpComingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else {return UITableViewCell()}
        guard let title = titleModel[indexPath.row].original_title else { return UITableViewCell() }
        guard let path = titleModel[indexPath.row].poster_path else { return UITableViewCell() }
        cell.configure(model: MovieViewModel(titleName: title, imagePath: path))
         return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
