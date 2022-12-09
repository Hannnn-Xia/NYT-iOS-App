//
//  SearchArticleTableViewCell.swift
//  New York Times
//
//  Created by 夏晗 on 2020/5/13.
//  Copyright © 2020 default. All rights reserved.
//

import UIKit

class SearchArticleTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let dateLabel = UILabel()
    var selectedArticle: Article?
    weak var delegate: SelectAndPushProtocol?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        
        let lineConstraint: CGFloat = 10
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textColor = UIColor.systemGray
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: lineConstraint).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = UIColor.lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        dateLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: lineConstraint).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//      return true
//     }
//    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.delegate?.selectAndPush(selectedArticle: selectedArticle!)
        }
    }
    
    

}
