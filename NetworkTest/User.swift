//
//  User.swift
//  NetworkTest
//
//  Created by david on 2/10/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

func == (lhs: User, rhs: User) -> Bool {
  return lhs.id == rhs.id
}

class User: Equatable {
  var login: String
  var id: String
  var avatar_url: String
  var avatar: UIImage?
  
  init?(json: JSON) {
    guard json["id"].string != nil else { return nil }
    
    self.login = json["login"].stringValue
    self.id = json["id"].stringValue
    self.avatar_url = json["avatar_url"].stringValue
  }
}
