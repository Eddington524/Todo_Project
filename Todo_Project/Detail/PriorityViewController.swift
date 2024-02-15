//
//  PriorityViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    var priority: ((String) -> Void)?
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["highest", "high", "medium", "low"])
        control.addTarget(self, action: #selector(tappedSeg), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let idx = segmentedControl.selectedSegmentIndex
        if let newPriority = segmentedControl.titleForSegment(at: idx) {
            priority?(newPriority)
            
            NotificationCenter.default.post(name: NSNotification.Name("priorityReceived"), object: nil, userInfo: ["priority": newPriority])
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configureConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
    }
    
    @objc func tappedSeg() {
        guard let priority = priority else{
            print("우선순위를 선택해주세요!nil 입니다")
            return
        }
        navigationController?.popViewController(animated: true)
    }
}
