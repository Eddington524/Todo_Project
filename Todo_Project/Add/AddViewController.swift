//
//  AddViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/14/24.
//

import UIKit
import RealmSwift

protocol PassDataDelegate {
    func dateReceived(date:Date)
}

class AddViewController: BaseViewController, PassDataDelegate {
    
    func dateReceived(date: Date) {
        realDate = date
    }
    
    let todoRepository = TodosTableRepository()
    
    var newList: Results<Todotable>!
    
    var list = ["","마감일","태그","우선 순위","이미지 추가"]
    var subList:[String] = ["","","","","",""]
    
    var titleText: String = ""
    var memoText: String = ""
    
    var realDate: Date = Date()
//    var newTag: String = ""
    var newPriority: Int = 0
    
    let addTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(titleReceivedNotification), name: NSNotification.Name("TitleReceived"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dateReceivedNotification), name: NSNotification.Name("DateReceived"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tagReceivedNotification), name: NSNotification.Name("tagReceived"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(priorityReceivedNotification), name: NSNotification.Name("priorityReceived"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(memoReceivedNotification), name: NSNotification.Name("MemoReceived"), object: nil)
        
    }
    
    
    override func configureHierarchy() {
        view.addSubview(addTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let realm = try! Realm()
//        
//        newList = realm.objects(Todotable.self)
        newList = todoRepository.fetch()
        
//        print(newList)
    }
    
    override func configureView(){
        view.backgroundColor = .black
        addTableView.delegate = self
        addTableView.dataSource = self
        
        addTableView.register(InfosTableViewCell.self, forCellReuseIdentifier: InfosTableViewCell.identifier)
        addTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        configureNavigationBar()
        
        addTableView.backgroundColor = .clear
    }
    
    override func configureConstraints() {
        addTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as! TodoTableViewCell
         
            cell.selectionStyle = .default
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: InfosTableViewCell.identifier, for: indexPath) as! InfosTableViewCell
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator
            
            
            cell.titleLabel.text = list[indexPath.row]
            cell.subTitleLabel.text = subList[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = indexPath.row
        
        switch idx {
        case 1:
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
extension AddViewController {
    func configureNavigationBar() {
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.tintColor = .gray
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.title = "저장"
        rightBarButton.action = #selector(saveButtonClicked)
        rightBarButton.target = self
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.title = "취소"
        leftBarButton.action = #selector(cancelButtonClicked)
        leftBarButton.target = self
        navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonClicked() {
//        let realm = try! Realm()
        
        if title == "" {
            print("제목")
        }
        
//        print(realm.configuration.fileURL)
        
        let data = Todotable(title: titleText, memo: memoText, duedate: realDate, tag: subList[2], priority: newPriority)
        
//        try! realm.write{
//            realm.add(data)
//        }
        
        todoRepository.createItem(data)
        dismiss(animated: true)
        
    }
}

extension AddViewController {
    @objc func titleReceivedNotification(notification:NSNotification){
        if let value = notification.userInfo?["title"] as? String {
            titleText = value
        }
        addTableView.reloadData()
    }
    
    @objc func memoReceivedNotification(notification:NSNotification){
        if let value = notification.userInfo?["memo"] as? String {
            memoText = value
        }
        addTableView.reloadData()
    }
    
    @objc func dateReceivedNotification(notification:NSNotification){
        if let value = notification.userInfo?["newDate"] as? String {
            subList[1] = value
        }
        
        let vc = DateViewController()
        vc.delegate = self
        
        
        addTableView.reloadData()
    }
    
    @objc func tagReceivedNotification(notification:NSNotification){
        if let value = notification.userInfo?["tag"] as? String {
            subList[2] = value
        }
        addTableView.reloadData()
    }
    
    @objc func priorityReceivedNotification(notification:NSNotification){
        if let value = notification.userInfo?["priority"] as? String {
            subList[3] = value
        }
        if let value2 = notification.userInfo?["priorityIdx"] as? Int {
            newPriority = Int(value2) 
            print(newPriority)
        }
        addTableView.reloadData()
    }
    
}
