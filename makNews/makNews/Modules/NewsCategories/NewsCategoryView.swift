//
//  ViewController.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit
import SwiftUI

class NewsCategoryView: UIViewController {
    
    private lazy var parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.addArrangedSubview(scrollView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(hStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addArrangedSubview(vStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 14
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(headlineCollectionView)
        stackView.addArrangedSubview(allGenreLabel)
        stackView.addArrangedSubview(genreCollectionView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allGenreLabel: UILabel = {
        let label = UILabel()
        label.text = "Semua Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Headline Berita"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    
    private lazy var genreCollectionView: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: NewsCategoryCollectionViewCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private lazy var headlineCollectionView: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: NewsCategoryCollectionViewCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    var presenter: NewsCategoryViewToPresenterProtocol?
    var newsCategory = NewsCategories.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            parentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            scrollView.topAnchor.constraint(equalTo: parentStackView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: parentStackView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor),

            hStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            genreCollectionView.heightAnchor.constraint(equalToConstant: (view.bounds.width - 32)),
            genreCollectionView.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
            genreCollectionView.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
            
            headlineCollectionView.heightAnchor.constraint(equalToConstant: (view.bounds.width - 32) * 3 / 2.5),
            headlineCollectionView.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
            headlineCollectionView.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),

        ])
        
        genreCollectionView.reloadData()
        headlineCollectionView.reloadData()
        
    }


}

extension NewsCategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return newsCategory.count
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCategoryCollectionViewCell.identifier, for: indexPath) as? NewsCategoryCollectionViewCell {
        cell.setup(category: newsCategory[indexPath.item])
        return cell
      }
      return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == genreCollectionView {
            self.presenter?.goToNewsSourceScreen(genre: newsCategory[indexPath.item].rawValue)
        }
    }
    
}

extension NewsCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 24.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 32
        let collectionWidth = collectionView.bounds.width - padding
        if collectionView == genreCollectionView {
            let width = collectionWidth / 3
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: collectionWidth, height: collectionWidth * 3 / 2.5)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension NewsCategoryView: NewsCategoryPresenterToViewProtocol {
    
}

