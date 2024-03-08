//
//  UIVC+Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 06.03.2024.
//

import UIKit

extension UIViewController{
    func showAlertScreen(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}
