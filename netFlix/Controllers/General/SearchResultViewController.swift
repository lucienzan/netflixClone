//
//  SearchResultViewController.swift
//  netFlix
//
//  Created by Daniel on 2/3/24.
//

import UIKit

protocol SeachResultDelegateProtocal: AnyObject {
    func searchViewTableViewDidTapCell(model: YoutubeReviewViewModel)
}

class SearchResultViewController: UIViewController {

    public var movie : [Movie] = [Movie]()
    
    public weak var delegate : SeachResultDelegateProtocal?

    public let searchResultCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 26, height: 200)
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
}
