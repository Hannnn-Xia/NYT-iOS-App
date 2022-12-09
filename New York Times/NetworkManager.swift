//
//  NetworkManager.swift
//  New York Times
//
//  Created by 夏晗 on 2020/5/13.
//  Copyright © 2020 default. All rights reserved.
//


import Foundation
import Alamofire


enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

class NetworkManager {

    private static let newyorkTimesURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"

    static func getArticle(fromKeyword keywords: String, _ didGetArticles: @escaping ([Article]) -> Void) {
        let param = ["q": keywords, "api-key": "gqAvZpQfZXWcGn1bB05jkwtYJuN6GQBO"]
        AF.request(newyorkTimesURL, method: .get, parameters: param).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let articleResult = try? decoder.decode(ArticleSearchResponse.self, from: data){
                    let articles = articleResult.response?.docs
                    didGetArticles(articles!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        }
    
        
    static func fetchArticleImage(imageURL: String, completion: @escaping ((UIImage) -> Void)) {
            AF.request(imageURL, method: .get).validate().responseData { response in
                        switch response.result {
                        case .success(let data):
                            if let image = UIImage(data: data) {
                                completion(image)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                }
        }
    }

