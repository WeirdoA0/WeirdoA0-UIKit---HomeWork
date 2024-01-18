//
//  NetworkService.swift
//  NetworkService
//
//  Created by Руслан Усманов on 17.01.2024.
//

import Foundation


public struct NetworkService {
    public static func request(appConfig: AppConfiguration) {
        let session = URLSession.shared
        var request: URLRequest!
        switch appConfig{
            
        case .people(URL: let URL):
             request = URLRequest(url: URL)
        case .starship(URL: let URL):
             request = URLRequest(url: URL)
        case .planet(URL: let URL):
             request = URLRequest(url: URL)
        }
        
        let dataTask = session.dataTask(with: request){data,response,erorr in
            if let erorr = erorr {
                print("Conection error")
                print(erorr.localizedDescription)
                //Conection error
                //The Internet connection appears to be offline.
            }
            if let HTTPSResopnse = response as? HTTPURLResponse {
                switch HTTPSResopnse.statusCode {
                case 200:
                    do {
                        guard let data = data else { print("Failed to decode"); return }
                        let dataToPrint = String(decoding: data, as: UTF8.self)
                        let statusCode = HTTPSResopnse.statusCode
                        let headerFields = HTTPSResopnse.allHeaderFields
                        print(dataToPrint, statusCode, headerFields)
                    }
                    catch {
                        print("Failed to decode")
                        print(error.localizedDescription)
                    }
                                                                                               
                case 404:
                    print("Not found")
                default:
                    print("Unowed")
                }
            }
        }
        dataTask.resume()
    }
}


public enum AppConfiguration {
    
    case people(URL: URL)
    case starship(URL: URL)
    case planet(URL: URL)
    
    public init() {
        switch Array(0...2).randomElement() {
        case .none:
            fatalError("Unexpected error")
            
        case .some(let number):
            switch number {
            case 0:
                guard let url = URL(string: URLPool.people.rawValue) else { fatalError("Bad request")}
                self = .people(URL: url)
            case 1:
                guard let url = URL(string: URLPool.starship.rawValue) else { fatalError("Bad request")}
                self = .starship(URL: url)
            case 2:
                guard let url = URL(string: URLPool.planet.rawValue) else { fatalError("Bad request")}
                self = .planet(URL: url)
            default:
                fatalError("Unexpected error")
            }
        }
    }
    

    
}

public enum URLPool: String {
    case people = "https://swapi.dev/api/people/8"
    case starship = "https://swapi.dev/api/starships/3"
    case planet = "https://swapi.dev/api/planets/5"
}


//Conection error
//The Internet connection appears to be offline.
