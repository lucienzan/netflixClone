//
//  APICaller.swift
//  netFlix
//
//  Created by Daniel on 1/27/24.
//

import Foundation

struct Config {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path) else {
            fatalError("Unable to read Config.plist")
        }

        var format = PropertyListSerialization.PropertyListFormat.xml
        do {
            let config = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: &format) as! [String: Any]
            return config["APIKey"] as! String
        } catch {
            fatalError("Unable to parse Config.plist")
        }
    }
    
    static var youTubeApiKey: String {
        guard let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path) else {
            fatalError("Unable to read Config.plist")
        }

        var format = PropertyListSerialization.PropertyListFormat.xml
        do {
            let config = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: &format) as! [String: Any]
            return config["YoutubeAPI"] as! String
        } catch {
            fatalError("Unable to parse Config.plist")
        }
    }
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let share = APICaller()
    let url = "https://api.themoviedb.org"
    let ytUrl = "https://youtube.googleapis.com"
    
    func getTrendingMovies(completion : @escaping (Result<[Movie],Error>) -> Void) {
           guard let url = URL(string: "\(url)/3/trending/movie/day?api_key=\(Config.apiKey)") else {return}
           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
               data,_,error in
               guard let data = data, error == nil else {return}
               
               do{
                   let result = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                   completion(.success(result.results))
               }catch{
                   completion(.failure(APIError.failedToGetData))
               }
           }
           task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(url)/3/trending/tv/day?api_key=\(Config.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data,_,error in
            guard let data = data, error == nil else {return}
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(url)/3/movie/upcoming?api_key=\(Config.apiKey)&language=en-US&page=1") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(results.results))
                } catch {
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
        
        func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void) {
            guard let url = URL(string: "\(url)/3/movie/popular?api_key=\(Config.apiKey)&language=en-US&page=1") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(results.results))
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            
            task.resume()
        }
        
        func getTopRated(completion: @escaping (Result<[Movie], Error>) -> Void) {
            guard let url = URL(string: "\(url)/3/movie/top_rated?api_key=\(Config.apiKey)&language=en-US&page=1") else {return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(results.results))

                } catch {
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
        
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(url)/3/discover/movie?api_key=\(Config.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(results.results))
                } catch {
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
    
    func getSearchMovies(with query: String,completion: @escaping (Result<[Movie], Error>) -> Void) {
        // formatting query
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(url)/3/search/movie?api_key=\(Config.apiKey)&query=\(query)") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                    completion(.success(results.results))
                } catch {
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
    
    func getYoutubeMovie(with query: String,completion: @escaping (Result<ItemElements, Error>) -> Void) {
        // formatting query
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(ytUrl)/youtube/v3/search?q=\(query)&key=\(Config.youTubeApiKey)") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
//                    let checkResult = try JSONSerialization.jsonObject(with: data,options: .allowFragments)
//                    print(checkResult)
                  let results = try JSONDecoder().decode(YoutubeMovieResponse.self, from: data)
                    completion(.success(results.items[0]))
                } catch {
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
}
