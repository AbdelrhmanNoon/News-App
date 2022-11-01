//
//  SearchRepository.swift
//  NewsApp
//
//  Created by ABDO on 31/10/2022.
//

import Foundation
import Moya
import RxSwift

class SearchRepository {
    
    // MARK: - properties
    private lazy var api: MoyaProvider = {
        return MoyaProvider <SearchApis>()
    }()
    
    // get SearchResults from API
    func requestApi(searchText: String) -> Observable<ServerObjectResponse<Article>> {
        return api.rx.request(.getSearchResultsFor(text: searchText))
            .map(ServerObjectResponse.self)
            .do(onSuccess: { [weak self] articles in
                // Do somthing here 
            })
            .asObservable()
    }

    let disposeBage = DisposeBag()

}
