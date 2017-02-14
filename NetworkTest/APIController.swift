//
//  APIController.swift
//  NetworkTest
//
//  Created by david on 2/9/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIController {
  static let instance = APIController()
  
  func get(
    entity: String,
    search: String,
    callback: @escaping (_ results: JSON?) -> ()) {
    
    let url = "https://api.github.com/search/\(entity)?q=\(search)"
    print("request url: \(url)")
    
    Alamofire.request(url).responseJSON { response in
      switch response.result {
      case .success(let data):
        callback(JSON(data))
      case .failure:
        callback(nil)
      }
    }
  }
}
