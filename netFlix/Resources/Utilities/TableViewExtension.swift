//
//  TableViewExtension.swift
//  netFlix
//
//  Created by Daniel on 1/21/24.
//

import UIKit

extension HomeViewController : UITableViewDelegate, UITableViewDataSource, CollectionViewTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.reuseIdentifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovie.rawValue:
            APICaller.share.getTrendingMovies { result in
                switch result{
                case .success(let movie) :
                    cell.configure(model: movie)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.share.getTrendingTvs { result in
                switch result{
                case .success(let movie) :
                    cell.configure(model: movie)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.share.getPopular { result in
                switch result{
                case .success(let movie) :
                    cell.configure(model: movie)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.share.getUpcomingMovies { result in
                switch result{
                case .success(let movie) :
                    cell.configure(model: movie)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.share.getTopRated { result in
                switch result{
                case .success(let movie) :
                    cell.configure(model: movie)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // Header Title section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 14, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // set the top nav bar not sticky
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func collectionViewTableViewDidTapCell(_cell: CollectionViewTableViewCell, model: YoutubeReviewViewModel) {
        DispatchQueue.main.async{
            [weak self] in
            let vc = MovieReviewViewController();
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
