//
//  FeedViewControler.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class FeedViewController: UIViewController{
    

    
    //MARK: StackView
    
    private lazy var btn: CustomButton = {
        let btn = CustomButton(title: "New Button", textColor: .white, backColor: .purple)
        btn.addTarget(self, action: #selector(openPostViewController), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btn1: CustomButton = {
        let btn = CustomButton(title: "New Button", textColor: .white, backColor: .purple)
        btn.addTarget(self, action: #selector(openPostViewController), for: .touchUpInside)
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
    //MARK: Subviews
    
    private lazy var label: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .none
        
        lbl.layer.cornerRadius = 18
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    private lazy var field: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGray4
        field.textColor = .black
        field.placeholder = "Print here"
        field.text = "word"
        
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        
        return field
    }()
    private lazy var checkGuessButton: CustomButton = {
        let btn = CustomButton(title: "Check", textColor: .white, backColor: .systemBlue)
        
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(nil, action: #selector(check), for: .touchUpInside)
        
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .white

        addSubviews()
        setConstraint()
//        setNotificationCenter()
        
    }
    
    //MARK: Objc
    
    @objc func openPostViewController() {
        let postViewController = PostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func check(){
        if FeedModel.check(word: field.text) {
            label.backgroundColor = .systemGreen
        } else {
            label.backgroundColor = .systemRed
        }
    }
//    @objc func notify(){
//        NotificationCenter.default.post(Notification(name: .btnPressed))
//    }
    //MARK: Private
    private func addSubviews(){
        [stackView, field, checkGuessButton, label].forEach({
            view.addSubview($0)
        })
    }
    
    
    private func setConstraint(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            stackView.heightAnchor.constraint(equalToConstant: 110),
            
            checkGuessButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor,constant: 32),
            checkGuessButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -48),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 36),
            
            field.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 16),
            field.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -16),
            field.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor,constant: -10),
            field.heightAnchor.constraint(equalToConstant: 48),
            
            label.leadingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor, constant: 16),
            label.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor),
            label.widthAnchor.constraint(equalTo: checkGuessButton.heightAnchor),
            label.topAnchor.constraint(equalTo: checkGuessButton.topAnchor)
            
        ])
    }
//    private func setNotificationCenter(){
//        NotificationCenter.default.addObserver(self, selector: #selector(check), name: .btnPressed, object: nil)
//    }
    
}


//extension Notification.Name {
//    static let btnPressed  = Notification.Name("btnPressed")
//}

