//
//  CategoryPickerViewController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 24/01/23.
//

import UIKit

protocol CategoryPickerPopUpDelegate {
    func selectPicker(categoryName: String)
}

class CategoryPickerViewController: UIViewController {

    @IBOutlet weak var bgButton: UIButton!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CategoryPickerPopUpDelegate?
    var pickerArray = [String]()
    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initTableView()
    }


    func initUI() {
        pickerContainerView.roundedCorner(cornerRadius: 8)
        searchView.roundedCorner(cornerRadius: 8)
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: "CategoryPickerTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryPickerTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        tableView.estimatedRowHeight = 45
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: Any) {
        if (searchTextField.text == "") {
            pickerArray = categoryArray.map { $0.id }
        } else {
            let filteredCountry = categoryArray.filter { $0.id.contains(searchTextField.text!) }
            pickerArray = filteredCountry.map { $0.id }
        }

        tableView.reloadData()
    }
    
    @IBAction func bgButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

}

extension CategoryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryPickerTableViewCell", for: indexPath) as! CategoryPickerTableViewCell
        cell.categoryLabel.text = pickerArray[indexPath.row].capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false, completion: nil)
        
        if (delegate != nil) {
            delegate?.selectPicker(categoryName: pickerArray[indexPath.row])
        }
    }
}
