//
//  NetworkService.swift
//  Navigation
//
//  Created by Руслан Усманов on 08.03.2024.
//

import Foundation
import RealmSwift

class NetworkService {
    
    
    
    private let url = URLRequest(url:  URL(string: "https://api.chucknorris.io/jokes/random")! )
    
    init() {}
    
    func loadJoke() {
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        guard let self = self else { return }
        if error != nil {
            fatalError()
        }
        if let HTTPSResponce = response as? HTTPURLResponse {
            switch HTTPSResponce.statusCode{
            case 200:
                guard let data = data else { return }
                let decoder = JSONDecoder()
                guard let joke = try? decoder.decode(Joke.self, from: data) else {
                    print("decode Error")
                    return
                }
                var bool = self.containsJoke(joke: joke)
                bool.toggle()
                if bool  {
                    self.uploadJoke(joke: joke)
                }
                
            default:
                break
            }
        }
            
    }
   task.resume()
}

     func fetch(completion: @escaping([RealmJoke]) -> Void){
        guard let realm = try? Realm() else {
            return
        }
        let jokes = realm.objects(RealmJoke.self).sorted(by: {
            $0.date < $1.date
        })
        completion(jokes)
    }
    
    func clearJokes(){
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write({
            realm.deleteAll()
        })
    }

    
    
    
    private func containsJoke(joke: Joke) -> Bool {
        guard let realm = try? Realm() else {
            return false
        }
        let id = joke.id
        let bool = realm.objects(RealmJoke.self).contains(where: {
            $0.id == id
        })
        return bool

    }
    

    private func uploadJoke(joke: Joke) {
        guard let realm = try? Realm() else {
            return
        }
        let newJoke = RealmJoke(joke: joke)
        try? realm.write({
            realm.add(newJoke)
        })
    }
}
