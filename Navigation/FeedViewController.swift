//
//  FeedViewControler.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class FeedViewController: UIViewController{
    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("New Button", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .purple
        return btn
    }()
    
    private lazy var btn1: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("New Button", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .purple
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(btn)
        stackView.addArrangedSubview(btn1)
        
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        btn.addTarget(self, action: #selector(openPostViewController), for: .touchUpInside)
        btn1.addTarget(self, action: #selector(openPostViewController), for: .touchUpInside)
        
        setConstraint()
        
    }
    @objc func openPostViewController() {
        let postViewController = PostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func setConstraint(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
}



