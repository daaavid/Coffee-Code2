//
//  FavoritesHeaderView.swift
//  NetworkTest
//
//  Created by david on 2/14/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation
import UIKit

class FavoritesHeaderView: UIView {
  var label: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let label = UILabel(frame: frame)
    self.label = label
    label.text = "Favorites"
    label.textAlignment = .center
    self.addSubview(label)
    self.backgroundColor = UIColor.white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
