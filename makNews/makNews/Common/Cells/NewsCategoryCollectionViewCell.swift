//
//  NewsCategoryCollectionViewCell.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit
import Kingfisher

class NewsCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCategoryCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(backgoundImageView)
        view.addSubview(titleLabel)
        return view
    }()
    
    private lazy var backgoundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            backgoundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgoundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgoundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgoundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupGenre(category: Categories) {
        titleLabel.text = category.rawValue
    }
    
    
    func setupHeadline(article: Article){
        backgoundImageView.isHidden = false
        titleLabel.text = article.title
        
        guard let stringUrl = article.urlToImage,
                let url = URL(string: stringUrl) else {
            return
        }
        backgoundImageView.kf.setImage(with: url, placeholder: UIImage().placeholder())
    }
    
}
