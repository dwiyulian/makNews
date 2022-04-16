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
    
    private lazy var tableContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleTableView)
        view.addSubview(sourceTableView)
        return view
    }()
    
    private lazy var articleTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: NewsArticleTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var sourceTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsSourceTableViewCell.self, forCellReuseIdentifier: NewsSourceTableViewCell.identifier)
        tableView.separatorStyle = .none
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
        setupEndlessScroll()
    }
    
    private func setupView() {
        self.addKeyboardDismissalListener()
        self.title = "Search"
        self.view.backgroundColor = .white
        self.sourceTableView.isHidden = true
    }
    
    private func setupConstraints() {
        view.addSubview(mainStackView)
        view.addSubview(tableContainerView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableContainerView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            tableContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            articleTableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor),
            articleTableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor),
            articleTableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor),
            articleTableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor),
            
            sourceTableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor),
            sourceTableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor),
            sourceTableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor),
            sourceTableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),

        ])
    }
    
    private func setupEndlessScroll(){
        articleTableView.addInfiniteScroll { (table) in
            self.presenter?.loadMoreNewsArticles()
        }
        
        sourceTableView.addInfiniteScroll { (table) in
            self.presenter?.loadMoreNewsSource()
        }
    }
    
    private func doSearch(keyword: String?){
        guard let text = keyword, !text.isEmpty else {
            self.newsSourceResults = []
            self.articleResults = []
            self.articleTableView.reloadData()
            self.sourceTableView.reloadData()
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
        articleTableView.isHidden = false
        sourceTableView.isHidden = true
        doSearch(keyword: searchBar.textField.text)
        
    }
    
    @objc func didTapNewsSource(_ sender: UIButton){
        isSearchByArticle = false
        newsArticleButton.setNormal()
        newsSourceButton.setSelected()
        articleTableView.isHidden = true
        sourceTableView.isHidden = false
        doSearch(keyword: searchBar.textField.text)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        doSearch(keyword: textField.text)
    }
}

extension NewsSearchView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == articleTableView ? articleResults.count : newsSourceResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == articleTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleTableViewCell.identifier, for: indexPath) as? NewsArticleTableViewCell {
                cell.setup(article: articleResults[indexPath.row])
              return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourceTableViewCell.identifier, for: indexPath) as? NewsSourceTableViewCell {
                cell.setup(source: newsSourceResults[indexPath.row])
              return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == articleTableView {
            let article = self.articleResults[indexPath.row]
            self.presenter?.goToArticleWebScreen(article: article)
        }else{
            let source = self.newsSourceResults[indexPath.row]
            self.presenter?.goToNewsArticlesScreen(source: source)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == articleTableView ? 140 : 90
    }
}

extension NewsSearchView: NewsSearchPresenterToViewProtocol {
    func successLoadMoreNewsArticles(articles: [Article]) {
        articleTableView.finishInfiniteScroll()
        
        let articleCount = articleResults.count
        let (start, end) = (articleCount, articles.count + articleCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        articleResults.append(contentsOf: articles)
        
        self.articleTableView.beginUpdates()
        self.articleTableView.insertRows(at: indexPaths, with: .automatic)
        self.articleTableView.endUpdates()
    }
    
    func successLoadMoreNewsSource(sources: [Sources]) {
        sourceTableView.finishInfiniteScroll()
        
        let sourceCount = newsSourceResults.count
        let (start, end) = (sourceCount, sources.count + sourceCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        newsSourceResults.append(contentsOf: sources)
        
        self.sourceTableView.beginUpdates()
        self.sourceTableView.insertRows(at: indexPaths, with: .automatic)
        self.sourceTableView.endUpdates()
    }
    
    func successFetchedNewsSources(sources: [Sources]) {
        self.newsSourceResults = sources
        self.sourceTableView.reloadData()
    }
    
    func successFetchedNewsArticles(articles: [Article]) {
        self.articleResults = articles
        self.articleTableView.reloadData()
    }
    
    func handleErrorFetched() {
        showAlert("Fetch data failed!")
    }
    
    
}
