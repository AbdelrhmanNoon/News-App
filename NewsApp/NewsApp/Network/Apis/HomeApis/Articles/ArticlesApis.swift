//
//  ArticlesApis.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import Moya

enum ArticlesApis {
    case getArticles(page: Int)
}

extension ArticlesApis: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    var path: String {
        switch self {
        case .getArticles:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getArticles(page: let pageNum):
            return .requestParameters(parameters: ["country": UserDefaultsService.shared.country,
                                                   "category": UserDefaultsService.shared.favoriteCategory,
                                                   "page": pageNum,
                                                   "pageSize": 70],
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
        case .getArticles:
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

extension ArticlesApis: CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .getArticles:
            if TimerHelper.canFetchDataFromApi {
                return .reloadIgnoringLocalCacheData
            } else {
                return .returnCacheDataElseLoad
            }
        }
    }
}
