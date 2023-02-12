//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation
import UIKit

class HomePresenter {

    weak var view: HomeView?
    var interactor: HomeUseCase?
    var router: HomeWireFrame?
    
    var topHeadlineArray: [NewsModel] = [NewsModel]()
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var category: String = CategoryType.general.rawValue
    var categoryList: [CategoryType] = [
        .business,
        .entertainment,
        .general,
        .health,
        .science,
        .sports,
        .technology
    ]
    var selectedCategory: CategoryType?
    var searchText: String = ""
    var pageSize: Int = 100
    
    private var model: HomeModel?
}

extension HomePresenter: HomePresentation {
    func viewDidLoad() {
        getNews()
    }
    
    func getNews() {
        var param: [String: Any] = [String: Any]()
        param["category"] = category
        param["pageSize"] = pageSize
        view?.showLoading()
        interactor?.getNews(param: param)
    }
    
    func navigateToDetail(data: NewsModel) {
        var param: [String: Any] = [String: Any]()
        param["news"] = data
        router?.navigateToDetail(data: param)
    }
    
    func presentCategoryPicker() {
        let categoryName = categoryList.map { $0.rawValue }
        router?.presentCategoryPicker(categoryName: categoryName, categoryList: categoryList)
    }
    
    func searchNews(searchText: String) {
        let unfiltered = model?.news ?? []
        
        let filteredNews = unfiltered.filter { news in
            return news.title?.lowercased().contains(searchText.lowercased()) ?? true
        }
        
        if filteredNews.isEmpty && !searchText.isEmpty {
            view?.showErrorSearch(isHidden: false)
        } else {
            view?.showErrorSearch(isHidden: true)
        }
        
        self.topHeadlineArray = searchText.isEmpty ? unfiltered : filteredNews
            
        view?.reloadTableView()
    }
}

extension HomePresenter: HomeInteractorOutput {
    func successGetNews(data: [NewsModel]) {
        view?.hideLoading()
        topHeadlineArray.append(contentsOf: data)
        model = HomeModel(news: data)
        view?.reloadTableView()
    }
    
    func errorGetNews(message: String) {
        view?.hideLoading()
        view?.showAlert(message: message)
    }
}
