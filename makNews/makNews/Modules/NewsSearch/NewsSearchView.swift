//
//  NewsSearchView.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

class NewsSearchView: BaseViewController {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.addArrangedSubview(headerContainerView)
        stackView.addArrangedSubview(hStackView)
        stackView.addArrangedSubview(resultTableView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.addSubview(searchBar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    lazy var searchBar: UICustomSearchBarView = {
        let searchBar = UICustomSearchBarView()
        searchBar.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return searchBar
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.addArrangedSubview(newsArticleButton)
        stackView.addArrangedSubview(newsSourceButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stackView
    }()
    
    private lazy var newsArticleButton: UICustomButtonView = {
        let button = UICustomButtonView()
        button.setTitle("Article", for: .normal)
        button.setSelected()
        button.addTarget(self, action: #selector(didTapArticle(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var newsSourceButton: UICustomButtonView = {
        let button = UICustomButtonView()
        button.setTitle("Sources", for: .normal)
        button.setNormal()
        button.addTarget(self, action: #selector(didTapNewsSource(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsSourceTableViewCell.self, forCellReuseIdentifier: NewsSourceTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var isSearchByArticle: Bool = true
    var presenter: NewsSearchViewToPresenterProtocol?
    var articleResults = [Article]()
    var newsSourceResults = [Sources]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addKeyboardDismissalListener()
        self.title = "Search"
        self.view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            searchBar.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),

        ])
    }
    
    private func doSearch(keyword: String?){
        guard let text = keyword, !text.isEmpty else {
            self.newsSourceResults = []
            self.articleResults = []
            self.resultTableView.reloadData()
            return
        }
        
        if isSearchByArticle {
            self.presenter?.searchNewsArticle(by: text)
        }else{
            self.presenter?.searchNewsSource(by: text)
        }
    }

}

extension NewsSearchView {
    @objc func didTapArticle(_ sender: UIButton){
        isSearchByArticle = true
        newsArticleButton.setSelected()
        newsSourceButton.setNormal()
        doSearch(keyword: searchBar.textField.text)
        
    }
    
    @objc func didTapNewsSource(_ sender: UIButton){
        isSearchByArticle = false
        newsArticleButton.setNormal()
        newsSourceButton.setSelected()
        doSearch(keyword: searchBar.textField.text)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        doSearch(keyword: textField.text)
    }
}

extension NewsSearchView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchByArticle == true ? articleResults.count : newsSourceResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourceTableViewCell.identifier, for: indexPath) as? NewsSourceTableViewCell {
//          cell.setup(source: newsSources[indexPath.row])
            
            let text = isSearchByArticle == true ? articleResults[indexPath.row].title : newsSourceResults[indexPath.row].name
            
            
            cell.textLabel?.text = text
            
          return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchByArticle {
            let article = self.articleResults[indexPath.row]
            self.presenter?.goToArticleWebScreen(article: article)
        }else{
            let source = self.newsSourceResults[indexPath.row]
            self.presenter?.goToNewsArticlesScreen(source: source)
        }
    }
}

extension NewsSearchView: NewsSearchPresenterToViewProtocol {
    func successFetchedNewsSources(sources: [Sources]) {
        self.newsSourceResults = sources
        self.resultTableView.reloadData()
    }
    
    func successFetchedNewsArticles(articles: [Article]) {
        self.articleResults = articles
        self.resultTableView.reloadData()
    }
    
    func handleErrorFetched() {
        showAlert("Fetch data failed!")
    }
    
    
}
