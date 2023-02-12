//
//  RequestObjectModel.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation
import Alamofire

struct RequestObjectModel {
    var method: HTTPMethod
    var path: String
    var param: [String: Any]
}
