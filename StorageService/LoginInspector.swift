//
//  LoginInspector.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
public struct LoginInspector: LoginViewControllerDelegate {
    
    public var presentProfile: ((User) -> Void)?
    
    public func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)

    }
    public init(){}
}
