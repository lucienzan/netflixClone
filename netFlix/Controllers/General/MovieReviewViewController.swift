//
//  MovieReviewViewController.swift
//  netFlix
//
//  Created by Daniel on 2/3/24.
//

import UIKit
import WebKit

class MovieReviewViewController: UIViewController {

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
           let webView = WKWebView()
           webView.translatesAutoresizingMaskIntoConstraints = false
           return webView
       }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        configureConstraints();
    }

    private func configureConstraints() {
        webView.anchor(top: view.topAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingRight: 0, height: 300)
        titleLabel.anchor(top: webView.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 0 )
        downloadButton.anchor(top: overviewLabel.bottomAnchor, paddingTop: 25, width: 140, height: 40)
        downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    public func configure(with model : YoutubeReviewViewModel){
        titleLabel.text = model.titleLabel
        overviewLabel.text = model.overviewLabel
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        
        webView.load(URLRequest(url: url))
    }
}
