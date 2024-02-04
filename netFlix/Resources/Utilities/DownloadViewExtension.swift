//
//  DownloadViewExtension.swift
//  netFlix
//
//  Created by Daniel on 2/4/24.
//
import UIKit

extension DownloadViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleModel.count
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete :
            DataPersistenceManager.shared.deleteData(model: titleModel[indexPath.row]) { [weak self] result in
                switch result {
                case .success() : break
                case .failure(let error):
                    print (error.localizedDescription)
                }
                self?.titleModel.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
         default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titleModel[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APICaller.share.getYoutubeMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let movie) :
                DispatchQueue.main.async {
                    let vc = MovieReviewViewController()
                    vc.configure(with: YoutubeReviewViewModel(titleLabel: titleName, overviewLabel: title.overview ?? "", youtubeView: movie))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
