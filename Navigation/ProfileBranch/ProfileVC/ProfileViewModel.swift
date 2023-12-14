//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 05.12.2023.
//

import Foundation
import StorageService
import UIKit

protocol ProfileViewModelProtocol {
    var user: User { get set }
    var currentUserState: ((User) -> Void)? { get set}
    var profile: () -> Void { get set }
    
    func loadImage(closure: @escaping (UIImage) -> Void)
    func updateUser(userData: UserData)
}

class ProfileViewModel: ProfileViewModelProtocol {
    var profile: () -> Void = {}

    
    var user: StorageService.User
    var currentUserState: ((User) -> Void)?
    
    init(user: StorageService.User) {
        self.user = user
    }
    
    func loadImage(closure: @escaping (UIImage) -> Void) {
        let image = imagePool?.first ?? UIImage()
        imagePool?.removeFirst()
//        imageStorage.shared.takeImage(image: image)
        closure(image)
    }
    
    func updateUser(userData: UserData) {
        switch userData {
        case .status(let status):
            user.status = status
            currentUserState?(user)
        case .name( _ ):
            currentUserState?(user)
            break
        case .avatar( _):
            currentUserState?(user)
            break
        }
    }
    
    
}

enum UserData {
    case name(String)
    case avatar(UIImage)
    case status(String)
}

//class imageStorage{
//    static var shared = imageStorage()
//    var storage: [UIImage]?
//    private init(storage: [UIImage]? = []) {
//        self.storage = storage
//    }
//    func takeImage(image: UIImage){
//        storage?.append(image)
//    }
//}


private var imagePool: [UIImage]? = makeUIImageArray(type: .normal)
//private var expectedGallerySize = imagePool?.count ?? 0
