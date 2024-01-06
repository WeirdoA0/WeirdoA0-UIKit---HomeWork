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
        let text3: String = "Rockstar скоро - в начале декабря, представят первый трейлер новой GTA 6, будем следить за этим"
        let text2: String = "Какой замечательный, такой зеленый, такой хороший запах - запах природы, рекомендую всем почаще выходить на природу, полезно не только ддя здоровья тела, но и духа"
        let text: String = " От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStrore - пора начинать действовать!"
        let posts = [
            Post(author: "Нетология. Меряем карьеру через образование.", description: text , image: "netologyLogo", like: 766, views: 893),
            Post(author: "Любитель природы", description: text2, image: "forest", like: 150, views: 637),
            Post(author: "Любитель игр", description: text3, image: "gta", like: 11105, views: 56742)
            ]
        
        return posts
    }
}




 
