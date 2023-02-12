//
//  SourcesPresenter.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

class SourcePresenter {
    weak var view: SourcesView?
    var interactor: SourcesUseCase?
    var router: SourcesWireFrame?
    
    var sourcesNews: [SourcesNewsModel] = [SourcesNewsModel]()
    var category: String = ""
    var categoryArray: [CategoryType] = [
        .business,
        .entertainment,
        .general,
        .health,
        .science,
        .sports,
        .technology
    ]
    
    private var model: SourcesModel?
}

extension SourcePresenter: SourcesPresentation {
    func viewDidLoad() {
        getSourcesNews()
    }
    
    func getCategoryCount() -> Int {
        return categoryArray.count
    }
    
    func getSourcesNews() {
        var param: [String: Any] = [String: Any]()
        param["category"] = category
        view?.showLoading()
        interactor?.getSourceNews(param: param)
    }
    
    func searchNews(searchText: String) {
        let unfilteredNews = model?.sources ?? []
        
        let filteredNews = unfilteredNews.filter { news in
            return news.descriptionNews?.lowercased().contains(searchText.lowercased()) ?? true
        }
        
        if filteredNews.isEmpty && !searchText.isEmpty {
            view?.showErrorSearch(isHidden: false)
        } else {
            view?.showErrorSearch(isHidden: true)
        }
        
        self.sourcesNews = searchText.isEmpty ? unfilteredNews : filteredNews
            
        view?.reloadData()
    }
    
    func navigateToDetail(data: SourcesNewsModel) {
        var param: [String: Any] = [String: Any]()
        param["sourceNews"] = data
        router?.navigateToDetail(data: param)
    }
}

extension SourcePresenter: SourcesInteractorOutput {
    func successGetSourcesNews(data: [SourcesNewsModel]) {
        view?.hideLoading()
        sourcesNews = data
        model = SourcesModel(sources: data)
        view?.reloadData()
    }
    
    func errorGetSourceNews(message: String) {
        view?.hideLoading()
        view?.showAlert(message: message)
    }
}
