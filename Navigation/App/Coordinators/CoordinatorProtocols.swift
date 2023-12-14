//
//  CoordinatorProtocols.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.12.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var child: [Coordinator] { get set }
    func start() -> UIViewController
    func add(coordinator: Coordinator)
    func remove(coordinator: Coordinator)
}

extension Coordinator{
    func add(coordinator: Coordinator) {
        child.append(coordinator
        )
    }
    func remove(coordinator: Coordinator){
        child = child.filter({
            $0 !== coordinator
        })
    }
}

protocol AppCoordinator: Coordinator{
    var rootVC: UIViewController? { get set }
}

protocol ProfileCoordinatorProtocol: AppCoordinator{
    func presentProfile(viewModel: ProfileViewModelProtocol)
}

protocol FeedCoordinatorProtocol: AppCoordinator {}

protocol MainCoordinatorProtocol: AppCoordinator{
    var profileCoordinator: ProfileCoordinatorProtocol { get set }
    var feedCoordinator: FeedCoordinatorProtocol { get set }
}
