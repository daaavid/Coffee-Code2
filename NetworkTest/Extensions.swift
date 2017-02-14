//
//  UIImage Extensions.swift
//  NetworkTest
//
//  Created by david on 2/14/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire
import UIKit

extension UIImage {
  static func download(url: String, callback:@escaping (_ image: UIImage) -> ()) {
    Alamofire.request(url).responseImage { response in
      if let image = response.result.value {
        callback(image)
      }
    }
  }
}

extension Array where Element: Equatable {
  mutating func remove(element: Element) {
    if let index = self.index(of: element) {
      self.remove(at: index)
    }
  }
}
