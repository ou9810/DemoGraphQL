//
//  DataFetcher.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/16.
//

import UIKit

class DataFetcher: NSObject {
    var hostURL: URL?
    
    init(hostURL: URL?) {
        self.hostURL = hostURL
    }
    
    func fetch<T: Decodable>(query: GraphQLQuery, of type: T.Type, completion: @escaping ((Result<T?, Error>) -> Void)) {
        guard let hostURL = hostURL else { return }
        
        var request = URLRequest(url: hostURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(query.self)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let output = try JSONDecoder().decode(T.self, from: data)
                completion(.success(output))
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
