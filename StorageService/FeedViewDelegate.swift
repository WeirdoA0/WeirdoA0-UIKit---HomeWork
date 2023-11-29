//
//  FeedViewDelegate.swift
//  StorageService
//
//  Created by Руслан Усманов on 28.11.2023.
//

import UIKit
@objc public protocol FeedViewDegelegate {
    func push()
    func check()
    func returnBool() -> Bool
}

