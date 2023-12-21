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
    private var backColor: UIColor?
    private var closure: () -> Void
    @objc func didTapOnBtn(){
        closure()
    }
    
    init(title: String, textColor: UIColor, backColor: UIColor?, closure: @escaping () -> Void = {} ) {
        self.title = title
        self.textColor = textColor
        self.backColor = backColor
        self.closure = closure
        
        super.init(frame: .zero)
        
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(self.title, for: .normal)
        self.backgroundColor = backColor
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.addTarget(self, action: #selector(didTapOnBtn), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private let btn = CustomButton(title: "", textColor: .blue, backColor: .white){
    
}
