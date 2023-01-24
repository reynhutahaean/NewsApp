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
    
    func showError(message: String)
    func showLoading()
    func hideLoading()
    func reloadTableView()
}

protocol HomeUseCase: AnyObject {
    var presenter: HomeInteractorOutput? { get set }
    
    func getNews(param: [String: Any])
}

protocol HomeWireFrame: AnyObject {
    func createModule(data: [String: Any]?) -> BaseViewController
    
    func navigateToDetail(data: [String: Any])
    func presentCategoryPicker(categoryName: [String], categoryList: [Category])
}

protocol HomePresentation: AnyObject {
    var view: HomeView? { get set }
    var interactor: HomeUseCase? { get set }
    var router: HomeWireFrame? { get set }
    
    var topHeadlineArray: [News] { get set }
    var refreshControl: UIRefreshControl { get set }
    var category: String { get set }
    var categoryList: [Category] { get set }
    var selectedCategory: Category? { get set }
    var searchText: String { get set }
    
    func viewDidLoad()
    func getNews()
    func navigateToDetail(data: News)
    func presentCategoryPicker()
    func searchNews()
}

protocol HomeInteractorOutput: AnyObject {
    func successGetNews(data: [News])
    func errorGetNews(message: String)
}
