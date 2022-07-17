//
//  DataFetcherTest.swift
//  DemoGraphQLTests
//
//  Created by Yuan on 2022/7/17.
//

import XCTest
@testable import DemoGraphQL

class DataFetcherTest: XCTestCase {
    var dataFetcher: DataFetcher!
    
    override func setUp() {
        super.setUp()
        dataFetcher = DataFetcher(hostURL: URL(string: "https://api.mocki.io/v2/c4d7a195/graphql"))
    }
    
    override func tearDown() {
        super.tearDown()
        dataFetcher = nil
    }
    
    func testQueryAll() {
        // Arrange
        let query = GraphQLQuery(queryString: "{ users { id email name } todos { id description done } }")
        let expectation = expectation(description: "task finished")

        // Act
        dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
            
            // Assert
            switch result {
            case .success(let output):
                XCTAssertNotNil(output?.data.users)
                XCTAssertNotNil(output?.data.todos)
                
            case .failure(_):
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testQueryUsersAll() {
        // Arrange
        let query = GraphQLQuery(queryString: "{ users { id email name } }")
        let expectation = expectation(description: "task finished")

        // Act
        dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
            
            // Assert
            switch result {
            case .success(let output):
                XCTAssertNotNil(output?.data.users)
                
            case .failure(_):
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testQueryTodosAll() {
        // Arrange
        let query = GraphQLQuery(queryString: "{ todos { id description done } }")
        let expectation = expectation(description: "task finished")

        // Act
        dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
            
            // Assert
            switch result {
            case .success(let output):
                XCTAssertNotNil(output?.data.todos)
                
            case .failure(_):
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testQueryUserTodos() {
        // Arrange
        let query = GraphQLQuery(queryString:
        """
        {
          user(id: "Hello World") {
            todos {
              id
              description
              done
            }
          }
        }
        """)
        let expectation = expectation(description: "task finished")

        // Act
        dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
            
            // Assert
            switch result {
            case .success(let output):
                XCTAssertNotNil(output?.data.user?.todos)
                
            case .failure(_):
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
