//
//  OptionsVC.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.02.2024.
//

import UIKit

class OptionsVC: UIViewController {
    
    private lazy var sortOrderOptionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(BtnPressed), for: .touchUpInside)
         
         return btn
     }()
    
    
    private lazy var changePassWordBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Change Password", for: .normal)
        btn.addTarget(self, action: #selector(BtnPressed), for: .touchUpInside)
        
        return btn
    }()
    private lazy var resetPasswordBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray5
        btn.setTitle("Reset Password", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(BtnPressed), for: .touchUpInside)
        
         return btn
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstaints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTitles()
    }
    
    private func setConstaints() {
        [sortOrderOptionButton, changePassWordBtn, resetPasswordBtn].forEach({
            view.addSubview($0)
        })
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            sortOrderOptionButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            sortOrderOptionButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            sortOrderOptionButton.heightAnchor.constraint(equalToConstant: 48),
            sortOrderOptionButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            
            changePassWordBtn.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            changePassWordBtn.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            changePassWordBtn.heightAnchor.constraint(equalToConstant: 48),
            changePassWordBtn.topAnchor.constraint(equalTo: sortOrderOptionButton.bottomAnchor, constant: 16),
            
            resetPasswordBtn.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            resetPasswordBtn.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            resetPasswordBtn.heightAnchor.constraint(equalToConstant: 48),
            resetPasswordBtn.topAnchor.constraint(equalTo: changePassWordBtn.bottomAnchor, constant: 32),
        ])
    }
    private func updateTitles(){
        sortOrderOptionButton.setTitle("Curent sorting order is: " + Options.shared.order.rawValue, for: .normal)
    }
    
    @objc func BtnPressed(btn: UIButton){
        switch btn {
        case sortOrderOptionButton:
            let options = Options.shared
            options.saveNewOptions(index: options.order.next().returnCaseIndex())
            updateTitles()
        case changePassWordBtn:
            let vc = InitialScreenVC(screenState: .passwordChange)
            present(vc, animated: true)
        case resetPasswordBtn:
            KeychainService().resetPassword()
            navigationController?.setViewControllers([InitialScreenVC(screenState: .defaultState)], animated: true)
            
        default:
            break
        }
    }
    
}



