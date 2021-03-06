//
//  User.swift
//  NetworkTest
//
//  Created by david on 2/10/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
//import SwiftyJSON
import ObjectMapper
import Alamofire
import AlamofireImage

func == (lhs: User, rhs: User) -> Bool {
  return lhs.id == rhs.id
}

class User: Mappable {
  var login: String!
  var id: String!
  var avatar_url: String!
  var avatar: UIImage?
  
  required init?(map: Map) {
    guard map.JSON["id"] != nil else {
      return nil
    }
  }
  
  func mapping(map: Map) {
    self.login <- map["login"]
    self.id <- map["id"]
    self.avatar_url <- map["avatar_url"]
  }
}

//class User: Equatable {
//  var login: String
//  var id: String
//  var avatar_url: String
//  var avatar: UIImage?
//  
//  init(json: JSON) {
//    self.login = json["login"].stringValue
//    self.id = json["id"].stringValue
//    self.avatar_url = json["avatar_url"].stringValue
//  }
//}

extension UIImage {
  static func download(url: String, callback:@escaping (_ image: UIImage) -> ()) {
    Alamofire.request(url).responseImage { response in
      if let image = response.result.value {
        callback(image)
      }
    }
  }
}
