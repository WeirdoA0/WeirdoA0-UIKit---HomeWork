//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Руслан Усманов on 09.02.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        backgroundColor = .systemBackground

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
        
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 75),
            image.widthAnchor.constraint(equalToConstant: 75)
            
        ])
    }
    internal func update(with image: UIImage){
        self.image.image = image
    }
}
