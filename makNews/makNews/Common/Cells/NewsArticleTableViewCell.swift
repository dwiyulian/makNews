//
//  NewsArticleTableViewCell.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit
import Kingfisher

class NewsArticleTableViewCell: UITableViewCell {

    static let identifier = "NewsArticleCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.setCornerRadius(of: 8)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        view.addSubview(parentStackView)
        return view
    }()
    
    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.addArrangedSubview(articleImageView)
        stackView.addArrangedSubview(parentView)
        return stackView
    }()
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setCornerRadius(of: 8)
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private lazy var parentView: UIView = {
        let view = UIView()
        view.addSubview(hStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.addArrangedSubview(vStackView)
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(dateLabel)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textColor = Color.shared.text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.shared.secondText
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        selectionStyle = .none
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            parentStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            parentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            hStackView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 4),
            hStackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 4),
            hStackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -4),
            hStackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 4),
            
            dateLabel.bottomAnchor.constraint(equalTo: vStackView.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(article: Article){
        self.titleLabel.text = article.title
        self.descLabel.text = article.content
        self.dateLabel.text = article.publishedAt?.toDateFormat()
        
        guard let stringUrl = article.urlToImage,
                let url = URL(string: stringUrl) else {
                    articleImageView.image = UIImage().placeholder()
            return
        }
        articleImageView.kf.setImage(with: url, placeholder: UIImage().placeholder())
    }

}
