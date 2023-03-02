//
//  NavigationBarTransparent.swift
//  DolarBlue
//
//  Created by Max Ward on 12/08/2022.
//

import Foundation
import UIKit

class NavigationBarTransparent: UINavigationController{
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = appearance
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
