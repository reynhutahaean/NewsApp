//
//  BaseRouter.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import Foundation

class BaseRouter {
    
    required public init() { }
    
    func createModule(data: [String: Any]? = nil) -> BaseViewController {
        return BaseViewController()
    }
}
