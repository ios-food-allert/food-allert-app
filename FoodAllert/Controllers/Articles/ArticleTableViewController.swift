//
//  ArticlesTableViewController.swift
//  Articles & New Features
//
//  Created by José Gil Ramírez S on 1/28/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import SafariServices

class ArticlesTableViewController: UITableViewController {
    
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
            //UIApplication.shared.open(url, options: [:], completionHandler: nil)
            showArticleLink(url)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Artículos y Tips"
    }
    */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showArticleLink(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
}
