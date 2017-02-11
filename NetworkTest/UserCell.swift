//
//  UserCell.swift
//  NetworkTest
//
//  Created by david on 2/10/17.
//  Copyright © 2017 david. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
  @IBOutlet weak var loginLabel: UILabel!
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  var user: User! {
    didSet { self.didSet(user: user) }
  }
  
  func didSet(user: User) {
    self.loginLabel.text = user.login
    self.idLabel.text = user.id
    
    self.avatarImageView.layer.cornerRadius = 4
    self.avatarImageView.layer.masksToBounds = true
    
    UIImage.download(url: user.avatar_url) { image in
      self.avatarImageView.image = image
    }
  }
}
