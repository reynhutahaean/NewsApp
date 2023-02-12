//
//  ResponseModel.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

class ResponseModel<T: Decodable>: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: T?
    var sources: T?
}
