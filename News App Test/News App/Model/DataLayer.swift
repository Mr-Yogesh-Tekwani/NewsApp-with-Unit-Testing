//
//  DataLayer.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import Foundation

struct AllData: Codable {
    let availableStatus:  String?
    let resultsCount: Int?
    var allArticles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case availableStatus = "status"
        case resultsCount = "totalResults"
        case allArticles = "articles"
    }
}

struct Article: Codable{
    let source: Source?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    
}

struct Source: Codable {
    let name: String?
}
