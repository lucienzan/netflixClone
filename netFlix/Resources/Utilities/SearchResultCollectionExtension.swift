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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movie[indexPath.row]
        guard let title = movie.original_title ?? movie.original_name else {return}
        APICaller.share.getYoutubeMovie(with: title) { [weak self] result in
            switch result {
            case .success(let resultMovie) :
                let vm = YoutubeReviewViewModel(titleLabel: title, overviewLabel: movie.overview ?? "", youtubeView: resultMovie)
                self?.delegate?.searchViewTableViewDidTapCell(model: vm)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
