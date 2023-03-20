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
    
}
