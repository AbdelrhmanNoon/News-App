//
//  UserDefaultsProperties.swift
//  Muhlah
//
//  Created by AbdulrhmanNoon on 10/28/20.
//

import Foundation

struct UserDefaultsProperties {
    
    // MARK: - Properties
    @UserDefault("isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
    
    @UserDefault("favoriteCategory", defaultValue: "")
    static var favoritCategory: String
    
    @UserDefault("country", defaultValue: "")
    static var country: String
    
    @UserDefault("currentTime", defaultValue: Date())
    static var currentTime: Date
    
}
