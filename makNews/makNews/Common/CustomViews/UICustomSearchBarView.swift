//
//  UICustomSearchBarView.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

protocol UICustomSearchBarViewDelegate: AnyObject {
    func tapped()
}

class UICustomSearchBarView: UIView {
    
    lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 9.2
        hStack.alignment = .center
        hStack.addArrangedSubview(searchIcon)
        hStack.addArrangedSubview(textField)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView(image: UIImage(named: "iconsearch"))
        searchIcon.contentMode = .scaleAspectFill
        return searchIcon
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Color.shared.text
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.placeholder = "Search for articles and news sources"
        return textField
    }()
    
    weak var delegate: UICustomSearchBarViewDelegate?
    
    var changed: ((String) -> Void)?
    var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    private func setupViews() {
        backgroundColor = Color.shared.searchBar
        setCornerRadius(of: 8)
        addSubview(hStack)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            hStack.heightAnchor.constraint(equalToConstant: 41),
            searchIcon.widthAnchor.constraint(equalToConstant: 17.5),
            searchIcon.heightAnchor.constraint(equalToConstant: 17.5),
        ])
        configureClearButton()
    }
    
    private func configureClearButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "iconClose"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        textField.rightView = button
    }
    
    @objc private func clearButtonTapped(_ sender: UIButton) {
        textField.text = ""
        textField.sendActions(for: .editingChanged)
    }

    @objc private func performSearch(_ sender: Timer) {
        
    }
    
    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        delegate?.tapped()
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            textField.rightViewMode = text.isEmpty ? .never : .always
        }
        
        
        timer?.invalidate()  // Cancel any previous timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch(_:)), userInfo: nil, repeats: false)
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {[weak self] _ in
            self?.changed?(sender.text ?? "")
        })
    }
}
