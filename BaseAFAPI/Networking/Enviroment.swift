//
//  Enviroment.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import Foundation


protocol Environment {
    var baseUrl: String { get }
    var timeout: TimeInterval { get }
    var header: [String: String] { get }
}

struct DefaultEnvironment: Environment {
    var baseUrl: String {
        return "http://meetup.rikkei.org/api/v0/"
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var header: [String : String] {
        return [:]
    }
}
