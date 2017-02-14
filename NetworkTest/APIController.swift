//
//  APIController.swift
//  NetworkTest
//
//  Created by david on 2/9/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import Alamofire

class APIController {
  static let instance = APIController()
  
  func get(
    entity: String,
    search: String,
    callback: @escaping (_ results: [String: AnyObject]?) -> ()) {
    
    let url = "https://api.github.com/search/\(entity)?q=\(search)"
    print("request url: \(url)")
    
    Alamofire.request(url).responseJSON { response in
      if let results = response.result.value as? [String: AnyObject] {
        callback(results)
      } else {
        callback(nil)
      }
    }
  }
}
