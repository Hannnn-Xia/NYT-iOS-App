//
//  Article.swift
//  New York Times
//
//  Created by 夏晗 on 2020/5/13.
//  Copyright © 2020 default. All rights reserved.
//

import Foundation

struct Headline: Codable{
    var main: String?
}

struct Image: Codable {
    var subtype: String?
    var url: String?
}


struct Article: Codable {
    var date: String?
    var snippet: String?
    var headline: Headline?
    var webURL: String?
    var images: [Image?]
}

extension Article {
    enum CodingKeys: String, CodingKey {
        case date = "pub_date"
        case headline
        case snippet = "snippet"
        case webURL = "web_url"
        case images = "multimedia"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        headline = try container.decode(Headline.self, forKey: .headline)
        snippet = try container.decode(String.self, forKey: .snippet)
        webURL = try container.decode(String.self, forKey: .webURL)
        images = try container.decode([Image].self, forKey: .images)
    }
}

struct response: Codable {
    var docs: [Article]?
}


struct ArticleSearchResponse: Codable {
    var response: response?
}

