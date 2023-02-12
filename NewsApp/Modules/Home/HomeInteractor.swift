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
    
    private let service: APIController = APIRepo()
}

extension HomeInteractor: HomeUseCase {
    
    func getNews(param: [String : Any]) {
        service.getHomeNews(param: param) { [weak self] response in
            if let data = response?.articles {
                self?.presenter?.successGetNews(data: data)
            }
        } errorBlock: { [weak self] error in
            self?.presenter?.errorGetNews(message: error)
        }
    }
}
