//
//  CollectionViewExtension.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//
import UIKit

extension CollectionViewTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: self.title[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = title[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APICaller.share.getYoutubeMovie(with: titleName ) {[weak self] result in
            switch result {
            case .success(let ytTitle):
                let title = self?.title[indexPath.row]
                guard let overview = title?.overview else {return}
                guard let strongSelf = self else {return}
                let vm = YoutubeReviewViewModel(titleLabel: titleName, overviewLabel: overview, youtubeView: ytTitle)
                self?.delegate?.collectionViewTableViewDidTapCell(_cell: strongSelf , model: vm)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){
            _ in
            let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) {
                _ in
               // to save it into coredata
                let model = self.title[indexPath.row]
                DataPersistenceManager.shared.downloadMovieWith(model: model) { result in
                    switch result {
                    case .success() :
                        NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                    case .failure(let error) :
                        print(error.localizedDescription)
                    }
                }
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
}
