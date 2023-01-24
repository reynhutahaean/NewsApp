//
//  CategoryTableViewCell.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(categoryNews: News) {
        newsView.layer.cornerRadius = 8.0
        newsView.dropShadow()
        if categoryNews.urlToImage?.prefix(4) == "http" || categoryNews.urlToImage?.prefix(5) == "https"{
            guard let urlString = categoryNews.urlToImage?.replacingOccurrences(of: " ", with: "%20"), let url = URL(string: urlString) else { return }
            newsImageView.af_setImage(withURL: url)
            newsImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
        } else {
            if let url = URL(string: "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg") {
                newsImageView.af_setImage(withURL: url)
                newsImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
            }
        }
//        newsSourceLabel.text = categoryNews.name
        newsTitleLabel.text = categoryNews.title
        newsAuthorLabel.text = categoryNews.author
    }
}
