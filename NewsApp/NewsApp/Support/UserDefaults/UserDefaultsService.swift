//
//  UserDefaultsService.swift
//  BeutiCustomer
//
//  Created by Michele on 11/19/19.
//  Copyright © 2019 Michelle. All rights reserved.
//

import UIKit

class UserDefaultsService: NSObject {
    
    private enum UserDefaultsKey: String {
        case isFirstLaunch
        case favoriteCategory
        case country
        case currentTime
    }
    
    static var shared: UserDefaultsService = {
        return UserDefaultsService()
    }()
    
    // MARK: - access token
    var isFirstLaunch: Bool {
        UserDefaults.standard.object(forKey: UserDefaultsKey.isFirstLaunch.rawValue) != nil
    }
    
    var favoriteCategory: String {
        UserDefaults.standard.string(forKey: UserDefaultsKey.favoriteCategory.rawValue) ?? ""
    }
    
    var country: String {
        UserDefaults.standard.string(forKey: UserDefaultsKey.country.rawValue) ?? ""
    }
    
    var currentTime: Date {
        UserDefaults.standard.object(forKey: UserDefaultsKey.currentTime.rawValue) as? Date ?? Date()
    }
}
