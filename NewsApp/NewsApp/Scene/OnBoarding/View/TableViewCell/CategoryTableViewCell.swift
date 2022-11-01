//
//  CategoryTableViewCell.swift
//  NewsApp
//
//  Created by ABDO on 31/10/2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension CategoryTableViewCell {
    func configure(title: String) {
        self.categoryLabel.text = title
    }
}
