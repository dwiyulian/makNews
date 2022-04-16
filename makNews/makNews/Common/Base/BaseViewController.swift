//
//  BaseViewController.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit
import NVActivityIndicatorView
import SwiftUI

class BaseViewController: UIViewController {
    
    var hudView: NVActivityIndicatorView!
    lazy var backgroundHudView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showAlert(_ message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: Configure Activity Indicator
extension BaseViewController {
    func initHUD(withView: UIView){
        let padding = max(withView.frame.width / 8, withView.frame.height / 8)
        
        hudView = NVActivityIndicatorView(frame: withView.frame, type: .ballClipRotate, color: .systemBlue, padding: padding)
        hudView.translatesAutoresizingMaskIntoConstraints = false
        hudView.backgroundColor  = .white
    }
    
    func showProgressHUD(isTransparent: Bool = false, withView: UIView? = nil){
        
        let contentView: UIView = {
            guard let _withView = withView else {
                return self.view
            }
            return _withView
        }()
        
        if hudView == nil {
            initHUD(withView: contentView)
        }
        
        let color = isTransparent ? UIColor.white.withAlphaComponent(0.5): UIColor.white
        
        backgroundHudView.backgroundColor = color
        hudView.backgroundColor = .clear
        
        if !(contentView.subviews.contains(hudView)) {
            contentView.addSubview(backgroundHudView)
            contentView.addSubview(hudView)
            
            hudView.centerXAnchor
                .constraint(equalTo: contentView.centerXAnchor)
                .isActive = true
            hudView.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor, constant: -30)
                .isActive = true
            if UIDevice.current.userInterfaceIdiom == .pad {
                hudView.widthAnchor
                    .constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
                    .isActive = true
            } else {
                hudView.widthAnchor
                    .constraint(equalTo: contentView.widthAnchor, multiplier: 0.35)
                    .isActive = true
            }
            
            hudView.heightAnchor
                .constraint(equalTo:hudView.widthAnchor)
                .isActive = true
            backgroundHudView.centerXAnchor
                .constraint(equalTo: contentView.centerXAnchor)
                .isActive = true
            backgroundHudView.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor)
                .isActive = true
            backgroundHudView.widthAnchor
                .constraint(equalTo: contentView.widthAnchor)
                .isActive = true
            backgroundHudView.heightAnchor
                .constraint(equalTo: contentView.heightAnchor)
                .isActive = true
        }
        hudView.alpha = 1
        backgroundHudView.alpha = 1
        hudView.startAnimating()
        hudView.layer.speed = 0.7
    }
    
    func hideProgressHUD(withView: UIView? = nil){
        if hudView == nil { return}
        
        let contentView: UIView = {
            guard let _withView = withView else {
                return self.view
            }
            return _withView
        }()
        
        guard contentView.subviews.contains(hudView) else { return }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.hudView.alpha = 0
            self.backgroundHudView.alpha = 0
        }) { (completed) in
            guard completed else { return }
            self.hudView.stopAnimating()
            self.hudView.removeFromSuperview()
            self.backgroundHudView.removeFromSuperview()
        }
    }
}

//MARK: Configure Nagivation Bar
extension BaseViewController {
    func configureNavigationBar(withSearch: Bool = false, delegate: UICustomSearchBarViewDelegate?){
        let imaageIcon = UIImageView()
        imaageIcon.image = UIImage(named: "iconMakNews")
        
        let title = UILabel()
        title.text = "MAKNEWS"
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = .systemBlue
        
        let titleStack = UIStackView()
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.alignment = .center
        titleStack.addArrangedSubview(imaageIcon)
        titleStack.addArrangedSubview(title)
        
        let titileBarItem = UIBarButtonItem(customView: titleStack)
        
        let searchBar = UICustomSearchBarView()
        searchBar.delegate = delegate
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.textField.isEnabled = false
        
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        
        
        if withSearch {
            navigationItem.setLeftBarButton(searchBarItem, animated: true)
        } else {
            navigationItem.setLeftBarButton(titileBarItem, animated: true)
        }
        
        NSLayoutConstraint.activate([
            imaageIcon.widthAnchor.constraint(equalToConstant: 32),
            imaageIcon.heightAnchor.constraint(equalToConstant: 32),
            
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
