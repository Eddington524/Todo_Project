//
//  TagViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit

class TagViewController: BaseViewController {
    
    let tagTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("tagReceived"), object: nil, userInfo: ["tag": tagTextField.text!])
    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureView(){
        super.configureView()
        tagTextField.placeholder = "나만의 태그를 입력해보세요"
        tagTextField.keyboardType = .default
        
    }
    
    override func configureConstraints() {
        tagTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
}
