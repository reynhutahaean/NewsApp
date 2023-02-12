//
//  APIManager.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation
import Alamofire

class APIManager {
    static let sharedInstance = APIManager()
        
    private func setHeaders() -> HTTPHeaders {
        let headers : HTTPHeaders =
                    [
                        "Content-Type": "application/json",
                        "X-Api-Key": Constant.apiKey
                    ]
        
        return headers
    }
    
    func request<T: Decodable>(type: T.Type, request: RequestObjectModel, successBlock: @escaping (ResponseModel<T>?, ResponseModel<[T]>?) -> Void, errorBlock: @escaping (Int, String) -> Void) {
        
        let url = Constant.BaseURL
        
        if (NetworkReachabilityManager()!.isReachable) {
            Alamofire.request(url + request.path, method: request.method, parameters: request.param, headers: setHeaders()).responseJSON(completionHandler: { [weak self] response in
                self?.responseData(type: type, request: request, response: response, successBlock: { result, list in
                    successBlock(result, list)
                }, errorBlock: { status, error in
                    errorBlock(status, error)
                })
            })
        } else {
            let erroMessage = "No Internet Connection"
            UIApplication.topViewController()?.showAlertView(message: erroMessage)
            errorBlock(0, "")
        }
    }
    
    private func responseData<T: Decodable>(type: T.Type, url: String = "", request: RequestObjectModel, response: Alamofire.DataResponse<Any>, successBlock: @escaping (ResponseModel<T>?, ResponseModel<[T]>?) -> Void, errorBlock: @escaping (Int, String) -> Void) {
        
        if response.response?.statusCode == 200 {
            guard let data = response.data else { return }
            do {
                let decodeArray = try? JSONDecoder().decode(ResponseModel<[T]>.self, from: data)
                let decode = try? JSONDecoder().decode(ResponseModel<T>.self, from: data)
                successBlock(decode, decodeArray)
            } catch let error {
                print(error.localizedDescription)
                errorBlock(0, error.localizedDescription)
            }
        } else {
            errorBlock(0, "error")
        }
    }
}
