//
//  LoginInspector.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
import UIKit
public struct LoginInspector: LoginViewControllerDelegate {

    
    public func check(login: String, password: String) throws -> Bool {
        let bool = Checker.shared.check(login: login, password: password)
        if bool == true {
            return bool
        } else {
            throw AppError.wrongLoginAndPassword
        }
    }
    
    public init(){}
}
