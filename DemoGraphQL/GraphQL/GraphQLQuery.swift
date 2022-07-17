//
//  GraphQLQuery.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/17.
//

import Foundation

struct GraphQLQuery: Encodable {
    var queryString: String
    
    enum QueryKey: String, CodingKey {
        case query
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: QueryKey.self)
        try container.encode(queryString, forKey: .query)
    }
}


