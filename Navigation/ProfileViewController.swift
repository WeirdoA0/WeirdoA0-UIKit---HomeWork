//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class ProfileViewController: UIViewController {
    private let btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("New Button", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let profileHeaderView = ProfileHeaderView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setConstraints()
    }
    private func addSubviews(){
        view.addSubview(profileHeaderView)
        view.addSubview(btn)
        
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -0),
            profileHeaderView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 222),
            
            
            btn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            btn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
