//
//  ArticleTableViewController.swift
//  FoodAllert
//
//  Created by José Gil Ramírez S on 1/28/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    let loremIpsum: String = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.
"""
    
    var articles: [Article] = [
        Article(title: "Título del artículo 1", abstract: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.foodallergy.org/sites/default/files/styles/landing_page_card_image/public/epinephrine655x492_0.jpg?itok=20dqs-IU", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
        Article(title: "Título del artículo 2", abstract: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.foodallergy.org/sites/default/files/styles/landing_page_card_image/public/epinephrine655x492_0.jpg?itok=20dqs-IU", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
        Article(title: "Título del artículo 3", abstract: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.foodallergy.org/sites/default/files/styles/landing_page_card_image/public/epinephrine655x492_0.jpg?itok=20dqs-IU", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
        Article(title: "Título del artículo 4", abstract: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.foodallergy.org/sites/default/files/styles/landing_page_card_image/public/epinephrine655x492_0.jpg?itok=20dqs-IU", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
        Article(title: "Título del artículo 5", abstract: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor purus fermentum est malesuada, ut pulvinar ipsum aliquet. Quisque fringilla tincidunt varius. Pellentesque dignissim porttitor urna ut rutrum. Donec vehicula leo vitae ligula porttitor condimentum. Pellentesque nec nulla sit amet lorem malesuada porta. In scelerisque rhoncus ultrices. Nam et varius dolor. Mauris bibendum lacinia rhoncus. Etiam orci quam, venenatis sit amet lacus eget, pellentesque tristique tortor.", imageURL: "https://www.foodallergy.org/sites/default/files/styles/landing_page_card_image/public/epinephrine655x492_0.jpg?itok=20dqs-IU", articleURL: "https://www.foodallergy.org/life-with-food-allergies/anaphylaxis/treating-anaphylaxis"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.abstract
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
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
