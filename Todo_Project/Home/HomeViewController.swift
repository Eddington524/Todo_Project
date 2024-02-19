//
//  ViewController.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/14/24.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable {
    case today
    case goingto
    case total
    case flag
    case complete
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .goingto:
            return "예정"
        case .total:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .complete:
            return "완료"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .goingto:
            return .systemRed
        case .total:
            return .systemGray
        case .flag:
            return .systemYellow
        case .complete:
            return .lightGray
        }
    }
    
    var symbolIcon: String {
        switch self {
        case .today:
            return "calendar"
        case .goingto:
            return "calendar"
        case .total:
            return "folder.circle"
        case .flag:
            return "flag.checkered.circle"
        case .complete:
            return "checkmark"
        }
    }
    
    var count: Int {
        switch self {
        case .today:
            return TodosTableRepository().fetchTodayCount().count
        case .goingto:
            return TodosTableRepository().fetchTodayCount().count
        case .total:
            return TodosTableRepository().fetch().count
        case .flag:
            return 0
        case .complete:
            return 0
        }
    }
}

class HomeViewController: BaseViewController {
//    final let list:[String:Int] = ["오늘":0, "예정":0, "전체":1, "깃발 표시":0, "완료됨":0]
//    var list = SectionType.AllCases()
    let list = SectionType.AllCases()
    
    let settingButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        return btn
    }()
    
    private let wholeTitle:UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = .boldSystemFont(ofSize: 32)
        return view
    }()
    
    private let categoryCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView())
        
        view.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return view
    }()
    
    let toolbar = UIToolbar()

    var items: [UIBarButtonItem] = []
    
    lazy var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    
    lazy var toolbarFirstItem = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(addButtonClicked))
    
    lazy var toolbarSecondItem = UIBarButtonItem(title: "목록추가", style: .plain, target: self, action: nil)
    //    let toolbarSecondItem = UIBarButtonItem(barButtonSystemItem: .add, target: HomeViewController.self, action: nil)
    
    
    override func configureHierarchy() {
        view.addSubview(settingButton)
        view.addSubview(wholeTitle)
        view.addSubview(categoryCollectionView)
        view.addSubview(toolbar)

    }
    
    override func configureView(){
        wholeTitle.text = "전체"
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        items.append(toolbarFirstItem)
        items.append(flexibleSpace)
        items.append(toolbarSecondItem)
        
        toolbar.setItems(items, animated: true)
    }
    
    override func configureConstraints() {
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        wholeTitle.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(wholeTitle.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        toolbar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = SectionType.allCases[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier , for: indexPath) as! CategoryCollectionViewCell
        cell.iconImageView.image = UIImage(systemName: item.symbolIcon)
        cell.countLabel.text = "\(item.count)"
        cell.categoryLabel.text = item.title
        cell.iconImageView.backgroundColor = item.backgroundColor
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }
    
    static func configureCollectionView() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize  = CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let nav = UINavigationController(rootViewController: TodosViewController())
        if indexPath.row == 2 {
           
            present(nav, animated: true)
        }
    }
}

extension HomeViewController {
    @objc func addButtonClicked() {
        let nav = UINavigationController(rootViewController: AddViewController())
        present(nav, animated: true)
    }
}
