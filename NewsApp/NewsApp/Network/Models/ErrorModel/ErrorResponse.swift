//
//  ErrorResponse.swift
//  Cars Demo
//
//  Created by ABDO on 24/02/2022.
//

import Foundation

struct ErrorResponse: Codable {
    let error: Bool
    let errors: [ErrorModel]
}
