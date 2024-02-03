//
//  CollectionViewTableViewCell.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewDidTapCell(_cell: CollectionViewTableViewCell, model: YoutubeReviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "collectionViewCell"
    
    weak var delegate : CollectionViewTableViewCellDelegate?
    
    public var title: [Movie] = [Movie]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(model: [Movie]) {
        self.title = model
        DispatchQueue.main.async{
            [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
