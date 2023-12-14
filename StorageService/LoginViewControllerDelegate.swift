//
//  LoginViewDelegate.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
public protocol LoginViewControllerDelegate {
    func check( login: String, password: String) -> Bool
    var presentProfile: ((User) -> Void)? { get set }
}
