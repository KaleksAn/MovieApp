//
//  HeroHeaderUIView.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "mainImage")
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
