//
//  FeedModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.11.2023.
//

import UIKit
class FeedModel {
    private static var secretWord: String = "word"
    static func check(word: String?) -> Bool {
        guard let actualWord = word else { return false }
        return actualWord == secretWord ? true : false
    }
}


