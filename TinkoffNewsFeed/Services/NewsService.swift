//
//  NewsService.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation

class NewsService {
    
    func getNews(completion:(([NewsFeed]?, Error?) -> Void)?) {
        let path = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles"
        guard let url = URL(string: path) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, responce, Error) in
            do{
                guard let data = data else {return}
                let articlesData = try JSONDecoder().decode(TinkoffNews.self, from: data)

                
                let newsList = articlesData.response.news
                
                DispatchQueue.main.async {
                    completion?(newsList, nil)
                }
                

            }catch{
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                

            }
            
        }
        task.resume()
    }
        
    
    func getNewsDetails(slug: String, comletion:((NewsDetail?, Error?) -> Void)?) {
        let path = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle?urlSlug=\(slug)"
        guard let url = URL(string: path) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            do {
                guard let data = data else {return}
                let detailsData = try JSONDecoder().decode(TinkoffNewsDetails.self, from: data)

                let newsDetail = detailsData.response
                
                DispatchQueue.main.async {
                    comletion?(newsDetail, nil)
                }
                
            } catch {
                
                DispatchQueue.main.async {
                    comletion?(nil,error)
                }
                
            }
        }
        task.resume()
    }

    
    
    
}
