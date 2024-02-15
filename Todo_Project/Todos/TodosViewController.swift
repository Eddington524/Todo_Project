//
//  TodosViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import UIKit
import SnapKit
import RealmSwift

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
