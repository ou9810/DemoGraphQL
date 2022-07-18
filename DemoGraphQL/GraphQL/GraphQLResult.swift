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
    
    private func descriptionOfTodo(_ todo: Todo, at index: Int) -> String {
        var result = "No. \(index+1)\n"
        
        if let id = todo.id {
            result += "ID: \(id)\n"
        }
        
        if let description = todo.todoDescription {
            result += "Description: \(description)\n"
        }
        
        if let done = todo.done {
            result += "Done: \(done ? "true" : "false")\n"
        }
        
        result += "---\n"
        
        return result
    }
    
    private func descriptionOfUser(_ user: User, at index: Int) -> String {
        var result = "No. \(index+1)\n"
        
        if let id = user.id {
            result += "ID: \(id)\n"
        }
        
        if let email = user.email {
            result += "Email: \(email)\n"
        }
        
        if let name = user.name {
            result += "Name: \(name)\n"
        }
        
        result += "---\n"
        
        return result
    }
    
    func description() -> String {
        var result = ""
        
        if let user = data.user {
            result += "USER\n=====\n"
            
            user.todos?.enumerated().forEach({ index, todo in
                result += descriptionOfTodo(todo, at: index)
            })
        } else {
            if let users = data.users {
                result += "USERS\n====\n"
                users.enumerated().forEach { index, user in
                    result += descriptionOfUser(user, at: index)
                }
            }
            
            if let todos = data.todos {
                result += "TODOS\n=====\n"
                todos.enumerated().forEach { index, todo in
                    result += descriptionOfTodo(todo, at: index)
                }
            }
        }
        
        return result
    }
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
