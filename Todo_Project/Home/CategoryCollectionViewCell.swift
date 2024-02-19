//
//  HomeCollectionViewCell.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/14/24.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.tintColor = .white
       return view
    }()
    
    let categoryLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightGray
       return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 24)
       return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(countLabel)
    }
    
    override func configureView(){

        contentView.backgroundColor = .darkGray
    }
    
    override func configureConstraints() {

        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.size.equalTo(32)
            make.leading.equalTo(16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.centerX.equalTo(iconImageView)
            make.height.equalTo(16)
        }
        
        countLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(32)
        }
        
    }
    
   
}
