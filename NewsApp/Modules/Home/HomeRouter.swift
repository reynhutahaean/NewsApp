//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit

class HomeRouter: BaseRouter {
    
    weak var viewController: HomeViewController?
    
    override func createModule(data: [String : Any]? = nil) -> BaseViewController {
        let view: BaseViewController & HomeView = HomeViewController()
        let presenter: HomePresentation & HomeInteractorOutput = HomePresenter()
        let interactor: HomeUseCase = HomeInteractor()
        let router: HomeWireFrame = self
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController = view as? HomeViewController
        return view
    }
}

extension HomeRouter: HomeWireFrame {
    func navigateToDetail(data: [String : Any]) {
        guard let viewController = viewController else { return }
        let detailView = DetailNewsViewController()
        detailView.data = data
        detailView.modalPresentationStyle = .fullScreen
        viewController.present(detailView, animated: true)
    }
    
    func presentCategoryPicker(categoryName: [String], categoryList: [CategoryType]) {
        guard let viewController = viewController else { return }
        let vc = CategoryPickerViewController()
        vc.delegate = viewController
        vc.pickerArray = categoryName
        vc.categoryArray = categoryList
        vc.modalPresentationStyle = .overFullScreen
        viewController.present(vc, animated: false, completion: nil)
    }
}

