//
//  Post.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public let like: Int
    public let views: Int
}

// MARK: DATA

public extension Post {

    static func make() -> [Post] {
        let text: String = " От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStrore - пора начинать действовать!"
        let posts = [
            Post(author: "Нетология. Меряем карьеру через образование.", description: text , image: "netologyLogo", like: 766, views: 893)
            ]
        
        return posts
    }
}




 
