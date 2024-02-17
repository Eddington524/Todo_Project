//
//  TodosViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit
import SnapKit
import RealmSwift

enum sortType: String {
    case titleSort = "title"
    case duedateSort = "duedate"
    case prioritySort = "priority"
}

class TodosViewController: BaseViewController {

    let todosTableView: UITableView = {
       let table = UITableView()
        return table
    }()
    
    var list: Results<Todotable>!
    var keyType: String = "priority"
    var isAsc: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        list = realm.objects(Todotable.self).sorted(byKeyPath: keyType, ascending: false)
        
        configureNavigationBar()
    }
    

    override func configureHierarchy() {
        view.addSubview(todosTableView)
    }
    
    override func configureView(){
        todosTableView.rowHeight = 80
        todosTableView.delegate = self
        todosTableView.dataSource =  self
        todosTableView.register(UITableViewCell.self,forCellReuseIdentifier: "mainCell")
        todosTableView.backgroundColor = .lightGray
    }
    
    override func configureConstraints() {
        todosTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}

extension TodosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = todosTableView.dequeueReusableCell(withIdentifier: "mainCell")!
        
        let row = list[indexPath.row]
        cell.textLabel?.text = "\(row.title) | \(row.duedate)"
        
        return cell
    }
    
}

extension TodosViewController {
    func configureNavigationBar() {
        
        let titleSort = UIAction(title: "제목명순") { _ in
            self.sortedTable(type:.titleSort)
        }
        
        let duedateSort = UIAction(title: "마감일순") { _ in
            self.sortedTable(type:.duedateSort)
        }
        
        let prioritySort = UIAction(title: "우선순위 높은 것만 보기") { _ in
            self.sortedTable(type:.prioritySort)
            
        }
        
        
        lazy var buttonMenu = UIMenu(title: "정렬", children: [titleSort, duedateSort, prioritySort])

        navigationController?.navigationBar.tintColor = .blue
        
        let rightBarButton = UIButton()
        rightBarButton.menu = buttonMenu
        rightBarButton.showsMenuAsPrimaryAction = true
        rightBarButton.changesSelectionAsPrimaryAction = true
        
        rightBarButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        
    }
    
    func sortedTable(type:sortType){
        let realm = try! Realm()
        
        if type == .prioritySort {
            list = realm.objects(Todotable.self).where{
                $0.priority == 0
            }.sorted(byKeyPath: type.rawValue)
            
        }else{
            list = realm.objects(Todotable.self).sorted(byKeyPath: type.rawValue, ascending: true)
        }
        
        todosTableView.reloadData()
    }
}
