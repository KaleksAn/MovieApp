//
//  CustomTableViewCell.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomCellID"
    private var titles: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionVC.self, forCellWithReuseIdentifier: TitleCollectionVC.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
   
    public func configure(with titles: [Movie]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CustomTableViewCell: UICollectionViewDelegate {
    
}

extension CustomTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionVC.id, for: indexPath) as? TitleCollectionVC else {
            return UICollectionViewCell()
            
        }
        
        guard let model = titles[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        guard let titleName = title.title ?? title.originalTitle else { return }
        
        NetworkManager.shared.getMovie(with: titleName + "trailer") { result in
            switch result {
            case .success(let videoElement):
                print("ID VIDEO \(videoElement.id)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
