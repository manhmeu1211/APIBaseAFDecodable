//
//  SampleGetNewsAPI.swift
//  BaseAPI
//
//  Created by ManhLD on 9/17/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import Alamofire

struct SampleGetNewsAPI: APIClient {
    
    typealias Model = SampleGetNewsResponse
    
    var paramss : [String : Any] = [:]
    
    var params: [String : Any] {
        return paramss
    }
    
    var environment: Environment {
        return DefaultEnvironment()
    }
    
    var path: String {
        return "listNews"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xNzIuMTYuMTQuMzI6ODJcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTkxNjY5MDUwLCJleHAiOjE2MDQ2MjkwNTAsIm5iZiI6MTU5MTY2OTA1MCwianRpIjoidW96eWYzcU8wbmRJNUVFQSIsInN1YiI6MjA3M30.WGA3TSmt5atueD_dmkh1cwUvUFSCRUt1DL_stsHj70E"]
    }
    
}

struct SampleGetNewsResponse: Decodable {
    
    var status: Int?
    var response: News?
    
    enum CodingKeys: String, CodingKey {
        case response
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        response = try container.decodeIfPresent(News.self, forKey: .response)
    }
}

struct News: Decodable {
    
    var news: [NewsModel]?
    
    enum CodingKeys: String, CodingKey {
        case news
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        news = try container.decode([NewsModel].self, forKey: .news)
    }
}


struct NewsModel: Decodable {
    var id: Int?
    var feed:  String?
    var title: String?
    var thumbImg: String?
    var detailUrl: String?
    var description: String?
    var author: String?
    var publishDate: String?
    var createdAt: String?
    var updateAt: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case feed
        case title
        case thumbImg = "thumb_img"
        case detailUrl = "detail_url"
        case description
        case author
        case publishDate = "publish_date"
        case createdAt = "created_at"
        case updateAt = "updated_at"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        feed = try container.decode(String.self, forKey: .feed)
        title = try container.decode(String.self, forKey: .title)
        thumbImg = try container.decodeIfPresent(String.self, forKey: .thumbImg)
        detailUrl = try container.decodeIfPresent(String.self, forKey: .detailUrl)
        description = try container.decode(String.self, forKey: .description)
        author = try container.decode(String.self, forKey: .author)
        publishDate = try container.decodeIfPresent(String.self, forKey: .publishDate)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updateAt = try container.decodeIfPresent(String.self, forKey: .updateAt)
    }
}




