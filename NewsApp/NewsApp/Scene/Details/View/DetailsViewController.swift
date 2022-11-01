//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var aricleImage: UIImageView!
    @IBOutlet private weak var articleTitle: UILabel!
    @IBOutlet private weak var articleDesc: UILabel!
    @IBOutlet private weak var articleSource: UILabel!
    @IBOutlet private weak var articleAuthor: UILabel!
    @IBOutlet private weak var showOriginalArticleButton: UIButton!
    
    // MARK: Properties
    private let bag = DisposeBag()
    private let viewModel = DetailsViewModel()
    var articles = BehaviorRelay<[Article]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Article Details"
        binding()
    }
    
    private func binding() {
        self.articles.subscribe(onNext: { [weak self] articles in
            guard let self = self,
            let article = articles.first else { return }
            let url = URL(string: article.urlToImage ?? "")
            self.aricleImage.kf.setImage(with: url)
            self.articleTitle.text = article.title
            self.articleDesc.text = article.description
            if let source = article.source.name,
               let author = article.author {
                self.articleAuthor.isHidden = false
                self.articleSource.isHidden = false
                self.articleSource.text = "Source: \(source)"
                self.articleAuthor.text = "Author: \(author)"
            }
           
        }).disposed(by: bag)
        
        self.showOriginalArticleButton.rx.tap.bind {
            let articleUrl = self.articles.value.first?.url ?? ""
            if let url = URL(string: articleUrl) {
                UIApplication.shared.open(url)
            }
        }.disposed(by: bag)
    }
}
