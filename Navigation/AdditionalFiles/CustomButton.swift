//
//  CustomButton.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.11.2023.
//

import UIKit

class CustomButton: UIButton {
    
    private var title: String
    private var textColor: UIColor
    private var backColor: UIColor
    
    init(title: String, textColor: UIColor, backColor: UIColor) {
        self.title = title
        self.textColor = textColor
        self.backColor = backColor
        
        super.init(frame: .zero)
        
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(self.title, for: .normal)
        self.backgroundColor = backColor
        self.translatesAutoresizingMaskIntoConstraints  = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
