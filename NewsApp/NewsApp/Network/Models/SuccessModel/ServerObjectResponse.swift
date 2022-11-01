//
//  ServerObjectResponse.swift
//  Cars Demo
//
//  Created by ABDO on 25/02/2022.
//

import Foundation

struct ServerObjectResponse<T: Codable>: Codable {
    let status : String?
    let totalResults : Int?
    let articles : [T]
}
