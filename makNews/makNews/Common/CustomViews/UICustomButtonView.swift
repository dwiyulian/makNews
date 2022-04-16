//
//  UICustomButtonView.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

class UICustomButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    private func setupViews() {
        setNormal()
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        translatesAutoresizingMaskIntoConstraints = false
        contentEdgeInsets = UIEdgeInsets(
            top: 12,
            left: 24,
            bottom: 12,
            right: 24)
        
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setNormal() {
        backgroundColor = .white
        setTitleColor(.systemBlue, for: .normal)
    }
    
    func setSelected() {
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
    }
}
