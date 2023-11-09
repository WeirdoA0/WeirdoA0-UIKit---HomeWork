//
//  UserService.swift
//  StorageService
//
//  Created by Руслан Усманов on 08.11.2023.
//

import UIKit
public protocol UserService {
    func authorizeUser(_ login: String) -> User?

}



public class User {
    public var login: String
    public var name: String
    public var status: String
    public var avatar: UIImage
    
    init(login: String, name: String, status: String, avatar: UIImage) {
        self.login = login
        self.name = name
        self.status = status
        self.avatar = avatar
    }
}

public class CurrentUserService: UserService {
    public func authorizeUser(_ login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
    let user: User
    init(user: User) {
        self.user = user
    }
    
}

public let dogeUser = CurrentUserService(user: User(
    login: "1234",
    name: "Doge",
    status: "Watching at you",
    avatar: UIImage(named: "doge")!)
)

public class TesttUserService: UserService {
    public func authorizeUser(_ login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
    let user: User
    init(user: User) {
        self.user = user
    }
    
}

public let developerUser = CurrentUserService(user: User(
    login: "dev1",
    name: "support",
    status: "",
    avatar: UIImage(named: "profile")!)
)
