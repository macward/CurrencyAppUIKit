//
//  UITableViewExtensions.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Reload a UITableView content on the main thread
    func reloadIfNeeded() {
        if Thread.isMainThread {
            self.reloadData()
        } else {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
}
