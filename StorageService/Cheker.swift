//
//  Cheker.swift
//  StorageService
//
//  Created by Руслан Усманов on 13.11.2023.
//

import Foundation
class Checker {
    static let shared = Checker()
    
    private let log: String = "login"
    private let pass: String = "password"
    func check(login: String, password: String) -> Bool {
        login == log && password == pass ? true: false
    }
    private init(){}
}
