//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 24/01/23.
//

import UIKit
import WebKit

class DetailNewsViewController: BaseViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    
    var data: [String: Any]?
    private var detailNews: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        unwrapData()
        loadDetailNews()
    }

    private func setupView() {
        headerView.dropShadow()
    }
    
    private func unwrapData() {
        if let data = data {
            if let detailNews = data["news"] as? News {
                self.detailNews = detailNews
            }
        }
    }
    
    private func loadDetailNews() {
        guard let url = URL(string: detailNews?.url ?? "") else {
            return
        }
        
        showLoading(self.webView)
        webView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self else { return }
            self.hideLoading(self.webView)
        }
    }
}
