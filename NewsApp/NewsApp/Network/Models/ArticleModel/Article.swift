//
//  Article.swift
//  NewsApp
//
//  Created by ABDO on 30/10/2022.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}
