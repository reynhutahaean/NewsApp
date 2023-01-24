//
//  TopHeadlinesTableViewCell.swift
//  eNews
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit
import AlamofireImage

class TopHeadlinesTableViewCell: UITableViewCell {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(topHeadlines: News) {
        newsView.layer.cornerRadius = 8.0
        newsView.dropShadow()
        if topHeadlines.urlToImage?.prefix(4) == "http" || topHeadlines.urlToImage?.prefix(5) == "https"{
            guard let urlString = topHeadlines.urlToImage?.replacingOccurrences(of: " ", with: "%20"), let url = URL(string: urlString) else { return }
            newsImageView.af_setImage(withURL: url)
            newsImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
        } else {
            newsImageView.af_setImage(withURL: URL(string: "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg")!)
            newsImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
        }
//        newsSourceLabel.text = topHeadlines.name
        let newsLabel = topHeadlines.title
        let index = newsLabel?.firstIndex(of: "-")
        newsTitleLabel.text = String(newsLabel?[..<index!] ?? "")
        authorLabel.text = topHeadlines.author
    }
}
