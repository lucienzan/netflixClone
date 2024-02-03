//
//  SearchTableViewExtension.swift
//  netFlix
//
//  Created by Daniel on 1/28/24.
//

import UIKit

extension SearchViewController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleModel.count
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
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchbar = searchView.searchBar
        guard let query = searchbar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchView.searchResultsController as? SearchResultViewController else {
            return
        }
        APICaller.share.getSearchMovies(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie) :
                    resultController.movie = movie
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let error) :
                    return print(error.localizedDescription)
                }
            }
        }
    }
}