//
//  SearchResultCollectionExtension.swift
//  netFlix
//
//  Created by Daniel on 2/3/24.
//
import UIKit

extension SearchResultViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath)
                as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movie[indexPath.row]
        cell.configure(with: movie.poster_path ?? "")
        return cell
    }
    
    
}
