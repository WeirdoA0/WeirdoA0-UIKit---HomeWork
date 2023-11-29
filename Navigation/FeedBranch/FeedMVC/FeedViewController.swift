//
//  FeedViewControler.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import StorageService
class FeedViewController: UIViewController{
    
    override func loadView() {
        super.loadView()
        lazy var feedView = FeedView()
        feedView.delegate = self
        view = feedView
        
    }
}



extension FeedViewController: FeedViewDegelegate {
    func returnBool(word: String) -> Bool {
        let bool =  FeedModel.check(
            word: (view as! FeedView).returnWord()
        )
        return bool
    }

    func check(word: String)  {
        let bool =  FeedModel.check(
            word: (view as! FeedView).returnWord()
        )
        NotificationCenter.default.post(Notification(name: .btnEvent))
        print(bool)

    }
    
    func push() {
        let postViewController = PostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
        
    }
    
}
