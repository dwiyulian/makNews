//
//  NewsSourceTableViewCell.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit

class NewsSourceTableViewCell: UITableViewCell {
    static let identifier = "NewsSourceCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(source: Sources){
        self.textLabel?.text = source.name
    }
    
}
