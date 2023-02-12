//
//  SourcesEntity.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

struct SourcesModel {
    var sources: [SourcesNewsModel]
}

struct SourcesNewsModel: Codable {
    var id: String?
    var name: String?
    var descriptionNews: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case descriptionNews = "description"
        case url
        case category
        case language
        case country
    }
}
