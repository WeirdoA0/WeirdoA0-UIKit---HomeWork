//
//  LoginInspector.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
import UIKit
public struct LoginInspector: LoginViewControllerDelegate {

    
    
    public func singUp(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        CheckerService().singUp(login: login, password: password, completion: completion)
    }
    
    public func checkCredentials(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        CheckerService().checkCredentials(login: login, password: password, completion: completion)
    }
    

    
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
