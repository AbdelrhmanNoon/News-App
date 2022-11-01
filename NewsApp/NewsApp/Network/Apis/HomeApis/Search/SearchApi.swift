//
//  SearchApi.swift
//  NewsApp
//
//  Created by ABDO on 31/10/2022.
//

import Foundation
import Moya

enum SearchApis {
    case getSearchResultsFor(text: String)
}

extension SearchApis: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    var path: String {
        switch self {
        case .getSearchResultsFor:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearchResultsFor:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getSearchResultsFor(text: let searchText):
            return .requestParameters(parameters: ["country": UserDefaultsService.shared.country,
                                                   "category": UserDefaultsService.shared.favoriteCategory,
                                                   "q": searchText,
                                                   "sortBy": "publishedAt"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "X-Api-Key \(apiKey)",
                "Host": "newsapi.org"
        ]
    }
    
    var sampleData: Data {
        switch self {
        case .getSearchResultsFor:
            return "".data(using: .utf8)!
        }
    }

    var validate: Bool {
        return true
    }
    
    var authorizationType: AuthorizationType? {
        return .none
    }
}
