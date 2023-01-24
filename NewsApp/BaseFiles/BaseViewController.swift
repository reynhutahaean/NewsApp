//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    var isShowingAlert = false
    var isShowingMsg = false
    var hud:MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLoading(_ view:UIView){
        hideLoading(view)
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = ""
    }

    func hideLoading(_ view:UIView){
        MBProgressHUD.hide(for: view, animated: true)
    }
}
