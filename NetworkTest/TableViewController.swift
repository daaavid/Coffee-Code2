//
//  TableViewController.swift
//  NetworkTest
//
//  Created by david on 2/10/17.
//  Copyright © 2017 david. All rights reserved.
//

import UIKit

fileprivate enum Section: Int {
  case favorites
  case users
  static let count = 2
}

class TableViewController: UITableViewController, UISearchBarDelegate {
  
  private let reuseIdentifier = "UserCell"
  
  var favorites = [User]()
  var users = [User]()
  
  var searchBar: UISearchBar!
  var favoritesHeaderView: FavoritesHeaderView!
  
  lazy var debouncer: Debouncer = {
    Debouncer(delay: 0.5) { self.search() }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: "UserCell", bundle: nil)
    self.tableView.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    self.tableView.tableFooterView = UIView()
    
    let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
    self.searchBar = UISearchBar(frame: frame)
    self.favoritesHeaderView = FavoritesHeaderView(frame: frame)
    
    self.searchBar.delegate = self
    self.searchBar.placeholder = "Search users"
    self.searchBar.searchBarStyle = .minimal
    

  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    debouncer.call()
  }
  
  func search() {
    guard let text = self.searchBar.text, text != "" else {
      self.users.removeAll()
      self.tableView.reloadSections(IndexSet([1]), with: .automatic)
      return
    }
    
    APIController.instance.get(entity: "users", search: text) { results in
      if let items = results?["items"] as? [[String: Any]] {
        self.users = items.flatMap { User(JSON: $0) }
        self.tableView.reloadData()
      }
    }
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return Section.count
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch Section(rawValue: section)! {
    case .favorites: return self.favorites.count == 0 ? 0 : 44
    case .users: return 44
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch Section(rawValue: section)! {
    case .favorites:
      self.favoritesHeaderView.label.text = "Favorites: \(self.favorites.count)"
      return self.favoritesHeaderView
    case .users: return self.searchBar
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch Section(rawValue: section)! {
    case .favorites: return self.favorites.count
    case .users: return self.users.count
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! UserCell
    
    switch Section(rawValue: indexPath.section)! {
    case .favorites:
      cell.user = self.favorites[indexPath.row]
    case .users:
      cell.avatarImageView.image = nil
      cell.user = self.users[indexPath.row]
    }

    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.tableView.deselectRow(at: indexPath, animated: true)
    
    switch Section(rawValue: indexPath.section)! {
    case .favorites:
      self.favorites.remove(at: indexPath.row)
    case .users:
      let user = self.users[indexPath.row]
      self.favorites.append(user)
    }
    
    self.tableView.reloadSections(IndexSet([0]), with: .automatic)
  }
}
