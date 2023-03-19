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
    
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(Constants.mainURL)3/trending/all/day?api_key=\(Constants.apiKey)") else { return }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
}
