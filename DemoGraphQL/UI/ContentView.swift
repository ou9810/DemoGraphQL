//
//  ContentView.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/16.
//

import SwiftUI

struct ContentView: View {
    var dataFetcher = DataFetcher(hostURL: URL(string: "https://api.mocki.io/v2/c4d7a195/graphql"))
    
    @State private var queryString: String = ""
    @State private var outputString: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Input query here:", text: $queryString)
                Button("Send") {
                    let query = GraphQLQuery(queryString: queryString.lowercased())
                    dataFetcher.fetch(query: query, of: GraphQLResult.self) { result in
                        switch result {
                        case .success(let output):
                            outputString = "\(output!)"
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            Divider()
            Text(outputString)
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
