//
//  HeadLineTableViewCell.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import UIKit
import Kingfisher

class HeadLineTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var headlineDescLabel: UILabel!
    @IBOutlet private weak var headlineImage: UIImageView!
    @IBOutlet private weak var headlineSource: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Configure HeadLineTableViewCell
extension HeadLineTableViewCell {
    func configureWith(article: Article) {
        self.headlineDescLabel.text = article.title
        self.headlineSource.text = article.source.name
        let url = URL(string: article.urlToImage ?? "")
        self.headlineImage.kf.setImage(with: url)
    }
}
