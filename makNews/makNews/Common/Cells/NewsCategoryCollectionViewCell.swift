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
    
    //MARK: TOP HEADLINES
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(headlineContainerView)
        view.addSubview(categoryContainerView)
        return view
    }()
    
    private lazy var headlineContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(backgoundImageView)
        view.addSubview(transparentView)
        view.addSubview(vStackView)
        return view
    }()
    
    private lazy var backgoundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var vStackView: UIView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(headLineTitleLabel)
        stackView.addArrangedSubview(headLineDescLabel)
        return stackView
    }()
    
    private lazy var headLineTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var headLineDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    
    //MARK: CATEGORIES
    private lazy var categoryContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addSubview(categoryIconImageView)
        view.addSubview(categoryTitleLabel)
        return view
    }()
    
    private lazy var categoryIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return imageView
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
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
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headlineContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headlineContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headlineContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headlineContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            backgoundImageView.topAnchor.constraint(equalTo: headlineContainerView.topAnchor),
            backgoundImageView.leadingAnchor.constraint(equalTo: headlineContainerView.leadingAnchor),
            backgoundImageView.trailingAnchor.constraint(equalTo: headlineContainerView.trailingAnchor),
            backgoundImageView.bottomAnchor.constraint(equalTo: headlineContainerView.bottomAnchor),
            
            transparentView.heightAnchor.constraint(equalToConstant: 180),
            transparentView.leadingAnchor.constraint(equalTo: headlineContainerView.leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: headlineContainerView.trailingAnchor),
            transparentView.bottomAnchor.constraint(equalTo: headlineContainerView.bottomAnchor),
            
            vStackView.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 16),
            vStackView.leadingAnchor.constraint(equalTo: headlineContainerView.leadingAnchor, constant: 16),
            vStackView.trailingAnchor.constraint(equalTo: headlineContainerView.trailingAnchor, constant: -16),
            vStackView.bottomAnchor.constraint(equalTo: headlineContainerView.bottomAnchor, constant: -12),
            
            
            
            categoryContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            categoryContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoryContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoryContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            categoryIconImageView.topAnchor.constraint(equalTo: categoryContainerView.topAnchor, constant: 12),
            categoryIconImageView.trailingAnchor.constraint(equalTo: categoryContainerView.trailingAnchor, constant: -12),
            
            categoryTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: categoryContainerView.trailingAnchor, constant: -8),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: categoryContainerView.bottomAnchor, constant: -8),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryContainerView.leadingAnchor, constant: 8),
            
        ])
    }
    
    func setupGenre(category: Categories) {
        headlineContainerView.isHidden = true
        categoryContainerView.isHidden = false
        categoryTitleLabel.text = category.rawValue
        categoryIconImageView.image = category.icon
        categoryContainerView.backgroundColor = category.bgColor
    }
    
    
    func setupHeadline(article: Article){
        headlineContainerView.isHidden = false
        categoryContainerView.isHidden = true
        headLineTitleLabel.text = article.title
        headLineDescLabel.text = article.content
        
        guard let stringUrl = article.urlToImage,
                let url = URL(string: stringUrl) else {
            return
        }
        backgoundImageView.kf.setImage(with: url, placeholder: UIImage().placeholder())
    }
    
}
