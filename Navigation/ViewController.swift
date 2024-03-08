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
       let array =  (try? FileManager.default.contentsOfDirectory(atPath: documentPath)) ?? []
        switch Options.shared.order {
        case .direct:
            return array.sorted(by: { $0 < $1 })
        case .revers:
            return array.sorted(by: { $0 > $1 })
        case .none:
            return array
        }
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

    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        print(documentPath)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadIfRequired()
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
    private func reloadIfRequired(){
        if Options.shared.reloadIsreqired {
            tableView.reloadData()
            Options.shared.reloadIsreqired = false
        }
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
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                do {
                    try FileManager.default.removeItem(atPath: documentPath + "/\(items[indexPath.row])")
                }
                catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
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
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
            
            guard let image = info[.originalImage] as? UIImage else {  return }
            let urlPart = createPathComponent(in: self.items, with: "image", of: "png")
            let url = documentURL.appendingPathComponent(urlPart)
                
                
                do {
                    try image.pngData()?.write(to: url)
                }
                catch {
                    print(error.localizedDescription)
                }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }
        }
    }



extension ViewController: UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
