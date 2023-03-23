//
//  UpcomingVC.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

class UpcomingVC: UIViewController {
    
    private var movies: [Movie] = [Movie]()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUpcoming()
        setupDelegates()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Скоро"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(upcomingTable)
    }
    
    private func setupDelegates() {
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    }
    
    private func fetchUpcoming() {
        NetworkManager.shared.getUpcomingMovies { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let result):
                strongSelf.movies = result
                DispatchQueue.main.async {
                    strongSelf.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

//MARK: - UITableViewDelegate
extension UpcomingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}


//MARK: - UITableViewDataSource
extension UpcomingVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.id, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.configure(with: MovieViewModel(titleName: (movie.title) ?? "Unknow name", posterURL: movie.posterPath ?? ""))
        return cell
    }
    
    
}
