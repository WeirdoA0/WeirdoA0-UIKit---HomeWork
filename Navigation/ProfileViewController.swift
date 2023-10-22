//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class ProfileViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        
        table.showsVerticalScrollIndicator = true
        
        table.contentInset.bottom = navigationController?.navigationBar.frame.height ?? 0
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubviews()
        setConstraints()
        setTableView()
    }
    
    private func tuneView() {
        view.backgroundColor = .systemGray
    }
    private func addSubviews() {
        view.addSubview(tableView)
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    private func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Post")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeader")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    //MARK: DataSoirce
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        240
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeader") as? ProfileHeaderView else {
            fatalError()
        }
        
        header.update("Doge", "doge")
        
        return header
    }
    
}

    //MARK: Delegate

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Post.make().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as? PostTableViewCell else {
            fatalError("Fatal Error")
        }
        
        cell.update(model: Post.make()[indexPath.row])
        
        return cell
        
    }
}
