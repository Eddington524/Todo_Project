//
//  ReusableViewProtocol.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/14/24.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
