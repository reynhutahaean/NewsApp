//
//  Constant.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation

class Constant {
    
    static let apiKey = "eda6154a62744b7bbad849130a7f7b6f"
    
    /* Use This if the first one was expired
        static let apiKey = "8af5d3b9608e43038c0e657e588d078f"
     */
    
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
