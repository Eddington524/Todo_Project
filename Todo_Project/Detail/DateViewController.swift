//
//  DateViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit
import SnapKit

class DateViewController: BaseViewController {
    var newDate: ((String) -> Void)?
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = .now
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            let date = DateFormatter.convertDate("\(datePicker.date)")
            
            newDate?(date)
        
        NotificationCenter.default.post(name: NSNotification.Name("DateReceived"), object: nil, userInfo: ["newDate": date])
        }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureView(){
        
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
                    make.centerX.equalTo(view.safeAreaLayoutGuide)
                    make.height.equalTo(300)
                }
    }
    
}
