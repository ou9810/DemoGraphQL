//
//  GraphQLResult.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/17.
//

import Foundation

// These codable structure are generated from https://app.quicktype.io/


// MARK: - Welcome
struct GraphQLResult: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: PurpleUser?
    let users: [UserElement]?
    let todos: [Todo]?
}

// MARK: - Todo
struct Todo: Codable {
    let id, todoDescription: String?
    let done: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case todoDescription = "description"
        case done
    }
}

// MARK: - PurpleUser
struct PurpleUser: Codable {
    let todos: [Todo]?
}

// MARK: - UserElement
struct UserElement: Codable {
    let id, email, name: String?
}
