//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation
import Alamofire

class HomeInteractor {
    
    weak var presenter: HomeInteractorOutput?
}

extension HomeInteractor: HomeUseCase {
    
    func getNews(param: [String : Any]) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
                       "X-Api-Key": Constant.apiKey]
        
        Alamofire.request("\(Constant.baseURL)\(Constant().topHeadline)", method: .get, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON { [weak self] response in
            
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    guard let articles = newsResponse.articles else { return }
                    self?.presenter?.successGetNews(data: articles)
                } catch let error {
                    print(error)
                }
            }
            else {
                self?.presenter?.errorGetNews(message: response.result.error?.localizedDescription ?? "")
            }
        }
    }
}
