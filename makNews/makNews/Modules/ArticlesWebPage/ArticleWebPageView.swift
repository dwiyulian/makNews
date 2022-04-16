//
//  ArticleWebPageView.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit
import WebKit

class ArticleWebPageView: BaseViewController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
        loadWebPage()
        
    }
    
    private func setupView(){
        self.view.backgroundColor = .white
        self.title = article?.title
    }
    
    private func loadWebPage(){
        guard let urlString = article?.url, let url = URL(string: urlString) else {
            return
        }
        showProgressHUD()
        webView.load(URLRequest(url: url))
    }
    
    private func setupConstrains(){
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ArticleWebPageView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgressHUD()
    }
}

extension ArticleWebPageView: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

