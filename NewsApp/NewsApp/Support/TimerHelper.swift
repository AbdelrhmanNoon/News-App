//
//  TimerHelper.swift
//  NewsApp
//
//  Created by ABDO on 01/11/2022.
//

import Foundation

class TimerHelper {
    
    private static var compareTime = Date()
    
    static var canFetchDataFromApi: Bool {
        if let difference = Calendar.current.dateComponents([.minute],
                                                            from: UserDefaultsService.shared.currentTime,
                                                            to: compareTime).minute {
            if difference > 30 {
                UserDefaultsProperties.currentTime = Date()
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
