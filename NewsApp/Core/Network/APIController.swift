//
//  APIController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

protocol APIController: AnyObject {
    func getHomeNews(param: [String: Any], successBlock: @escaping (ResponseModel<[NewsModel]>?) -> Void, errorBlock: @escaping (String) -> Void)
    func getSourcesNews(param: [String: Any], successBlock: @escaping (ResponseModel<[SourcesNewsModel]>?) -> Void, errorBlock: @escaping (String) -> Void)
}

class APIRepo: APIController {
    static let sharedInstance = APIRepo()
    private var api = APIManager.sharedInstance
    
    func getHomeNews(param: [String: Any], successBlock: @escaping (ResponseModel<[NewsModel]>?) -> Void, errorBlock: @escaping (String) -> Void) {
        api.request(type: NewsModel.self, request: RequestObjectModel(method: .get, path: Constant.RoutesHome, param: param)) { result, list in
            successBlock(list)
        } errorBlock: { status, error in
            errorBlock(error)
        }
    }
    
    func getSourcesNews(param: [String : Any], successBlock: @escaping (ResponseModel<[SourcesNewsModel]>?) -> Void, errorBlock: @escaping (String) -> Void) {
        api.request(type: SourcesNewsModel.self, request: RequestObjectModel(method: .get, path: Constant.RoutesSources, param: param)) { result, list in
            successBlock(list)
        } errorBlock: { status, error in
            errorBlock(error)
        }
    }
}

