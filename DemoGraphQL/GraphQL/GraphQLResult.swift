//
//  GraphQLResult.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/17.
//

import Foundation

// These codable structure are generated from https://app.quicktype.io/

struct GraphQLResult: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let user: QueryUser?
    let users: [User]?
    let todos: [Todo]?
    let updateTodo: Todo?
}

struct User: Codable {
    let id, email, name: String?
}

struct Todo: Codable {
    let id, todoDescription: String?
    let done: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case todoDescription = "description"
        case done
    }
}

struct QueryUser: Codable {
    let todos: [Todo]?
}
