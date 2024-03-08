//
//  InitialScreenVC.swift
//  Navigation
//
//  Created by Руслан Усманов on 26.02.2024.
//

import UIKit
import KeychainAccess

class InitialScreenVC: UIViewController {
    
    private var screenState: ScreenState
    
    private let service = KeychainService()
    
    private var btnState: BtnState!
    
    //MARK: Subviews
    
    private lazy var passwordField: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 32)
        field.backgroundColor = .systemGray5
        field.delegate = self
        field.clearButtonMode = .whileEditing
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 10
        
        return field
    }()
    
    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .purple
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        
        return btn
    }()
    
    //MARK: LifeCycle
    init(screenState: ScreenState) {
        self.screenState = screenState
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        servie.resetPassword()
        setConstaints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkPasswordState()
    }
    
    //MARK: Private
    private func setConstaints() {
        [btn, passwordField].forEach{
            view.addSubview($0)
        }
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            passwordField.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: -30),
            passwordField.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            passwordField.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            
            btn.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: 20),
            btn.heightAnchor.constraint(equalToConstant: 48),
            btn.widthAnchor.constraint(equalToConstant: 210),
            btn.centerXAnchor.constraint(equalTo: safe.centerXAnchor)
            
        ])
    }
    
    private func checkPasswordState() {
        guard screenState == .defaultState else {
            self.btnState = .setPassword
            btn.setTitle(btnState.rawValue, for: .normal)
            return
        }
        service.getPassword(completion: { [weak self] password in
            guard let password = password else {
                self?.btnState = .setPassword
                return
            }
            self?.btnState = .enterPass
            self?.passwordField.text = password
            print(password)
        })
        btn.setTitle(btnState.rawValue, for: .normal)
    }
    
    private func openNextVC(){
        
        guard screenState == .defaultState else {
            self.dismiss(animated: true)
            return
        }
        
        let tabBar = UITabBarController()
        let mainVC = ViewController()
        let optionsVC = OptionsVC()
        
        mainVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "gallery-64"), tag: 0)
        optionsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settings-50"), tag: 1)
        
        tabBar.viewControllers = [mainVC, optionsVC]
        
        tabBar.selectedIndex = 0
        
        navigationController?.setViewControllers([tabBar], animated: true)
    }
    
    //MARK: Interactive
    
    @objc func btnPressed() {
        switch btnState {
        case .setPassword:
            service.setPassword(password: passwordField.text!) {bool in
                if bool {
                    btnState = .setPasswordVerify
                    passwordField.text = ""
                    btn.setTitle(btnState.rawValue, for: .normal)
                } else {
                    showAlertScreen(message: "Invalid password")
                }
            }
        case .setPasswordVerify:
            let bool = (service.verifyPassword(password: passwordField.text!))
            if bool {
                passwordField.text = ""
                openNextVC()
            } else {
                service.resetPassword()
                btnState = .setPassword
                btn.setTitle(btnState.rawValue, for: .normal)
                showAlertScreen(message: "Passwords do not match")
            }
                
        case .enterPass:
            if service.verifyPassword(password: passwordField.text!) {
                openNextVC()
            } else {
                showAlertScreen(message: "Wrong password")
                passwordField.text = ""
            }
        case .none:
            break
        }
    }
    
}

extension InitialScreenVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

 enum ScreenState {
    case defaultState
    case passwordChange
}

private enum BtnState: String {
    case setPassword = "Create Password"
    case setPasswordVerify = "Verify Password"
    case enterPass = "Enter with Password"
}
