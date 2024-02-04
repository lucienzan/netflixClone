//
//  HeaderView.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    private func button(text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heroImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        stackView.addArrangedSubview(button(text: "Play"))
        stackView.addArrangedSubview(button(text: "Download"))
        addSubview(stackView)
        constraint()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           updateGradientFrame()
       }
    
    func constraint() {
        let playBtn = stackView.arrangedSubviews.first as? UIButton
        playBtn?.anchor(width: 100, height: 40)
        let downloadBtn = stackView.arrangedSubviews.last as? UIButton
        downloadBtn?.anchor(width: 150, height: 40)
        
        imageView.anchor(top: topAnchor,left: leftAnchor, bottom: bottomAnchor, right: rightAnchor ,paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60)
        ])
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradient)
        updateGradientFrame()
    }
    
    func updateGradientFrame() {
            let gradient = layer.sublayers?.first { $0 is CAGradientLayer } as? CAGradientLayer
            gradient?.frame = bounds
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderView(with model: MovieViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.imagePath)") else {return}
        imageView.sd_setImage(with: url, completed: nil)
    }
}
