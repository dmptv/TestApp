//
//  NetworkManager.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

class NetworkService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Friend]?, String) -> ()
    
    var fiends: [Friend] = []
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getFriends(userid: Int = 26955116, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
//        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//            
//            urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
//            guard let url = urlComponents.url else { return }
//            
//            dataTask = defaultSession.dataTask(with: url) { data, response, error in
//                defer { self.dataTask = nil }
//                
//                if let error = error {
//                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//                    
//                } else if let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                    self.updateSearchResults(data)
//                    
//                    DispatchQueue.main.async {
//                        completion(self.tracks, self.errorMessage)
//                    }
//                }
//            }
//            dataTask?.resume()
//        }
        
    }
    
}



























