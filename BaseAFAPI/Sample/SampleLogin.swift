//
//  SampleLogin.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import Foundation
import Alamofire


struct SampleLoginAPI: APIClient {
    
    typealias Model = SampleLoginResponse
    
    var paramss : [String : Any] = [:]
    
    var params: [String : Any] {
        return paramss
    }
    
    var environment: Environment {
        return DefaultEnvironment()
    }
    
    var path: String {
        return "login"
    }
    
    var method: HTTPMethod {
        return .post
    }
}


struct SampleLoginResponse: Decodable {
    
    var status: Int?
    var errorCode: Int?
    var errorMessage: String?
    var response: TokenResponse?
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case response
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        errorCode = try container.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        response = try container.decode(TokenResponse.self, forKey: .response)
        
    }
}

struct TokenResponse: Decodable {
    var token: String?
    
    
    enum CodingKeys: String, CodingKey {
        case token
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token)
    }
}
