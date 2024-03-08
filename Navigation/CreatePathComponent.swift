//
//  CreatePathComponent.swift
//  Navigation
//
//  Created by Руслан Усманов on 12.02.2024.
//

import Foundation


func  createPathComponent(in  items: [String], with naming: String, of type: String) -> String {
    
    
    var bool = true
    var k = 1
    while bool {
        bool = items.contains(where: {$0 == "\(naming)\(k).\(type)"})
        k += 1
        }
    return naming + String(k-1) + "." + type
    }

