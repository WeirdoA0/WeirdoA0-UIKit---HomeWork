//
//  FavoriteService.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.03.2024.
//

import Foundation
import StorageService
import UIKit

class FavoriteService {
    
    private let coreDataService: CoreDataService = CoreDataService()
    
    private(set) var items: [PostCoreData] = []
    
    init(){
        fetch()
    }
    
    
    func createNewPost(post: Post) {
        
   
        
        if items.contains(where: {
            return Int($0.postId) == Int64(post.id)
        }) {
            print("Already have this post in favourite")
            return
        }
        
        let newPost = PostCoreData(context: coreDataService.context)
        newPost.author = post.author
        newPost.text = post.description
        newPost.likes = Int64(post.like)
        newPost.image = post.image
        newPost.views = Int64(post.views)
        newPost.postId = Int64(post.id)
        
        items.append(newPost)
        
        coreDataService.saveContext()
    }
    
    func fetch(){
        let request = PostCoreData.fetchRequest()
        do {
            items =  try coreDataService.context.fetch(request)
        } catch {
            print("Fetch error")
            assertionFailure()
        }
    }
    
    func deleteItem(with id: Int) {
        guard let item = items.first(where: {
            $0.postId == id
        }) else {
            return
        }
        items = items.filter({
            $0.postId != id
        })
        coreDataService.context.delete(item)
        coreDataService.saveContext()
    }

    
}
