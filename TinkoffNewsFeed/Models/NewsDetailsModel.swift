//
//  NewsDetailsModel.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation



struct TinkoffNewsDetails: Codable {
    let response: NewsDetail
}

struct NewsDetail: Codable {
    let title: String
    let text: String
}
