//
//  SourcesCategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import UIKit

class SourcesCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryButton: UIButton!
    
    var callback: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupContent(category: CategoryType) {
        categoryButton.setTitle(category.rawValue.capitalized, for: .normal)
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        callback?(categoryButton.titleLabel?.text ?? "")
    }
}
