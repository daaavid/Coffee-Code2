//
//  User.swift
//  NetworkTest
//
//  Created by david on 2/10/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

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

