//
//  ArticlesTableViewController.swift
//  Articles & New Features
//
//  Created by José Gil Ramírez S on 1/28/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    /*
     var articles: [Article] = [
     Article(title: "Título del artículo 1", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.newsmax.com/Newsmax/files/20/206b0e3b-3e74-43c8-b561-484787e1024f_120_100.jpg", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
     Article(title: "Título del artículo 2", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.newsmax.com/Newsmax/files/20/206b0e3b-3e74-43c8-b561-484787e1024f_120_100.jpg", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
     Article(title: "Título del artículo 3", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.newsmax.com/Newsmax/files/20/206b0e3b-3e74-43c8-b561-484787e1024f_120_100.jpg", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
     Article(title: "Título del artículo 4", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.newsmax.com/Newsmax/files/20/206b0e3b-3e74-43c8-b561-484787e1024f_120_100.jpg", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
     Article(title: "Título del artículo 5", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.newsmax.com/Newsmax/files/20/206b0e3b-3e74-43c8-b561-484787e1024f_120_100.jpg", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
     ]
     */
    
    var articles: [Article]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadArticles()
    }
    
    func downloadArticles() {
        ArticleService.sharedInstance.getArticleList() {[unowned self] (results) in
            self.articles = results
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        
        guard let article = articles?[indexPath.row] else { return cell }
        cell.update(with: article)
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = articles?[indexPath.row] else { return }
        
        if let url = URL(string: article.articleURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Artículos y Tips"
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
