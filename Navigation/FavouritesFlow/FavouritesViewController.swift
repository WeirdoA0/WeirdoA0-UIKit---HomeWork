//
//  FavouritesViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 12.03.2024.
//

import Foundation
import UIKit
import StorageService

class FavoritesViewController: UIViewController {
    
    private let service: FavoriteService = FavoriteService()
    
    private lazy var tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray6
        table.register(PostTableViewCell.self, forCellReuseIdentifier: .cellReuseId)
        
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        layout()
    }
    
    //MARK: Private
    
    private func layout(){
        view.addSubview(tableView)
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16),
            
        ])
    }
    
}


//MARK: Extension

extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service.items.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseId, for: indexPath) as? PostTableViewCell else {
            print("Failed to load cell")
            fatalError()
        }
        
        let item = service.items[indexPath.row].post()
        
        cell.update(model: item)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            service.deleteItem(with: Int(service.items[indexPath.row].postId))
            tableView.reloadData()
        default:
            break
        }
    }

    
    
}

private extension String {
    static var cellReuseId = "PostCell"
}

extension FavoritesViewController: FavoriteDelegateProtocol {
    func addToFavorite(post: Post) {
        service.createNewPost(post: post)
        tableView.reloadData()
    }
    
    func deleteFromFavorite(id: Int) {
        service.deleteItem(with: id)
        tableView.reloadData()
    }
    
    
}
