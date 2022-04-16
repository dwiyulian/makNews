//
//  NewsSourceView.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit
import UIScrollView_InfiniteScroll

class NewsSourceView: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsSourceTableViewCell.self, forCellReuseIdentifier: NewsSourceTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    var presenter: NewsSourceViewToPresenterProtocol?
    var genre: String = ""
    var newsSources = [Sources]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupEndlessScroll()
        presenter?.searchForNewsSource(genre: genre)
    }
    
    private func setupViews(){
        self.title = genre
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
            self.presenter?.loadMoreNewsSource()
        }
    }
}

extension NewsSourceView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourceTableViewCell.identifier, for: indexPath) as? NewsSourceTableViewCell {
          cell.setup(source: newsSources[indexPath.row])
          return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = self.newsSources[indexPath.row]
        self.presenter?.goToNewsArticlesScreen(source: source)
    }
    
    
}

extension NewsSourceView: NewsSourcePresenterToViewProtocol {
    func successFetchedNewsSource(sources: [Sources]) {
        self.newsSources = sources
        self.tableView.reloadData()
    }
    
    func successLoadMoreNewsSource(sources: [Sources]) {
        tableView.finishInfiniteScroll()
        
        let sourceCount = newsSources.count
        let (start, end) = (sourceCount, sources.count + sourceCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        newsSources.append(contentsOf: sources)
        
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

