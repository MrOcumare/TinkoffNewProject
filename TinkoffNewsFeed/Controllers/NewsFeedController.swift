//
//  ViewController.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit



class NewsFeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let service = NewsService()
    var newsList: [NewsFeed] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var slug: String?
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        

        service.getNews() { (newsList, error) in
            if let error = error {
      
                print(error)
            }
            if let newsList = newsList {
               self.newsList = newsList
               self.collectionView.reloadData()
            }
        }
        
        setupRefreshControl()
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < -250 {
            refreshControl.attributedTitle = NSAttributedString(string: "PlEASE WAIT", attributes: [NSAttributedString.Key.foregroundColor : refreshControl.tintColor])
        } else {
            refreshControl.attributedTitle = NSAttributedString(string: "loading...", attributes: [NSAttributedString.Key.foregroundColor : refreshControl.tintColor])
        }

        refreshControl.backgroundColor = UIColor.darkGray
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor.yellow
        refreshControl.backgroundColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "loading...", attributes: [NSAttributedString.Key.foregroundColor : refreshControl.tintColor])
        refreshControl.addTarget(self, action: #selector(NewsFeedController.refreshData), for: UIControl.Event.valueChanged)
    }
    
    @objc func refreshData() {
      collectionView.reloadData()
      refreshControl.endRefreshing()
    }
    

    
    func setupView() {
        navigationItem.title = "Tinkoff News"
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
//        setup cell
        let newsFeed = newsList[indexPath.item]
        feedCell.setupWithData(newsFeed)
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indPath = indexPath
        let article = newsList[indPath.item]
        self.slug = article.slug
        
        performSegue(withIdentifier: "newsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newsDetailsVC = segue.destination as? NewsDetailsController {
            newsDetailsVC.slug = self.slug
        }
    }



}

