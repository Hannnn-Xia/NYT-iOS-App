//
//  ModalViewController.swift
//  New York Times
//
//  Created by 夏晗 on 2020/5/15.
//  Copyright © 2020 default. All rights reserved.
//

import UIKit


class ModalViewController: UIViewController {
    var selectedArticle: Article?
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let articleImage = UIImageView()
    let urlText = UITextView()
    
    init(selectedArticle: Article?) {
        super.init(nibName: nil, bundle: nil)
        self.selectedArticle = selectedArticle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let marginGuide = view.layoutMarginsGuide
        let imageConstraint: CGFloat = 400
        let padding: CGFloat = 35
        
        // Configure articleImage
        view.addSubview(articleImage)
        for image in selectedArticle!.images {
            if image?.subtype == "superJumbo" {
                let wantedURL = "https://static01.nyt.com/" + (image?.url ?? "")
                NetworkManager.fetchArticleImage(imageURL: wantedURL) { image in
                    self.articleImage.image = image
                    self.articleImage.translatesAutoresizingMaskIntoConstraints = false
                    self.articleImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
                    self.articleImage.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20).isActive = true
                    self.articleImage.heightAnchor.constraint(equalToConstant:  imageConstraint).isActive = true
                    self.articleImage.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
                    self.articleImage.contentMode = .scaleAspectFill
                    self.articleImage.layer.masksToBounds = true
                }
            }
        }

                
        // Configure titleLabel
        view.addSubview(titleLabel)
        titleLabel.text = selectedArticle?.headline?.main
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: padding).isActive = true
        titleLabel.numberOfLines = 0 // make label multi-line
        
        // Configure detailLabel
        view.addSubview(detailLabel)
        detailLabel.text = selectedArticle?.snippet
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        // Constrain detailLabel’s topAnchor to titleLabel's bottom anchor
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding).isActive = true
//        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 18).isActive = true
        detailLabel.numberOfLines = 0 // make label multi-line
//        detailLabel.textColor = UIColor.lightGray
        

        //Configure text
        view.addSubview(urlText)
        let attributedString = NSMutableAttributedString(string: "Clink To See Full Article Here")
        attributedString.addAttribute(.link, value: selectedArticle?.webURL as Any, range: NSRange(location: 10, length: 10))
        urlText.attributedText = attributedString
        urlText.translatesAutoresizingMaskIntoConstraints = false
        urlText.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        urlText.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10).isActive = true
//        urlText.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        urlText.contentMode = .top
        urlText.allowsEditingTextAttributes = false
        urlText.isSelectable = true
        urlText.dataDetectorTypes = [.link]
        urlText.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }
    
    func textView(_ urlText: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
      return true
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
