//
//  ArticleRepository.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import Foundation
import Moya
import RxSwift

class ArticleRepository {
    
    // MARK: - properties
    private lazy var api: MoyaProvider = {
        return MoyaProvider <ArticlesApis>(plugins: [CachePolicyPlugin()])
    }()
    
    // get Articles from API
    func requestApi(page: Int) -> Observable<ServerObjectResponse<Article>> {
        
        return api.rx.request(.getArticles(page: page))
            .map(ServerObjectResponse.self)
            .do(onSuccess: { [weak self] articles in
                // Do somthing here
            })
            .asObservable()
    }
    
    let disposeBage = DisposeBag()

}
