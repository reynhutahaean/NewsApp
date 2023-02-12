//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var presenter: HomePresentation?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var errorSearchNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        headerView.dropShadow()
        searchView.roundedCorner(cornerRadius: 10)
        searchContainerView.isHidden = true
        errorSearchNews.isHidden = true
    }
    
    private func setupTableView() {
        newsTableView.register(UINib(nibName: "TopHeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: "TopHeadlinesTableViewCell")
        newsTableView.register(UINib(nibName: "FirstTopHeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTopHeadlinesTableViewCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchContainerView.isHidden = !searchContainerView.isHidden
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        presenter?.presentCategoryPicker()
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: Any) {
        presenter?.searchNews(searchText: searchTextField.text ?? "")
    }
}

extension HomeViewController: HomeView {
    func showAlert(message: String) {
        DispatchQueue.main.async {
            self.showAlertView(message: message)
        }
    }
    
    func showErrorSearch(isHidden: Bool) {
        errorSearchNews.isHidden = isHidden
    }
    
    func showLoading() {
        self.showLoading(self.view)
    }
    
    func hideLoading() {
        self.hideLoading(self.view)
    }
    
    func reloadTableView() {
        newsTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.topHeadlineArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let news = presenter?.topHeadlineArray else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "FirstTopHeadlinesTableViewCell", for: indexPath) as! FirstTopHeadlinesTableViewCell
            cell.setData(news: news[indexPath.row])

            cell.selectionStyle = .none

            return cell
        } else {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "TopHeadlinesTableViewCell", for: indexPath) as! TopHeadlinesTableViewCell

            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = presenter?.topHeadlineArray else { return }
        presenter?.navigateToDetail(data: news[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (presenter?.topHeadlineArray.count ?? 0) - 1 {
            presenter?.getNews()
            DispatchQueue.main.async {
                let lastListIndexPath = IndexPath(row: (self.presenter?.topHeadlineArray.count ?? 0) - 1, section: 0)
                self.newsTableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
            }
        }
    }
}

extension HomeViewController: CategoryPickerPopUpDelegate {
    func selectPicker(categoryName: String) {
        if let categories = presenter?.categoryList.first(where: { $0.rawValue == categoryName }){
            presenter?.selectedCategory = categories
            presenter?.category = categoryName.lowercased()
            presenter?.getNews()
        }
    }
}
