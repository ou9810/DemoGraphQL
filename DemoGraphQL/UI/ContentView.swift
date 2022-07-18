//
//  ContentView.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/16.
//

import SwiftUI

struct ContentView: View {
    var dataFetcher = DataFetcher(hostURL: URL(string: "https://api.mocki.io/v2/c4d7a195/graphql"))
    
    @State private var presentDetailView: Bool = false
    @State private var presentErrorAlert: Bool = false
    
    @State private var queryString: String = ""
    @State private var outputString: String = ""
    @State private var outputError: Error?
    
    // Mutating
    @State private var mutateTodoID: String = ""
    @State private var mutateTodoDone: Bool = false
    
    // Query User
    @State private var queryUserID: String = ""
    
    // Query Fields
    @State private var showID: Bool = false
    @State private var showEmail: Bool = false
    @State private var showName: Bool = false
    @State private var showDescription: Bool = false
    @State private var showDone: Bool = false
    
    func fetchWithQuery(query: GraphQLQuery) {
        dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
            switch result {
            case .success(let output):
                outputString = "\(output!)"
                presentDetailView = true
            case .failure(let error):
                outputError = error
                presentErrorAlert = true
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter GraphQL syntax here:", text: $queryString)
                    .lineLimit(3)
                Button("Query") {
                    let query = GraphQLQuery(queryString: queryString.lowercased())
                    fetchWithQuery(query: query)
                }
            }
            List {
                Section(header: Text("Add Todo")) {
                    TextField("Enter ID here:", text: $mutateTodoID)
                    Toggle("Done", isOn: $showDone)
                    HStack {
                        Spacer()
                        Button("Update") {
                            let query = GraphQLQuery(queryString:
                                """
                                mutation {
                                  updateTodo(input: {
                                    id: "\(mutateTodoID)",
                                    done: \(mutateTodoDone ? "true" : "false")
                                  }) {
                                    id
                                    done
                                  }
                                }
                                """)
                            fetchWithQuery(query: query)
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Users")) {
                    Toggle("ID", isOn: $showID)
                    Toggle("Email", isOn: $showEmail)
                    Toggle("Name", isOn: $showName)
                    HStack {
                        Spacer()
                        Button("Query") {
                            let query = GraphQLQuery(queryString:
                                """
                                {
                                  users {
                                    \(showID ? "id" : "")
                                    \(showEmail ? "email" : "")
                                    \(showName ? "name" : "")
                                  }
                                }
                                """)
                            fetchWithQuery(query: query)
                        }
                        Spacer()
                    }
                }
                Section(header: Text("User")) {
                    TextField("Enter user ID here:", text: $queryUserID)
                    HStack {
                        Spacer()
                        Button("Query") {
                            let query = GraphQLQuery(queryString:
                                """
                                {
                                  user(id: "\(queryUserID)") {
                                    todos {
                                      \(showID ? "id" : "")
                                          \(showDescription ? "description" : "")
                                          \(showDone ? "done" : "")
                                    }
                                  }
                                }
                                """)
                            fetchWithQuery(query: query)
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Todos")) {
                    Toggle("ID", isOn: $showID)
                    Toggle("Description", isOn: $showDescription)
                    Toggle("Done", isOn: $showDone)
                    HStack {
                        Spacer()
                        Button("Query") {
                            let query = GraphQLQuery(queryString:
                                """
                                {
                                  todos {
                                    \(showID ? "id" : "")
                                    \(showDescription ? "description" : "")
                                    \(showDone ? "done" : "")
                                  }
                                }
                                """)
                            fetchWithQuery(query: query)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .sheet(isPresented: $presentDetailView) {
            ResultView(detail: $outputString)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
