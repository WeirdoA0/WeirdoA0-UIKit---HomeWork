//
//  Coordinators.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.12.2023.
//

import UIKit
import StorageService


//MARK: Profile

class ProfileCoordinator: ProfileCoordinatorProtocol{

    var rootVC: UIViewController?
    
    var child: [Coordinator] = []
    
    func start() -> UIViewController {
        let loginVC = LogInViewController()
        var loginDelegate =  MyLoginFactory().makeLoginInspector()
        loginDelegate.presentProfile = { user in
            self.presentProfile(viewModel:
            ProfileViewModel(user: user)
            )
        }
        loginVC.loginDelegate = loginDelegate
        rootVC = loginVC
        
        
        return rootVC!
    }
    
    func presentProfile(viewModel: ProfileViewModelProtocol) {
        let profileVC = ProfileViewController()
        profileVC.viewModel = viewModel
        rootVC?.navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

//MARK: Feed


class FeedCoordinator: FeedCoordinatorProtocol{
    
    var rootVC: UIViewController?
    
    var child: [Coordinator] = []
    
    func start() -> UIViewController {
        let model =  FeedModel()
        let feedVC = FeedViewController()
        feedVC.model = model
        rootVC = feedVC
        
        return rootVC!
    }
}


//MARK: Main


class MainCoordinator: MainCoordinatorProtocol{
    var profileCoordinator: ProfileCoordinatorProtocol = ProfileCoordinator()
    
    var feedCoordinator: FeedCoordinatorProtocol = FeedCoordinator()
    
    
    var rootVC: UIViewController?
    
    var child: [Coordinator] = []
    
    func start() -> UIViewController {
        
        let profileVC = profileCoordinator.start()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: resizeImage(image: UIImage(named: "profile")!, targetSize: CGSize(width: 30, height: 30)), tag: 1)
        let feedVC = feedCoordinator.start()
        feedVC.tabBarItem =  UITabBarItem(title: "Feed", image: resizeImage(image: UIImage(named: "feed")!, targetSize: CGSize(width: 30, height: 30)), tag: 0)
        
        
        rootVC = UITabBarController()
        (rootVC as? UITabBarController)?.viewControllers = [feedVC, profileVC].map {
            UINavigationController(rootViewController: $0)
        }
        (rootVC as? UITabBarController)?.selectedIndex = 1
        
        [profileCoordinator, feedCoordinator].forEach({ [weak self] in
            self?.add(coordinator: $0)
        })
        
        return rootVC!
    }
    
    
}
