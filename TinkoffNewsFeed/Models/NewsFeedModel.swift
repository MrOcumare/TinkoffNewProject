//
//  NewsFeedModel.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation

struct TinkoffNews: Codable{
    let response: Response
}

struct Response: Codable {
    let news: [NewsFeed]
    enum CodingKeys: String, CodingKey {
        case news = "news"
    }
}

        
struct NewsFeed: Codable {

    let title: String
    let slug: String
    

}
