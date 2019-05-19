//
//  FeedCell.swift
//  TinkoffNewsFeed
//
//  Created by Mr.Ocumare on 18/05/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    func setupWithData(_ newsFeed: NewsFeed) {
        nameLabel.text = "\(newsFeed.title)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Sample headline"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eye")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let viewCounter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.customGrey
        label.text = "12"
        return label
    }()
    
    func setupViews() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(nameLabel)
        addSubview(hasReadImageView)
        addSubview(viewCounter)
        
        addConstraintsWithFormat(format: "H:|-20-[v0][v1(20)]-6-[v2]-10-|", views: nameLabel, hasReadImageView, viewCounter)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: hasReadImageView)
        
        addConstraint(NSLayoutConstraint(item: hasReadImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraintsWithFormat(format: "V:[v0]", views: viewCounter)
        addConstraint(NSLayoutConstraint(item: viewCounter, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let customGrey = UIColor.rgb(red: 155, green: 161, blue: 171)
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

