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
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        headerView.dropShadow()
        searchTextField.delegate = self
    }
    
    private func setupTableView() {
        newsTableView.register(UINib(nibName: "TopHeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: "TopHeadlinesTableViewCell")
        newsTableView.register(UINib(nibName: "FirstTopHeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTopHeadlinesTableViewCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        presenter?.presentCategoryPicker()
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: Any) {
        presenter?.searchNews()
    }
}

extension HomeViewController: HomeView {
    func showError(message: String) {
        print(message)
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
        if indexPath.row == 0 {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "FirstTopHeadlinesTableViewCell", for: indexPath) as! FirstTopHeadlinesTableViewCell
            cell.setData(topHeadlines: presenter?.topHeadlineArray[indexPath.row] ?? News())
            
            return cell
        } else {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "TopHeadlinesTableViewCell", for: indexPath) as! TopHeadlinesTableViewCell
            cell.setData(topHeadlines: presenter?.topHeadlineArray[indexPath.row] ?? News())
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = presenter?.topHeadlineArray else { return }
        presenter?.navigateToDetail(data: news[indexPath.row])
    }
}

extension HomeViewController: CategoryPickerPopUpDelegate {
    func selectPicker(categoryName: String) {
        if let categories = presenter?.categoryList.first(where: { $0.id == categoryName }){
            presenter?.selectedCategory = categories
            presenter?.category = categoryName
            presenter?.getNews()
            newsTableView.reloadData()
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTextField {
            if textField.text?.isEmpty ?? false {
                presenter?.searchText = ""
            } else {
                presenter?.searchText = searchTextField.text ?? ""
            }
            return true
        }
        
        return false
    }
}
