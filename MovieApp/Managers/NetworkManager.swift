//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 19/03/23.
//

import Foundation

struct Constants {
    static let apiKey = "b47a006f4fb883b986de068dbb1a36c5"
    static let mainURL = "https://api.themoviedb.org/"
    static let youtubeKey = "AIzaSyDzx4GTUWZN9eI0spDADl5cJXKAYFXaNHE"
    static let youtubeMainUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/trending/movie/day?api_key=\(Constants.apiKey)&language=ru-RU&page=1") else { return }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
    func getTrandingTv(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/trending/tv/day?api_key=\(Constants.apiKey)&language=ru-RU&page=1") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
        
        
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/movie/upcoming?api_key=\(Constants.apiKey)&language=ru-RU&page=1") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
    func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/movie/popular?api_key=\(Constants.apiKey)&language=ru-RU&page=1") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
         
    }
    
    func getTopRated(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/movie/top_rated?api_key=\(Constants.apiKey)&language=ru-RU&page=1") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/discover/movie?api_key=\(Constants.apiKey)&language=ru-RU&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()

    }
    
    
    func search(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.mainURL)3/search/movie?api_key=\(Constants.apiKey)&query=\(query)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoObject, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeMainUrl)?location=russia&q=\(query)&key=\(Constants.youtubeKey)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    completion(.success(result.items[0]))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
}



