//
//  DataPersistenceManager.swift
//  netFlix
//
//  Created by Daniel on 2/4/24.
//

import CoreData
import UIKit

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    enum DataBaseError : Error {
        case failedTosave
        case failedTofetch
        case failedTodelete
    }
    
    func downloadMovieWith(model: Movie, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.media_type = model.media_type
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            print(error.localizedDescription)
            completion(.failure(DataBaseError.failedTosave))
        }
    }
    
    func fetchData(completion: @escaping(Result<[TitleItem],Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        do {
            let movie = try context.fetch(request)
            completion(.success(movie))
        } catch {
            completion(.failure(DataBaseError.failedTofetch))
        }
    }
    
    func deleteData(model: TitleItem,completion: @escaping(Result<Void,Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedTodelete))
        }
    }
}
