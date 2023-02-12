//
//  SourcesContract.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation

protocol SourcesView: AnyObject {
    var presenter: SourcesPresentation? { get set }
    
    func reloadData()
    func showLoading()
    func hideLoading()
    func showErrorSearch(isHidden: Bool)
    func showAlert(message: String)
}

protocol SourcesUseCase: AnyObject {
    var presenter: SourcesInteractorOutput? { get set}
    
    func getSourceNews(param: [String: Any])
}

protocol SourcesWireFrame: AnyObject {
    func createModule(data: [String: Any]?) -> BaseViewController
    
    func navigateToDetail(data: [String: Any])
}

protocol SourcesPresentation: AnyObject {
    var view: SourcesView? { get set }
    var interactor: SourcesUseCase? { get set }
    var router: SourcesWireFrame? { get set }
    
    var sourcesNews: [SourcesNewsModel] { get set }
    var category: String { get set }
    var categoryArray: [CategoryType] { get set }

    func viewDidLoad()
    func getCategoryCount() -> Int
    func getSourcesNews()
    func searchNews(searchText: String)
    func navigateToDetail(data: SourcesNewsModel)
}

protocol SourcesInteractorOutput: AnyObject {
    func successGetSourcesNews(data: [SourcesNewsModel])
    func errorGetSourceNews(message: String)
}
