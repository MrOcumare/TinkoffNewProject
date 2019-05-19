//
//  NewsDetailsCell.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class NewsDetailsCell: UITableViewCell {
    
    func setupWithData(newsDetail: NewsDetail) {
       nameLabel.text = "\(newsDetail.title)"
       newsTextLabel.text = "\(newsDetail.text)".html2String
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newsTextLabel: UILabel = {
        let textlabel = UILabel()
        textlabel.numberOfLines = 0
        textlabel.text = "Loading..."
        textlabel.font = UIFont.systemFont(ofSize: 14)
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        return textlabel
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(newsTextLabel)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-20-[v0]-20-[v1]-20-|", views: nameLabel, newsTextLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: newsTextLabel)
    }
    
}


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
