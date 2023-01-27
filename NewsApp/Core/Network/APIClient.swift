//
//  APIClient.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 27/01/23.
//

import Foundation
import UIKit
import Alamofire

class APIClient: SessionDelegate {
    static let shared = APIClient()
    
    private var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    private var sessionManager: SessionManager?
    private var isRetry: Bool = false
    private var isShowingMsg: Bool = false
    private var navigationController: UINavigationController = UINavigationController()
    
    private override init() {
        super.init()
        
        configuration.httpShouldSetCookies = false
        configuration.urlCache = nil
        configuration.urlCache?.removeAllCachedResponses()
        
        sessionManager = SessionManager.init(configuration: configuration, delegate: self)
    }
    
    public func request<T: Codable>(path: String, param: [String: Any]? = nil, method: HTTPMethod, model: T.Type, listener: ServiceListener<T>) {
        
        let headers : HTTPHeaders = ["Content-Type": "application/json",
                       "X-Api-Key": Constant.apiKey]
        
        print("\(Constant.baseURL)\(path)")
        sessionManager?.request("\(Constant.baseURL)\(path)", method: method, parameters: param, encoding: URLEncoding.default, headers: headers).responseString { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if let value = response.value {
                        let decoder: JSONDecoder = JSONDecoder()
                        let jsonData: Data = value.data(using: .utf8) ?? Data()
                        
                        do {
                            let responseModel = try decoder.decode(NewsResponse<T>.self, from: jsonData)
                            
                //            let status = responseModel.status
                            
                //            if status == "ok" {
                                listener.onSuccess(responseModel)
                //            }
                        } catch (let error) {
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

