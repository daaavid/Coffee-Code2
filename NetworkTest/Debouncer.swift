//
//  Debouncer.swift
//  NetworkTest
//
//  Created by david on 2/14/17.
//  Copyright © 2017 david. All rights reserved.
//

import Foundation

class Debouncer {
  var timer: Timer?
  var delay: TimeInterval
  var callback: () -> ()
  
  init(delay: TimeInterval, callback: @escaping () -> ()) {
    self.delay = delay
    self.callback = callback
  }
  
  func call() {
    self.timer?.invalidate()
    self.timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
  }
  
  @objc private func fireTimer() {
    self.callback()
  }
}
