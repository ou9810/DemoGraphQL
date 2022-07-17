//
//  GraphQLResult.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/17.
//

import Foundation

struct User: Decodable {
    var id: String?
    var email: String?
    var name: String?
}

struct Todo: Decodable {
    var id: String?
    var description: String?
    var done: Bool
}

struct GraphQLResult: Decodable {
    var users: [User]?
    var todos: [Todo]?
    
    enum RootCodingKeys: String, CodingKey {
        case data
        
        enum NestedCodingKeys: String, CodingKey {
            case users
            case todos
        }
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: .data)
        self.users = try container.decodeIfPresent([User].self, forKey: .users)
        self.todos = try container.decodeIfPresent([Todo].self, forKey: .todos)
    }
}
