//
//  HeroHeaderUIView.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = {
        let button = UIButton()
         button.setTitle("Download", for: .normal)
         button.layer.borderColor = UIColor.white.cgColor
         button.layer.borderWidth = 1
         button.layer.cornerRadius = 5
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "mainImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var buttonStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addGradient() {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradiantLayer.frame = bounds
        layer.addSublayer(gradiantLayer)
    }

    private func setupViews() {
        addSubview(heroImageView)
        addGradient()
        buttonStackView = UIStackView(arrangedSubviews: [playButton, downloadButton], axis: .horizontal, spacing:10)
        buttonStackView.contentMode = .scaleAspectFill
        //buttonStackView.alignment = .center
        addSubview(buttonStackView)
    }
    
}


extension HeroHeaderUIView {
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            playButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            buttonStackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}
