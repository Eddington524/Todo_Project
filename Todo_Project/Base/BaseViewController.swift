//
//  BaseViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
        view.backgroundColor = .black
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView(){
        
    }
    
    func configureConstraints() {
        
        
    }
    
    func showAlert(title: String, message: String, confirm: String, handler: @escaping (() -> Void)) {
        // 컨트롤러 먼저 만들어
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: confirm, style: .default) { _ in
            handler()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // 액션만들어서 add
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
  
}
