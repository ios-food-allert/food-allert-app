//
//  ArticleTableViewCell.swift
//  Articles & New Features
//
//  Created by José Gil Ramírez S on 1/28/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAbstract: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(with article: Article) {
        articleTitle.text = article.title
        articleAbstract.text = article.overview
        if let urlImage = URL(string: article.imageURL) {
            articleImage.load(url: urlImage)
        }
    }
    
}
