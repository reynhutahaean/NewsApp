//
//  HomeEntity.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation

struct News: Codable {
    var id: String?
    var name: String?
    var author: String?
    var title: String?
    var descriptionNews: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case author
        case title
        case descriptionNews = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

struct Category {
    let id : String
}
