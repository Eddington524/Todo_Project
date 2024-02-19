//
//  InfoTableViewCell.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        return textField
    }()
    
    let memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메모"
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextField)
    }
    
    private func configureView(){
        
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        memoTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func configureConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(40)
        }
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.bottom.equalTo(contentView)
        }
    }
}

extension TodoTableViewCell {
    @objc func textFieldDidChange(_ sender: Any?){
        NotificationCenter.default.post(name: NSNotification.Name("TitleReceived"), object: nil, userInfo: ["title": titleTextField.text!])
        
        NotificationCenter.default.post(name: NSNotification.Name("MemoReceived"), object: nil, userInfo: ["memo": memoTextField.text!])
    }
}
