//
//  SourcesRouter.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import UIKit

class SourceRouter: BaseRouter {
    
    weak var viewController: SourcesViewController?
    
    override func createModule(data: [String : Any]? = nil) -> BaseViewController {
        let view: BaseViewController & SourcesView = SourcesViewController()
        let interactor: SourcesUseCase = SourceInteractor()
        let presenter: SourcesPresentation & SourcesInteractorOutput = SourcePresenter()
        let router: SourcesWireFrame = self
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController = view as? SourcesViewController
        
        return view
    }
}

extension SourceRouter: SourcesWireFrame {
    func navigateToDetail(data: [String : Any]) {
        guard let viewController = viewController else { return }
        let detailView = DetailNewsViewController()
        detailView.data = data
        detailView.modalPresentationStyle = .fullScreen
        viewController.present(detailView, animated: true)
    }
}
