//
//  Options.swift
//  Navigation
//
//  Created by Руслан Усманов on 04.03.2024.
//

import Foundation

class Options{
    
    static var shared = Options()
    
    var order: OrderOfSort {
        let index = UserDefaults.standard.integer(forKey: "SortOrder")
        return OrderOfSort.allCases[index]
    }
    
    var reloadIsreqired: Bool = false
    
    private init(){}
    
    func saveNewOptions(index : Int){
        let defaults = UserDefaults.standard
        reloadIsreqired = true
        defaults.set(index, forKey: "SortOrder")
    }
    
}

enum OrderOfSort: String, CaseIterable {
    case direct = "Direct"
    case revers = "Reversed"
    case none = "Disabled"
    
    func next() -> Self {
           let all = Self.allCases
           let idx = all.firstIndex(of: self)!
           let next = all.index(after: idx)
           return all[next == all.endIndex ? all.startIndex : next]
       }
    func returnCaseIndex() -> Int {
        let all = Self.allCases
        return all.firstIndex(of: self)!
        
    }
}
