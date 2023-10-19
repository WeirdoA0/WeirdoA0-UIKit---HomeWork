//
//  LogInViewController.swift.swift
//  Navigation
//
//  Created by Руслан Усманов on 06.10.2023.
//

import UIKit
class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: SubViews
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = view.bounds
        
        return view
    }()
    
    private lazy var VKLogo: UIImageView = {
        
        
        let image = UIImage(named: "logo")
        let newImage = UIImageView(image: image)
            
        newImage.translatesAutoresizingMaskIntoConstraints = false
        
        return newImage
    }()
    
    private lazy var loginField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.tintColor = .gray
        text.autocapitalizationType = .none
        
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 10
        
        text.keyboardType = UIKeyboardType.default
        text.clearButtonMode = .whileEditing
        text.returnKeyType = UIReturnKeyType.done
        text.contentVerticalAlignment = .center
        
        text.layer.masksToBounds = true
        text.placeholder = "Email or phone"
        
        text.delegate = self
        
        return text
    }()
    private lazy var passwordField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.tintColor = .gray
        text.autocapitalizationType = .none
        
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        
        text.keyboardType = UIKeyboardType.default
        text.clearButtonMode = .whileEditing
        text.returnKeyType = UIReturnKeyType.done
        text.contentVerticalAlignment = .center
        
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        
        text.delegate = self
        
        return text
    }()
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setBackgroundImage(UIImage(named: "pixel"), for: .normal)
        btn.setTitle("Log in", for: .normal)
        
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        btn.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        
        return btn
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setView()
        addSubviews()
        setConstaints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    // MARK: SetView
    private func setView() {
        view.backgroundColor = .white
    }
    //MARK: addSubviews
    private func addSubviews() {
        [loginField, loginButton, passwordField, VKLogo].forEach({
            contentView.addSubview($0)
        })
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        
    }
    //MARK: Constraints
    private func setConstaints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            
            VKLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            VKLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            VKLogo.heightAnchor.constraint(equalToConstant: 100),
            VKLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginField.heightAnchor.constraint(equalToConstant: 50),
            loginField.topAnchor.constraint(equalTo:  VKLogo.bottomAnchor, constant: 120),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    //MARK: KeyBoard Obervers
    private func addObservers() {
        let notiCenter = NotificationCenter.default
        
        notiCenter.addObserver(
            self,
            selector: #selector(keyBoardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        notiCenter.addObserver(
            self,
            selector: #selector(keyBoardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    @objc func keyBoardWillShow(_ notfication: Notification) {
        let height = (notfication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
        scrollView.contentInset.bottom += height ?? 0
    }
    @objc func keyBoardWillHide(_ notfication: Notification) {
        scrollView.contentInset.bottom =   0
    }
    @objc func logInPressed() {
        let profile = ProfileViewController()
        navigationController?.pushViewController(profile, animated: true)
    }
    
    
    private func removeObservers() {
        let notiCenter = NotificationCenter.default
        notiCenter.removeObserver(self)
    }
        
       internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            
            return true
        }
    }

