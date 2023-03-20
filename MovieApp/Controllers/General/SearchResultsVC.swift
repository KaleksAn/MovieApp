//
//  SearchResultsVC.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 20/03/23.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    private var movies: [Movie] = [Movie]()
    
    private let searchResultsCollectionView: UICollectionView = {
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionVC.id, for: indexPath) as? TitleCollectionVC else { return UICollectionViewCell() }
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
