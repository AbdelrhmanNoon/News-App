//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class HomeViewModel: BaseViewModel {
    
    // MARK: - Properties
    let articleRepo: ArticleRepository = ArticleRepository()
    let searchRepo: SearchRepository = SearchRepository()
   // var articles: [Article] = []
    var isLoadingNextPage = BehaviorSubject<Bool>(value: false)
    var requestDisposable: Disposable!
    var showEmptyState = BehaviorRelay<Bool>(value: false)
    var articles = BehaviorRelay<[Article]>(value: [])
    var currentApiCallPage = 1
    
    // MARK: - Methods
    func getArticles() {
        requestDisposable = articleRepo.requestApi(page: currentApiCallPage)
            .subscribeWithDefaultErrorHandling(onSuccess: { [weak self] data in
                guard let self = self else { return }
                self.hideLoader()
                self.articles.accept(data.articles)
                
                if data.articles.isEmpty {
                    self.showEmptyState.accept(true)
                } else {
                    self.showEmptyState.accept(false)
                }
            }, onError: {_ in
                // we can handling error as we like for example: Alerts
                
            }, viewModel: self, errorMessageSize: MessageSize.large)
    }
    
    func getSearchResultsFor(text: String) {
        requestDisposable = searchRepo.requestApi(searchText: text)
            .subscribeWithDefaultErrorHandling(onSuccess: { [weak self] data in
                guard let self = self else { return }
                self.hideLoader()
                self.articles.accept(data.articles)
                if data.articles.isEmpty {
                    self.showEmptyState.accept(true)
                } else {
                    self.showEmptyState.accept(false)
                }
            }, onError: {_ in
                // we can handling error as we like for example: Alerts
                
            }, viewModel: self, errorMessageSize: MessageSize.large)
    }
    
}
