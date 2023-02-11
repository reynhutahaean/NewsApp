//
//  Constant.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation

class Constant {
    
    static let apiKey = "eda6154a62744b7bbad849130a7f7b6f"
    
    private struct Domain {
        static let baseURL = "https://newsapi.org"
    }
    
    private struct Routes {
        static let topHeadline = "/v2/top-headlines"
        static let sources = "/v2/top-headlines/sources"
    }
    
    static let BaseURL = Domain.baseURL
    
    static let RoutesHome = Routes.topHeadline
    static let RoutesSources = Routes.sources
}
