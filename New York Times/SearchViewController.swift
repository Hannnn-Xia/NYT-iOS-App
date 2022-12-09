//
//  SearchViewController.swift
//  New York Times
//
//  Created by 夏晗 on 2020/5/13.
//  Copyright © 2020 default. All rights reserved.
//

import UIKit

protocol SelectAndPushProtocol: class {
    func selectAndPush(selectedArticle: Article)
}

class SearchViewController: UIViewController, UISearchResultsUpdating {

    
    let tableView = UITableView()
    let articleCellIdentifier = "ArticleCell"
    var searchController: UISearchController!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Search"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.dataSource = self
        tableView.register(SearchArticleTableViewCell.self, forCellReuseIdentifier: articleCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Article Name"
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true

        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                NetworkManager.getArticle(fromKeyword: searchText) {
                    article in
                    self.articles = article
                    self.tableView.reloadData()
                }
            }
            else {
                self.articles = []
                self.tableView.reloadData()
            }
        }
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

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellIdentifier, for: indexPath) as! SearchArticleTableViewCell
        cell.selectedArticle = articles[indexPath.row]
        cell.titleLabel.text = articles[indexPath.row].headline?.main
        cell.detailLabel.text = articles[indexPath.row].snippet
        cell.delegate = self
        let string = articles[indexPath.row].date //2020-03-03T10:00:08+0000
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: string ?? "")
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "EEEE, MMM d, yyyy"
        cell.dateLabel.text = formatter2.string(from: date ?? Date())
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension SearchViewController: SelectAndPushProtocol {
    func selectAndPush(selectedArticle: Article) {
        let vc = ModalViewController(selectedArticle: selectedArticle)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
