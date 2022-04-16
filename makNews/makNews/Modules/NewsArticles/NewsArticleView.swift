//
//  NewsArticleView.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit
import UIScrollView_InfiniteScroll

class NewsArticleView: BaseViewController {

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsSourceTableViewCell.self, forCellReuseIdentifier: NewsSourceTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: NewsArticleViewToPresenterProtocol?
    var source: Sources?
    var newsArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupEndlessScroll()
        presenter?.searchForNewsArticles(sourceId: source?.id ?? "")
    }
    
    private func setupView(){
        self.title = source?.name
        self.view.backgroundColor = .white
    }
    
    private func setupConstraints(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupEndlessScroll(){
        tableView.addInfiniteScroll { (table) in
            self.presenter?.loadMoreNewsArticles()
        }
    }

}

extension NewsArticleView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourceTableViewCell.identifier, for: indexPath) as? NewsSourceTableViewCell {
          //cell.setup(source: newsSources[indexPath.row])
            cell.textLabel?.text = self.newsArticles[indexPath.row].title
          return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.newsArticles[indexPath.row]
        self.presenter?.goToArticleWebScreen(article: article)
    }
    
}

extension NewsArticleView: NewsArticlePresenterToViewProtocol {
    func successFetchedNewsArticles(articles: [Article]) {
        self.newsArticles = articles
        self.tableView.reloadData()
    }
    
    func successLoadMoreNewsArticles(articles: [Article]) {
        tableView.finishInfiniteScroll()
        
        let articleCount = newsArticles.count
        let (start, end) = (articleCount, articles.count + articleCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        newsArticles.append(contentsOf: articles)
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
    }
    
    func handleErrorFetched() {
        showAlert("Failed load data!")
    }
    
    func showActivityIndicator() {
        showProgressHUD()
    }
    
    func hideActivityIndicator() {
        hideProgressHUD()
    }
    
}
