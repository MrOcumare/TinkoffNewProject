//
//  NewsDetailsController.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class NewsDetailsController: UITableViewController {
    
    let service = NewsService()
    var newsDetail: NewsDetail?
    var slug: String?
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (slug ?? "no parametr")

        setupView()
        
        guard let slug = slug else {return}
        
        service.getNewsDetails(slug: slug){ (newsDetail, error) in
            if let error = error {
                print(error)
            }
            if let newsDetail = newsDetail {
                self.newsDetail = newsDetail
                self.tableView.reloadData()
            }
        }

    }
    
    
    
    func setupView() {
        tableView.backgroundColor = UIColor.white
        tableView.register(NewsDetailsCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = tableView.frame.height
        tableView.tableFooterView = UIView(frame: .zero)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsDetailsCell
        cell.setupViews()
        if let newsDetail = newsDetail {
         cell.setupWithData(newsDetail: newsDetail)
        }
       

        return cell
    }

}
