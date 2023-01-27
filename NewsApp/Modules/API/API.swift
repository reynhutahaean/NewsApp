//
//  API.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 27/01/23.
//

import Foundation
import Alamofire

enum API: APIConfiguration {
    case getNews(param: [String: Any])
    
    var baseUrl: String {
        Constant.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNews:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getNews(let param):
            return param
        }
    }
    
}
