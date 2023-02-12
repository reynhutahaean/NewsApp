//
//  SourcesInteractor.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

class SourceInteractor {
    weak var presenter: SourcesInteractorOutput?
    
    private let service: APIController = APIRepo()
}

extension SourceInteractor: SourcesUseCase {
    func getSourceNews(param: [String : Any]) {
        service.getSourcesNews(param: param) { [weak self] response in
            if let data = response?.sources {
                self?.presenter?.successGetSourcesNews(data: data)
            }
        } errorBlock: { [weak self] error in
            self?.presenter?.errorGetSourceNews(message: error)
        }
    }
}
