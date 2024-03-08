//
//  KeychainService.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.02.2024.
//

import KeychainAccess

class KeychainService {
    
    private let key = "Password"
    private let service = "Netology,Security"
    
    
    func setPassword(password: String, completion: (Bool) -> Void ) {
            let keychain = Keychain(service: service)
        
        guard password.count > 3 else {
            completion(false)
            return
        }
            keychain[key] = password
            completion(true)
    }
    
    func getPassword(completion: @escaping(String?) -> Void) {
        let keychain = Keychain(service: service)
        let password = keychain[key]
            completion(password)
    }
    func verifyPassword(password: String) -> Bool {
        let keychain = Keychain(service: service)
        if let truePassword = keychain[key]{
            return truePassword == password
        }
        return false
    }
    
    func resetPassword(){
        let keychain = Keychain(service: service)
        keychain[key] = nil
    }
    
}
