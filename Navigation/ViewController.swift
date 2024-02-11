//
//  ViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private var items: [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: documentPath)) ?? []
    }
    
    //MARK: Subviews
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()

    
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints  = false
        table.backgroundColor = .none
        table.delegate = self
        table.dataSource = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.getDescription() )
        return table
    }()
    
    private lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = .black
        
        btn.addTarget(self, action: #selector(btnPressed(button:)), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    //MARK: Private
    private func setConstraints(){
        [tableView, addButton].forEach{
            view.addSubview($0)
        }
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 64),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16),
            
            addButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 28),
            addButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 72),
            

            
        ])
    }
    
    //MARK: Interactive
    
    @objc private func btnPressed(button: UIButton){
        switch button{
        case addButton:
            self.present(imagePicker, animated: true)
        default:
            break
        }
    }
    

}

//MARK: Extension TableView


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try FileManager.default.removeItem(atPath: documentPath + "/\(items[indexPath.row])")
            }
            catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.getDescription(), for: indexPath) as? CustomTableViewCell else { fatalError()}
        if let image  = UIImage(contentsOfFile: documentPath + "/\(items[indexPath.row])") {
            cell.update(with: image)
        }
    
        return cell
    }
    
    //MARK: Extension ImagePicker
    
}

extension ViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let image = info[.originalImage] as? UIImage else { print("failed"); return }
        let url = documentURL.appendingPathComponent("iamge\(items.count+1).png")

        do {
            try image.pngData()?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
}

extension ViewController: UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
