//
//  UpComingTableViewCell.swift
//  netFlix
//
//  Created by Daniel on 1/28/24.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {
    
    static let identifier = "UpComingTableViewCell"
    
    private let ucTitle : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let ucImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private let ucButton : UIButton = {
        let btn = UIButton()
        btn.tintColor = .white
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ucTitle)
        contentView.addSubview(ucImageView)
        contentView.addSubview(ucButton)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            ucImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            ucImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            ucImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ucImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            ucTitle.leadingAnchor.constraint(equalTo: ucImageView.trailingAnchor, constant: 10),
            ucTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        ucButton.anchor(right: contentView.rightAnchor, paddingRight: 10)
        ucButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    public func configure(model: MovieViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.imagePath)") else {return}
        ucImageView.sd_setImage(with: url, completed: nil)
        ucTitle.text = model.titleName
    }
}
