//
//  AlertManager.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 27/01/23.
//

import Foundation
import UIKit

class AlertManager: UIViewController {
    
    private var isShowingMsg: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
    }
    
    func showAlert(message: String = "") {
        if isShowingMsg {
            isShowingMsg = true
        }
        let alert = UIAlertController(title: "Info", message: "msg", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        isShowingMsg = true
        self.present(alert, animated: true) { () -> Void in
            self.isShowingMsg = false
        }
    }
}
