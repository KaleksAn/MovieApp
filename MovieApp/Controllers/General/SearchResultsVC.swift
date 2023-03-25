//
//  SearchResultsVC.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 20/03/23.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
    func searchVCDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsVC: UIViewController {
    
    weak var delegate: SearchResultsVCDelegate?
    
    var movies: [Movie] = [Movie]()
    
     let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionVC.self, forCellWithReuseIdentifier: TitleCollectionVC.id)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    

}


extension SearchResultsVC: UICollectionViewDelegate {
    
}

extension SearchResultsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //movies.count
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionVC.id, for: indexPath) as? TitleCollectionVC else { return UICollectionViewCell() }
        let movie = movies[indexPath.row]
        cell.configure(with: movie.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = movies[indexPath.row]
        let titleName = title.title ?? " " 
        NetworkManager.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let element):
                self?.delegate?.searchVCDidTapItem(TitlePreviewViewModel(title: titleName, youtubeView: element, titleOverview: title.overview ?? ""))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
