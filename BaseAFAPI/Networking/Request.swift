//
//  Request.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import Foundation
import Alamofire

protocol Request {
    var environment: Environment { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var params: [String: Any] { get }
    var header: [String: String] { get }
    var request: URLRequest { get }
}

extension Request {
    var fullUrl: URL {
        guard let url = URL(string: environment.baseUrl) else {
            fatalError("Invalid url")
        }
        guard !path.isEmpty else {
            return url
        }
        return url.appendingPathComponent(path)
    }
    
    var header: [String: String] {
        return environment.header
    }
    
    var params: [String: Any] {
        return [:]
    }
    
    var request: URLRequest {
        let originalRequest = try? URLRequest(url: fullUrl, method: method, headers: HTTPHeaders(header))
        
        guard let originReques = originalRequest else {
            return URLRequest(url: fullUrl)
        }
        
        let encodedRequest = try? encoding.encode(originReques,
                                                  with: params)
        guard let unwrappedUrlRequest = encodedRequest else {
            fatalError("Cannot encode request")
        }
        return unwrappedUrlRequest
    }
    
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    func printInfomationRequest() {
        print("Request :", request)
        print("Request full url :", fullUrl)
        print("Request method :", method)
        print("Request header :", header)
        print("Request params :", params)
    }
}
