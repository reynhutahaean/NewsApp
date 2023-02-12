//
//  HomeContract.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation
import UIKit

protocol HomeView: AnyObject {
    var presenter: HomePresentation? { get set }
    
    func showErrorSearch(isHidden: Bool)
    func showLoading()
    func hideLoading()
    func reloadTableView()
    func showAlert(message: String)
}

protocol HomeUseCase: AnyObject {
    var presenter: HomeInteractorOutput? { get set }
    
    func getNews(param: [String: Any])
}

protocol HomeWireFrame: AnyObject {
    func createModule(data: [String: Any]?) -> BaseViewController
    
    func navigateToDetail(data: [String: Any])
    func presentCategoryPicker(categoryName: [String], categoryList: [CategoryType])
}

protocol HomePresentation: AnyObject {
    var view: HomeView? { get set }
    var interactor: HomeUseCase? { get set }
    var router: HomeWireFrame? { get set }
    
    var topHeadlineArray: [NewsModel] { get set }
    var refreshControl: UIRefreshControl { get set }
    var category: String { get set }
    var categoryList: [CategoryType] { get set }
    var selectedCategory: CategoryType? { get set }
    var pageSize: Int { get set }
    
    func viewDidLoad()
    func getNews()
    func navigateToDetail(data: NewsModel)
    func presentCategoryPicker()
    func searchNews(searchText: String)
}

protocol HomeInteractorOutput: AnyObject {
    func successGetNews(data: [NewsModel])
    func errorGetNews(message: String)
}
